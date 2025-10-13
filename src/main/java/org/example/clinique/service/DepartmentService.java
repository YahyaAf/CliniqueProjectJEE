package org.example.clinique.service;

import org.example.clinique.mapper.DepartmentMapper;
import org.example.clinique.dto.DepartmentRequestDTO;
import org.example.clinique.dto.DepartmentResponseDTO;
import org.example.clinique.model.Department;
import org.example.clinique.repository.DepartmentRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class DepartmentService {
    private final DepartmentRepository departmentRepository;

    public DepartmentService(DepartmentRepository departmentRepository){
        this.departmentRepository = departmentRepository;
    }

    public DepartmentResponseDTO createDepartment(DepartmentRequestDTO dto){
        Department department = DepartmentMapper.toEntity(dto);
        departmentRepository.save(department);
        return DepartmentMapper.toResponseDTO(department);
    }

    public List<DepartmentResponseDTO> getAllDepartments(){
        return departmentRepository.findAll()
                .stream()
                .map(DepartmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public Optional<DepartmentResponseDTO> getDepartmentById(UUID id){
        return departmentRepository.findById(id)
                .map(DepartmentMapper::toResponseDTO);
    }

    public Optional<DepartmentResponseDTO> updateDepartment(UUID id, DepartmentRequestDTO dto){
        Optional<Department> departmentOpt = departmentRepository.findById(id);
        if(departmentOpt.isEmpty()){
            return Optional.empty();
        }
        Department department = departmentOpt.get();
        DepartmentMapper.updateEntityFromDTO(department,dto);
        departmentRepository.update(department);

        return Optional.of(DepartmentMapper.toResponseDTO(department));
    }

    public boolean deleteDepartment(UUID id){
        Optional<Department> departmentOpt = departmentRepository.findById(id);
        if(departmentOpt.isEmpty()){
            return false;
        }
        departmentRepository.delete(id);
        return true;
    }

    public Optional<DepartmentResponseDTO> getByName(String name){
        return departmentRepository.findByName(name)
                .map(DepartmentMapper::toResponseDTO);
    }



}
