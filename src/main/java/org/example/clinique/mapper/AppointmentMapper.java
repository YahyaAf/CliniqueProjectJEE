package org.example.clinique.mapper;

import org.example.clinique.dto.AppointmentRequestDTO;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.Patient;
import org.example.clinique.model.Staff;

public class AppointmentMapper {

    // Conversion de RequestDTO vers Entity
    public static Appointment toEntity(AppointmentRequestDTO dto, Doctor doctor, Patient patient, Staff staff) {
        Appointment appointment = new Appointment();
        appointment.setAppointmentDate(dto.getAppointmentDate());
        appointment.setStartTime(dto.getStartTime());
        appointment.setEndTime(dto.getEndTime());
        appointment.setDoctor(doctor);
        appointment.setPatient(patient);
        appointment.setStaff(staff); // peut être null
        return appointment;
    }

    // Conversion de Entity vers ResponseDTO
    public static AppointmentResponseDTO toResponseDTO(Appointment appointment) {
        AppointmentResponseDTO dto = new AppointmentResponseDTO();

        // Info de base
        dto.setId(appointment.getId());
        dto.setAppointmentNumber(appointment.getAppointmentNumber());
        dto.setAppointmentDate(appointment.getAppointmentDate());
        dto.setStartTime(appointment.getStartTime());
        dto.setEndTime(appointment.getEndTime());
        dto.setStatus(appointment.getStatus().name());

        // Info Doctor
        if (appointment.getDoctor() != null) {
            dto.setDoctorId(appointment.getDoctor().getId());
            dto.setDoctorName(appointment.getDoctor().getUser().getFullName());

            // Specialty (si doctor a une specialité)
            if (appointment.getDoctor().getSpecialite() != null) {
                dto.setDoctorSpeciality(appointment.getDoctor().getSpecialite().getName());
            }
        }

        // Info Patient
        if (appointment.getPatient() != null) {
            dto.setPatientId(appointment.getPatient().getId());
            dto.setPatientName(appointment.getPatient().getUser().getFullName());
            dto.setPatientEmail(appointment.getPatient().getUser().getEmail());
        }

        // Info Staff (nullable)
        if (appointment.getStaff() != null) {
            dto.setStaffId(appointment.getStaff().getId());
            dto.setStaffName(appointment.getStaff().getUser().getFullName());
        }

        // Info Cancellation (nullable)
        dto.setCanceledBy(appointment.getCanceledBy());
        dto.setCanceledAt(appointment.getCanceledAt());
        dto.setCancellationReason(appointment.getCancellationReason());

        return dto;
    }
}