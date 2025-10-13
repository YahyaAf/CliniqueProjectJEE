package org.example.clinique.repository;

import org.example.clinique.model.Department;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DepartmentRepository {
    void save(Department department);
    Optional<Department> findById(UUID id);
    List<Department> findAll();
    void update(Department department);
    void delete(UUID id);
    Optional<Department> findByName(String name);
}
