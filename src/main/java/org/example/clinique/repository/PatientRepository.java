package org.example.clinique.repository;

import org.example.clinique.model.Patient;
import org.example.clinique.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PatientRepository {
    void save(Patient patient);
    Optional<Patient> findById(UUID id);
    List<Patient> findAll();
    void update(Patient patient);
    void delete(UUID id);
    Optional<Patient> findByUser(User user);
    Optional<Patient> findByUserId(UUID userId);
}
