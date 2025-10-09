package org.example.clinique.dto;

public class DoctorDTO {
    private String fullName;
    private String email;
    private String password;
    private String matricule;
    private String specialiteId;

    public DoctorDTO() {}

    public DoctorDTO(String fullName, String email, String password, String matricule, String specialiteId) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.matricule = matricule;
        this.specialiteId = specialiteId;
    }

    // Getters & Setters
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

    public String getSpecialiteId() {
        return specialiteId;
    }

    public void setSpecialiteId(String specialiteId) {
        this.specialiteId = specialiteId;
    }
}
