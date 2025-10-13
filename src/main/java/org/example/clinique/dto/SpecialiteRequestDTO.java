package org.example.clinique.dto;

import java.util.UUID;

public class SpecialiteRequestDTO {
    private String name;
    private String description;
    private Boolean isActive;
    private UUID departmentId;

    public SpecialiteRequestDTO() {}

    public SpecialiteRequestDTO(String name, String description, Boolean isActive, UUID departmentId) {
        this.name = name;
        this.description = description;
        this.isActive = isActive;
        this.departmentId = departmentId;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public UUID getDepartmentId() { return departmentId; }
    public void setDepartmentId(UUID departmentId) { this.departmentId = departmentId; }
}
