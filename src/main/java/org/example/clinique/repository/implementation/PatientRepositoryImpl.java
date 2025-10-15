package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Patient;
import org.example.clinique.model.User;
import org.example.clinique.repository.PatientRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class PatientRepositoryImpl implements PatientRepository {

    @Override
    public void save(Patient patient) {
        executeInTransaction(em -> em.persist(patient));
    }

    @Override
    public Optional<Patient> findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Patient patient = em.find(Patient.class, id);
            return Optional.ofNullable(patient);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Patient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p",
                    Patient.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Patient patient) {
        executeInTransaction(em -> em.merge(patient));
    }

    @Override
    public void delete(UUID id) {
        executeInTransaction(em -> {
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }
        });
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

    public Optional<Patient> findByUser(User user) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE p.user = :user",
                    Patient.class
            );
            query.setParameter("user", user);
            List<Patient> result = query.getResultList();
            if (result.isEmpty()) {
                return Optional.empty();
            }
            return Optional.of(result.get(0));
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Patient> findByUserId(UUID userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE p.user.id = :userId",
                    Patient.class
            );
            query.setParameter("userId", userId);
            List<Patient> result = query.getResultList();

            if (result.isEmpty()) {
                return Optional.empty();
            }
            return Optional.of(result.get(0));
        } finally {
            em.close();
        }
    }


    @FunctionalInterface
    private interface EntityManagerConsumer {
        void accept(EntityManager em);
    }
}
