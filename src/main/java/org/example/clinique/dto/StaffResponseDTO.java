package org.example.clinique.dto;

import java.util.UUID;

public class StaffResponseDTO {
    private UUID id;
    private String fullName;
    private String email;
    private Boolean isActive;
    private String position;

    public StaffResponseDTO(UUID id, String fullName, String email, Boolean isActive, String position){
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.isActive = isActive;
        this.position = position;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean active) { isActive = active; }

    public String getPosition(){
        return this.position;
    }
    public void setPosition(String position){
        this.position = position;
    }
}
