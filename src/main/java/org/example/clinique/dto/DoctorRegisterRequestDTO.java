package org.example.clinique.dto;

import java.util.UUID;

public class DoctorRegisterRequestDTO {
    private String fullName;
    private String email;
    private String password;
    private String matricule;
    private UUID specialiteId;

    public DoctorRegisterRequestDTO() {}

    public DoctorRegisterRequestDTO(String fullName, String email, String password, String matricule, UUID specialiteId) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.matricule = matricule;
        this.specialiteId = specialiteId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public UUID getSpecialiteId() {
        return specialiteId;
    }

    public void setSpecialiteId(UUID specialiteId) {
        this.specialiteId = specialiteId;
    }
}
