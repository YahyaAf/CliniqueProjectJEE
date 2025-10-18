package org.example.clinique.repository;

import org.example.clinique.model.Appointment;
import org.example.clinique.model.enums.AppointmentStatusEnum;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AppointmentRepository {

    void save(Appointment appointment);
    Optional<Appointment> findById(UUID id);
    List<Appointment> findAll();
    void update(Appointment appointment);
    void delete(UUID id);

    // Recherche par appointment number
    Optional<Appointment> findByAppointmentNumber(String appointmentNumber);

    // Recherche par Doctor
    List<Appointment> findByDoctorId(UUID doctorId);
    List<Appointment> findByDoctorIdAndDate(UUID doctorId, LocalDate date);
    List<Appointment> findByDoctorIdAndStatus(UUID doctorId, AppointmentStatusEnum status);

    // Recherche par Patient
    List<Appointment> findByPatientId(UUID patientId);
    List<Appointment> findByPatientIdAndStatus(UUID patientId, AppointmentStatusEnum status);

    // Recherche par Status
    List<Appointment> findByStatus(AppointmentStatusEnum status);

    // Recherche par Date
    List<Appointment> findByDate(LocalDate date);
    List<Appointment> findByDateRange(LocalDate startDate, LocalDate endDate);

    // Modifier le status (Cancel, Done, etc.)
    void updateStatus(UUID appointmentId, AppointmentStatusEnum newStatus);
    void cancelAppointment(UUID appointmentId, String canceledBy, String reason);

    // Vérifier disponibilité (important pour éviter les conflits)
    boolean isDoctorAvailableAtTime(UUID doctorId, LocalDate date, java.time.LocalTime startTime, java.time.LocalTime endTime);

    // Statistiques
    long countByDoctorId(UUID doctorId);
    long countByPatientId(UUID patientId);
    long countByStatus(AppointmentStatusEnum status);
}