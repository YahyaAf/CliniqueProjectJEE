package org.example.clinique.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public class TimeSlotDTO {

    private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;
    private UUID doctorId;
    private String doctorName;
    private boolean isAvailable;

    public TimeSlotDTO() {}

    public TimeSlotDTO(LocalDate date, LocalTime startTime, LocalTime endTime, UUID doctorId, String doctorName, boolean isAvailable) {
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.doctorId = doctorId;
        this.doctorName = doctorName;
        this.isAvailable = isAvailable;
    }

    // Getters and Setters

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public UUID getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(UUID doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }
}