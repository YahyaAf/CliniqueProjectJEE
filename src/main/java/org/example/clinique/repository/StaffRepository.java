package org.example.clinique.repository;

import org.example.clinique.model.Staff;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface StaffRepository {
    void save(Staff staff);
    Optional<Staff> findById(UUID id);
    List<Staff> findAll();
    void update(Staff staff);
    void delete(UUID id);
    Optional<Staff> findByUserId(UUID userId);
}
