package org.example.clinique.dto;

import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;

import java.time.LocalDate;
import java.util.UUID;

public class PatientResponseDTO {
    private UUID id;
    private String fullName;
    private String email;
    private Boolean isActive;
    private String cin;
    private LocalDate dateOfBirth;
    private Gender gender;
    private BloodType bloodType;
    private String insuranceNumber;

    public PatientResponseDTO(UUID id, String fullName, String email, Boolean isActive, String cin, LocalDate dateOfBirth, Gender gender, BloodType bloodType, String insuranceNumber){
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.isActive = isActive;
        this.cin = cin;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.bloodType = bloodType;
        this.insuranceNumber = insuranceNumber;
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean active) { isActive = active; }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }
    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Gender getGender() {
        return gender;
    }
    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public BloodType getBloodType() {
        return bloodType;
    }
    public void setBloodType(BloodType bloodType) {
        this.bloodType = bloodType;
    }

    public String getInsuranceNumber() {
        return insuranceNumber;
    }
    public void setInsuranceNumber(String insuranceNumber) {
        this.insuranceNumber = insuranceNumber;
    }
}
