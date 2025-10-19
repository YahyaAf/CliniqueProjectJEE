package org.example.clinique.mapper;

import org.example.clinique.dto.MedicalNoteRequestDTO;
import org.example.clinique.dto.MedicalNoteResponseDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.model.MedicalNote;

public class MedicalNoteMapper {

    public static MedicalNote toEntity(MedicalNoteRequestDTO dto, Appointment appointment) {
        MedicalNote medicalNote = new MedicalNote();
        medicalNote.setSymptoms(dto.getSymptoms());
        medicalNote.setPrescription(dto.getPrescription());
        medicalNote.setNotes(dto.getNotes());
        medicalNote.setAppointment(appointment);
        return medicalNote;
    }

    public static void updateEntity(MedicalNote medicalNote, MedicalNoteRequestDTO dto) {
        if (dto.getSymptoms() != null) {
            medicalNote.setSymptoms(dto.getSymptoms());
        }
        if (dto.getPrescription() != null) {
            medicalNote.setPrescription(dto.getPrescription());
        }
        if (dto.getNotes() != null) {
            medicalNote.setNotes(dto.getNotes());
        }
        // Note: On ne change pas l'appointment lors d'un update
    }

    public static MedicalNoteResponseDTO toResponseDTO(MedicalNote medicalNote) {
        Appointment appointment = medicalNote.getAppointment();

        String appointmentNumber = (appointment != null) ? appointment.getAppointmentNumber() : null;
        String patientName = (appointment != null && appointment.getPatient() != null && appointment.getPatient().getUser() != null)
                ? appointment.getPatient().getUser().getFullName()
                : null;
        String doctorName = (appointment != null && appointment.getDoctor() != null && appointment.getDoctor().getUser() != null)
                ? appointment.getDoctor().getUser().getFullName()
                : null;
        String appointmentDate = (appointment != null && appointment.getAppointmentDate() != null)
                ? appointment.getAppointmentDate().toString()
                : null;

        return new MedicalNoteResponseDTO(
                medicalNote.getId(),
                medicalNote.getSymptoms(),
                medicalNote.getPrescription(),
                medicalNote.getNotes(),
                medicalNote.getCreatedAt(),
                (appointment != null) ? appointment.getId() : null,
                appointmentNumber,
                patientName,
                doctorName,
                appointmentDate
        );
    }
}