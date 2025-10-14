package org.example.clinique.dto;

import java.util.UUID;

public class DoctorResponseDTO {

    private UUID id;
    private String fullName;
    private String email;
    private String matricule;
    private String specialiteName;
    private String departmentName;

    public DoctorResponseDTO() {}

    public DoctorResponseDTO(UUID id, String fullName, String email, String matricule, String specialiteName, String departmentName) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.matricule = matricule;
        this.specialiteName = specialiteName;
        this.departmentName = departmentName;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public String getSpecialiteName() { return specialiteName; }
    public void setSpecialiteName(String specialiteName) { this.specialiteName = specialiteName; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}
