package org.example.clinique.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class MedicalNoteResponseDTO {
    private UUID id;
    private String symptoms;
    private String prescription;
    private String notes;
    private LocalDateTime createdAt;
    private UUID appointmentId;
    private String appointmentNumber;
    private String patientName;
    private String doctorName;
    private String appointmentDate;

    public MedicalNoteResponseDTO() {}

    public MedicalNoteResponseDTO(UUID id, String symptoms, String prescription, String notes,
                                  LocalDateTime createdAt, UUID appointmentId, String appointmentNumber,
                                  String patientName, String doctorName, String appointmentDate) {
        this.id = id;
        this.symptoms = symptoms;
        this.prescription = prescription;
        this.notes = notes;
        this.createdAt = createdAt;
        this.appointmentId = appointmentId;
        this.appointmentNumber = appointmentNumber;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.appointmentDate = appointmentDate;
    }

    public String getFormattedCreatedAt() {
        if (createdAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            return createdAt.format(formatter);
        }
        return "";
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public UUID getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(UUID appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getAppointmentNumber() {
        return appointmentNumber;
    }

    public void setAppointmentNumber(String appointmentNumber) {
        this.appointmentNumber = appointmentNumber;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
}