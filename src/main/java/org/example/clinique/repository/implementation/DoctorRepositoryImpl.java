package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.User;
import org.example.clinique.repository.DoctorRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class DoctorRepositoryImpl implements DoctorRepository {

    @Override
    public void save(Doctor doctor) {
        executeInTransaction(em -> em.persist(doctor));
    }

    @Override
    public Optional<Doctor> findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Doctor doctor = em.find(Doctor.class, id);
            return Optional.ofNullable(doctor);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Doctor> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> query = em.createQuery(
                    "SELECT d FROM Doctor d",
                    Doctor.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Doctor doctor) {
        executeInTransaction(em -> em.merge(doctor));
    }

    @Override
    public void delete(UUID id) {
        executeInTransaction(em -> {
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
            }
        });
    }

    @Override
    public Optional<Doctor> findByUser(User user) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Doctor> query = em.createQuery(
                    "SELECT d FROM Doctor d WHERE d.user = :user",
                    Doctor.class
            );
            query.setParameter("user", user);
            List<Doctor> result = query.getResultList();
            if (result.isEmpty()) {
                return Optional.empty();
            }
            return Optional.of(result.get(0));
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
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Database operation failed", e);
        } finally {
            em.close();
        }
    }

    @FunctionalInterface
    private interface EntityManagerConsumer {
        void accept(EntityManager em);
    }
}
