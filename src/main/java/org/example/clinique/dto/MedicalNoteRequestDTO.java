package org.example.clinique.dto;

import java.util.UUID;

public class MedicalNoteRequestDTO {
    private String symptoms;
    private String prescription;
    private String notes;
    private UUID appointmentId;

    public MedicalNoteRequestDTO() {}

    public MedicalNoteRequestDTO(String symptoms, String prescription, String notes, UUID appointmentId) {
        this.symptoms = symptoms;
        this.prescription = prescription;
        this.notes = notes;
        this.appointmentId = appointmentId;
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

    public UUID getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(UUID appointmentId) {
        this.appointmentId = appointmentId;
    }
}