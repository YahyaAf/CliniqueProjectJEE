package org.example.clinique.repository;

import org.example.clinique.model.Specialite;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface SpecialiteRepository {

    void save(Specialite specialite);
    Optional<Specialite> findById(UUID id);
    List<Specialite> findAll();
    void update(Specialite specialite);
    void delete(UUID id);
    List<Specialite> findByDepartmentId(UUID departmentId);
}
