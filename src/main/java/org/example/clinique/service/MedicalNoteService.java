package org.example.clinique.service;

import org.example.clinique.dto.MedicalNoteRequestDTO;
import org.example.clinique.dto.MedicalNoteResponseDTO;
import org.example.clinique.mapper.MedicalNoteMapper;
import org.example.clinique.model.Appointment;
import org.example.clinique.model.MedicalNote;
import org.example.clinique.model.enums.AppointmentStatusEnum;
import org.example.clinique.repository.MedicalNoteRepository;
import org.example.clinique.repository.implementation.AppointmentRepositoryImpl;
import org.example.clinique.repository.implementation.MedicalNoteRepositoryImpl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class MedicalNoteService {

    private final MedicalNoteRepository medicalNoteRepository;
    private final AppointmentRepositoryImpl appointmentRepository;

    public MedicalNoteService() {
        this.medicalNoteRepository = new MedicalNoteRepositoryImpl();
        this.appointmentRepository = new AppointmentRepositoryImpl();
    }

    public MedicalNoteService(MedicalNoteRepository medicalNoteRepository, AppointmentRepositoryImpl appointmentRepository) {
        this.medicalNoteRepository = medicalNoteRepository;
        this.appointmentRepository = appointmentRepository;
    }

    /**
     * Créer une nouvelle medical note
     */
    public Optional<MedicalNoteResponseDTO> createMedicalNote(MedicalNoteRequestDTO dto) {
        // Validation: appointmentId requis
        if (dto.getAppointmentId() == null) {
            throw new RuntimeException("Appointment ID is required");
        }

        // Vérifier que l'appointment existe
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(dto.getAppointmentId());
        if (appointmentOpt.isEmpty()) {
            throw new RuntimeException("Appointment not found with id: " + dto.getAppointmentId());
        }

        Appointment appointment = appointmentOpt.get();

        // Validation: L'appointment doit être DONE
        if (appointment.getStatus() != AppointmentStatusEnum.DONE) {
            throw new RuntimeException("Medical notes can only be added to completed appointments");
        }

        // Validation: Vérifier qu'il n'existe pas déjà une medical note pour cet appointment
        Optional<MedicalNote> existingNote = medicalNoteRepository.findByAppointmentId(dto.getAppointmentId());
        if (existingNote.isPresent()) {
            throw new RuntimeException("A medical note already exists for this appointment");
        }

        // Validation: symptoms requis
        if (dto.getSymptoms() == null || dto.getSymptoms().trim().isEmpty()) {
            throw new RuntimeException("Symptoms are required");
        }

        // Créer et sauvegarder
        MedicalNote medicalNote = MedicalNoteMapper.toEntity(dto, appointment);
        medicalNoteRepository.save(medicalNote);

        return Optional.of(MedicalNoteMapper.toResponseDTO(medicalNote));
    }

    /**
     * Récupérer toutes les medical notes
     */
    public List<MedicalNoteResponseDTO> getAllMedicalNotes() {
        return medicalNoteRepository.findAll()
                .stream()
                .map(MedicalNoteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    /**
     * Récupérer une medical note par ID
     */
    public Optional<MedicalNoteResponseDTO> getMedicalNoteById(UUID id) {
        return medicalNoteRepository.findById(id)
                .map(MedicalNoteMapper::toResponseDTO);
    }

    /**
     * Récupérer medical note par appointment ID
     */
    public Optional<MedicalNoteResponseDTO> getMedicalNoteByAppointmentId(UUID appointmentId) {
        return medicalNoteRepository.findByAppointmentId(appointmentId)
                .map(MedicalNoteMapper::toResponseDTO);
    }

    /**
     * Récupérer toutes les medical notes d'un doctor
     */
    public List<MedicalNoteResponseDTO> getMedicalNotesByDoctorId(UUID doctorId) {
        return medicalNoteRepository.findByDoctorId(doctorId)
                .stream()
                .map(MedicalNoteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    /**
     * Récupérer toutes les medical notes d'un patient
     */
    public List<MedicalNoteResponseDTO> getMedicalNotesByPatientId(UUID patientId) {
        return medicalNoteRepository.findByPatientId(patientId)
                .stream()
                .map(MedicalNoteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    /**
     * Update une medical note
     */
    public Optional<MedicalNoteResponseDTO> updateMedicalNote(UUID id, MedicalNoteRequestDTO dto) {
        Optional<MedicalNote> medicalNoteOpt = medicalNoteRepository.findById(id);
        if (medicalNoteOpt.isEmpty()) {
            throw new RuntimeException("Medical note not found with id: " + id);
        }

        // Validation: symptoms requis
        if (dto.getSymptoms() != null && dto.getSymptoms().trim().isEmpty()) {
            throw new RuntimeException("Symptoms cannot be empty");
        }

        MedicalNote medicalNote = medicalNoteOpt.get();
        MedicalNoteMapper.updateEntity(medicalNote, dto);
        medicalNoteRepository.update(medicalNote);

        return Optional.of(MedicalNoteMapper.toResponseDTO(medicalNote));
    }

    /**
     * Supprimer une medical note
     */
    public boolean deleteMedicalNote(UUID id) {
        Optional<MedicalNote> medicalNoteOpt = medicalNoteRepository.findById(id);
        if (medicalNoteOpt.isEmpty()) {
            return false;
        }
        medicalNoteRepository.delete(id);
        return true;
    }

    /**
     * Récupérer les appointments DONE qui n'ont pas encore de medical note (pour le doctor)
     */
    public List<Appointment> getAppointmentsWithoutMedicalNotes(UUID doctorId) {
        List<Appointment> doneAppointments = appointmentRepository.findAll()
                .stream()
                .filter(apt -> apt.getDoctor().getId().equals(doctorId))
                .filter(apt -> apt.getStatus() == AppointmentStatusEnum.DONE)
                .collect(Collectors.toList());

        // Filter out appointments qui ont déjà une medical note
        return doneAppointments.stream()
                .filter(apt -> medicalNoteRepository.findByAppointmentId(apt.getId()).isEmpty())
                .sorted((a, b) -> b.getAppointmentDate().compareTo(a.getAppointmentDate()))
                .collect(Collectors.toList());
    }
}