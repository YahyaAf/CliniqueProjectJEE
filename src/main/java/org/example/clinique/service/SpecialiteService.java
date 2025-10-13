package org.example.clinique.service;

import org.example.clinique.dto.SpecialiteRequestDTO;
import org.example.clinique.dto.SpecialiteResponseDTO;
import org.example.clinique.mapper.SpecialiteMapper;
import org.example.clinique.model.Department;
import org.example.clinique.model.Specialite;
import org.example.clinique.repository.DepartmentRepository;
import org.example.clinique.repository.SpecialiteRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class SpecialiteService {

    private final SpecialiteRepository specialiteRepository;
    private final DepartmentRepository departmentRepository;

    public SpecialiteService(SpecialiteRepository specialiteRepository, DepartmentRepository departmentRepository) {
        this.specialiteRepository = specialiteRepository;
        this.departmentRepository = departmentRepository;
    }

    public Optional<SpecialiteResponseDTO> createSpecialite(SpecialiteRequestDTO dto) {
        if (dto.getDepartmentId() == null) {
            return Optional.empty();
        }

        Optional<Department> departmentOpt = departmentRepository.findById(dto.getDepartmentId());
        if (departmentOpt.isEmpty()) {
            return Optional.empty();
        }

        Specialite specialite = SpecialiteMapper.toEntity(dto, departmentOpt.get());
        specialiteRepository.save(specialite);
        return Optional.of(SpecialiteMapper.toResponseDTO(specialite));
    }

    public List<SpecialiteResponseDTO> getAllSpecialites() {
        return specialiteRepository.findAll()
                .stream()
                .map(SpecialiteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public Optional<SpecialiteResponseDTO> getSpecialiteById(UUID id) {
        return specialiteRepository.findById(id)
                .map(SpecialiteMapper::toResponseDTO);
    }

    public Optional<SpecialiteResponseDTO> updateSpecialite(UUID id, SpecialiteRequestDTO dto) {
        Optional<Specialite> specialiteOpt = specialiteRepository.findById(id);
        if (specialiteOpt.isEmpty()) {
            return Optional.empty();
        }

        Department department = null;
        if (dto.getDepartmentId() != null) {
            department = departmentRepository.findById(dto.getDepartmentId()).orElse(null);
        }

        Specialite specialite = specialiteOpt.get();
        SpecialiteMapper.updateEntity(specialite, dto, department);
        specialiteRepository.update(specialite);

        return Optional.of(SpecialiteMapper.toResponseDTO(specialite));
    }

    public boolean deleteSpecialite(UUID id) {
        Optional<Specialite> specialiteOpt = specialiteRepository.findById(id);
        if (specialiteOpt.isEmpty()) {
            return false;
        }
        specialiteRepository.delete(id);
        return true;
    }

    public List<SpecialiteResponseDTO> getByDepartmentId(UUID departmentId) {
        return specialiteRepository.findByDepartmentId(departmentId)
                .stream()
                .map(SpecialiteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }
}
