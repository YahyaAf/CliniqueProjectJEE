package org.example.clinique.repository;

import org.example.clinique.model.MedicalNote;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MedicalNoteRepository {

    void save(MedicalNote medicalNote);
    Optional<MedicalNote> findById(UUID id);
    List<MedicalNote> findAll();
    void update(MedicalNote medicalNote);
    void delete(UUID id);
    Optional<MedicalNote> findByAppointmentId(UUID appointmentId);
    List<MedicalNote> findByDoctorId(UUID doctorId);
    List<MedicalNote> findByPatientId(UUID patientId);
}