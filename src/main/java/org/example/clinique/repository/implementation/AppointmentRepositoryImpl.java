package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Appointment;
import org.example.clinique.model.enums.AppointmentStatusEnum;
import org.example.clinique.repository.AppointmentRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class AppointmentRepositoryImpl implements AppointmentRepository {

    @Override
    public void save(Appointment appointment) {
        executeInTransaction(em -> em.persist(appointment));
    }

    @Override
    public Optional<Appointment> findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Appointment appointment = em.find(Appointment.class, id);
            return Optional.ofNullable(appointment);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a ORDER BY a.appointmentDate DESC, a.startTime DESC",
                    Appointment.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Appointment appointment) {
        executeInTransaction(em -> em.merge(appointment));
    }

    @Override
    public void delete(UUID id) {
        executeInTransaction(em -> {
            Appointment appointment = em.find(Appointment.class, id);
            if (appointment != null) {
                em.remove(appointment);
            }
        });
    }

    @Override
    public Optional<Appointment> findByAppointmentNumber(String appointmentNumber) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.appointmentNumber = :appointmentNumber",
                    Appointment.class
            );
            query.setParameter("appointmentNumber", appointmentNumber);
            List<Appointment> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByDoctorId(UUID doctorId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId ORDER BY a.appointmentDate DESC, a.startTime DESC",
                    Appointment.class
            );
            query.setParameter("doctorId", doctorId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByDoctorIdAndDate(UUID doctorId, LocalDate date) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.appointmentDate = :date ORDER BY a.startTime",
                    Appointment.class
            );
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByDoctorIdAndStatus(UUID doctorId, AppointmentStatusEnum status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.status = :status ORDER BY a.appointmentDate DESC",
                    Appointment.class
            );
            query.setParameter("doctorId", doctorId);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByPatientId(UUID patientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.patient.id = :patientId ORDER BY a.appointmentDate DESC, a.startTime DESC",
                    Appointment.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByPatientIdAndStatus(UUID patientId, AppointmentStatusEnum status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.status = :status ORDER BY a.appointmentDate DESC",
                    Appointment.class
            );
            query.setParameter("patientId", patientId);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByStatus(AppointmentStatusEnum status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.status = :status ORDER BY a.appointmentDate DESC",
                    Appointment.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByDate(LocalDate date) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.appointmentDate = :date ORDER BY a.startTime",
                    Appointment.class
            );
            query.setParameter("date", date);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Appointment> findByDateRange(LocalDate startDate, LocalDate endDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Appointment> query = em.createQuery(
                    "SELECT a FROM Appointment a WHERE a.appointmentDate BETWEEN :startDate AND :endDate ORDER BY a.appointmentDate, a.startTime",
                    Appointment.class
            );
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateStatus(UUID appointmentId, AppointmentStatusEnum newStatus) {
        executeInTransaction(em -> {
            Appointment appointment = em.find(Appointment.class, appointmentId);
            if (appointment != null) {
                appointment.setStatus(newStatus);
                em.merge(appointment);
            }
        });
    }

    @Override
    public void cancelAppointment(UUID appointmentId, String canceledBy, String reason) {
        executeInTransaction(em -> {
            Appointment appointment = em.find(Appointment.class, appointmentId);
            if (appointment != null) {
                appointment.setStatus(AppointmentStatusEnum.CANCELED);
                appointment.setCanceledBy(canceledBy);
                appointment.setCanceledAt(LocalDateTime.now());
                appointment.setCancellationReason(reason);
                em.merge(appointment);
            }
        });
    }

    @Override
    public boolean isDoctorAvailableAtTime(UUID doctorId, LocalDate date, LocalTime startTime, LocalTime endTime) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Appointment a WHERE a.doctor.id = :doctorId " +
                            "AND a.appointmentDate = :date " +
                            "AND a.status != :canceledStatus " +
                            "AND ((a.startTime < :endTime AND a.endTime > :startTime))",
                    Long.class
            );
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("startTime", startTime);
            query.setParameter("endTime", endTime);
            query.setParameter("canceledStatus", AppointmentStatusEnum.CANCELED);

            Long count = query.getSingleResult();
            return count == 0; // true = available, false = conflict
        } finally {
            em.close();
        }
    }

    @Override
    public long countByDoctorId(UUID doctorId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Appointment a WHERE a.doctor.id = :doctorId",
                    Long.class
            );
            query.setParameter("doctorId", doctorId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByPatientId(UUID patientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Appointment a WHERE a.patient.id = :patientId",
                    Long.class
            );
            query.setParameter("patientId", patientId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByStatus(AppointmentStatusEnum status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Appointment a WHERE a.status = :status",
                    Long.class
            );
            query.setParameter("status", status);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    private void executeInTransaction(EntityManagerConsumer action) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            action.accept(em);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new RuntimeException("Database operation failed", e);
        } finally {
            em.close();
        }
    }

    private interface EntityManagerConsumer {
        void accept(EntityManager em);
    }
}