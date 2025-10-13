package org.example.clinique.mapper;

import org.example.clinique.dto.SpecialiteRequestDTO;
import org.example.clinique.dto.SpecialiteResponseDTO;
import org.example.clinique.model.Department;
import org.example.clinique.model.Specialite;

public class SpecialiteMapper {

    public static Specialite toEntity(SpecialiteRequestDTO dto, Department department) {
        Specialite specialite = new Specialite();
        specialite.setName(dto.getName());
        specialite.setDescription(dto.getDescription());
        specialite.setIsActive(dto.getIsActive() != null ? dto.getIsActive() : true);
        specialite.setDepartment(department);
        return specialite;
    }

    public static void updateEntity(Specialite specialite, SpecialiteRequestDTO dto, Department department) {
        if (dto.getName() != null) specialite.setName(dto.getName());
        if (dto.getDescription() != null) specialite.setDescription(dto.getDescription());
        if (dto.getIsActive() != null) specialite.setIsActive(dto.getIsActive());
        if (department != null) specialite.setDepartment(department);
    }

    public static SpecialiteResponseDTO toResponseDTO(Specialite specialite) {
        String departmentName = (specialite.getDepartment() != null)
                ? specialite.getDepartment().getName()
                : null;

        return new SpecialiteResponseDTO(
                specialite.getId(),
                specialite.getName(),
                specialite.getDescription(),
                specialite.getIsActive(),
                departmentName
        );
    }
}
