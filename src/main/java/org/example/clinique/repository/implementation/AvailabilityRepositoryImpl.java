package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Availability;
import org.example.clinique.model.enums.DayOfWeekEnum;
import org.example.clinique.repository.AvailabilityRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class AvailabilityRepositoryImpl implements AvailabilityRepository {

    @Override
    public void save(Availability availability) {
        executeInTransaction(em -> em.persist(availability));
    }

    @Override
    public Optional<Availability> findById(UUID id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Availability availability = em.find(Availability.class, id);
            return Optional.ofNullable(availability);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Availability> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Availability> query = em.createQuery(
                    "SELECT a FROM Availability a", Availability.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Availability availability) {
        executeInTransaction(em -> em.merge(availability));
    }

    @Override
    public void delete(UUID id) {
        executeInTransaction(em -> {
            Availability availability = em.find(Availability.class, id);
            if (availability != null) {
                em.remove(availability);
            }
        });
    }

    @Override
    public List<Availability> findByDoctorId(UUID doctorId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Availability> query = em.createQuery(
                    "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId", Availability.class
            );
            query.setParameter("doctorId", doctorId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Availability> findByDayOfWeek(String dayOfWeek) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Availability> query = em.createQuery(
                    "SELECT a FROM Availability a WHERE a.dayOfWeek = :day", Availability.class
            );
            query.setParameter("day", Enum.valueOf(DayOfWeekEnum.class, dayOfWeek));
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
