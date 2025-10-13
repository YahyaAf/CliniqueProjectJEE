package org.example.clinique.mapper;

import org.example.clinique.dto.DepartmentRequestDTO;
import org.example.clinique.dto.DepartmentResponseDTO;
import org.example.clinique.model.Department;

public class DepartmentMapper {

    public static Department toEntity(DepartmentRequestDTO dto){
        Department department = new Department();
        department.setName(dto.getName());
        department.setDescription(dto.getDescription());
        department.setActive(dto.isActive() != null ? dto.isActive() : true);
        return department;
    }

    public static DepartmentResponseDTO toResponseDTO(Department department){
        return new DepartmentResponseDTO(
                department.getId(),
                department.getName(),
                department.getDescription(),
                department.getActive(),
                department.getCreatedAt()
        );
    }

    public static void updateEntityFromDTO(Department department, DepartmentRequestDTO dto) {
        if (dto.getName() != null) department.setName(dto.getName());
        if (dto.getDescription() != null) department.setDescription(dto.getDescription());
        if (dto.isActive() != null) department.setActive(dto.isActive());
    }
}
