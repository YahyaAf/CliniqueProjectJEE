package org.example.clinique.dto;

import java.util.UUID;

public class UserResponseLoginDTO {
    private UUID id;
    private String email;
    private String fullName;
    private String role;

    public UserResponseLoginDTO(UUID id, String email, String fullName, String role){
        this.id = id;
        this.email = email;
        this.fullName= fullName;
        this.role = role;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
