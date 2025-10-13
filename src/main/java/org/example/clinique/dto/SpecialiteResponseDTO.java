package org.example.clinique.dto;

import java.util.UUID;

public class SpecialiteResponseDTO {
    private UUID id;
    private String name;
    private String description;
    private Boolean isActive;
    private String departmentName;

    public SpecialiteResponseDTO(){}

    public SpecialiteResponseDTO(UUID id, String name, String description, Boolean isActive, String departmentName) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.isActive = isActive;
        this.departmentName = departmentName;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean active) { isActive = active; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }

}
