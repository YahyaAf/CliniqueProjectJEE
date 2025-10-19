package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.MedicalNote;
import org.example.clinique.repository.MedicalNoteRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class MedicalNoteRepositoryImpl implements MedicalNoteRepository {

    @Override
    public void save(MedicalNote medicalNote) {
        executeInTransaction(em -> em.persist(medicalNote));
    }

    @Override
    public Optional<MedicalNote> findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            MedicalNote medicalNote = em.find(MedicalNote.class, id);
            return Optional.ofNullable(medicalNote);
        } finally {
            em.close();
        }
    }

    @Override
    public List<MedicalNote> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<MedicalNote> query = em.createQuery(
                    "SELECT mn FROM MedicalNote mn ORDER BY mn.createdAt DESC",
                    MedicalNote.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(MedicalNote medicalNote) {
        executeInTransaction(em -> em.merge(medicalNote));
    }

    @Override
    public void delete(UUID id) {
        executeInTransaction(em -> {
            MedicalNote medicalNote = em.find(MedicalNote.class, id);
            if (medicalNote != null) {
                em.remove(medicalNote);
            }
        });
    }

    @Override
    public Optional<MedicalNote> findByAppointmentId(UUID appointmentId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<MedicalNote> query = em.createQuery(
                    "SELECT mn FROM MedicalNote mn WHERE mn.appointment.id = :appointmentId",
                    MedicalNote.class
            );
            query.setParameter("appointmentId", appointmentId);
            List<MedicalNote> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } finally {
            em.close();
        }
    }

    @Override
    public List<MedicalNote> findByDoctorId(UUID doctorId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<MedicalNote> query = em.createQuery(
                    "SELECT mn FROM MedicalNote mn WHERE mn.appointment.doctor.id = :doctorId ORDER BY mn.createdAt DESC",
                    MedicalNote.class
            );
            query.setParameter("doctorId", doctorId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<MedicalNote> findByPatientId(UUID patientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<MedicalNote> query = em.createQuery(
                    "SELECT mn FROM MedicalNote mn WHERE mn.appointment.patient.id = :patientId ORDER BY mn.createdAt DESC",
                    MedicalNote.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
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