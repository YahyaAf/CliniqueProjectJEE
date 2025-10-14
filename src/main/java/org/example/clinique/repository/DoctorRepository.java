package org.example.clinique.repository;

import org.example.clinique.model.Doctor;
import org.example.clinique.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DoctorRepository {
    void save(Doctor doctor);
    Optional<Doctor> findById(UUID id);
    List<Doctor> findAll();
    void update(Doctor doctor);
    void delete(UUID id);
    Optional<Doctor> findByUser(User user);
    List<Doctor> findBySpecialiteId(UUID specialiteId);
}
