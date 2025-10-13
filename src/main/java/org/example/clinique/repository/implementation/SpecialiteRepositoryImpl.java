package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Specialite;
import org.example.clinique.repository.SpecialiteRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class SpecialiteRepositoryImpl implements SpecialiteRepository {

    public void save(Specialite specialite){
        executeInTransaction(em -> em.persist(specialite));
    }

    public Optional<Specialite> findById(UUID id){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            Specialite s = em.find(Specialite.class, id);
            return Optional.ofNullable(s);
        }finally {
            em.close();
        }
    }

    public List<Specialite> findAll(){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            TypedQuery<Specialite> query = em.createQuery("SELECT s FROM Specialite s", Specialite.class);
            return query.getResultList();
        }finally {
            em.close();
        }
    }

    public void update(Specialite specialite){
        executeInTransaction(em -> em.merge(specialite));
    }

    public void delete(UUID id){
        executeInTransaction(em -> {
            Specialite s = em.find(Specialite.class,id);
            if(s!=null){
                em.remove(s);
            }
        });
    }

    public List<Specialite> findByDepartmentId(UUID departmentId){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            TypedQuery<Specialite> query = em.createQuery(
                    "SELECT s FROM Specialite s WHERE s.department.id = :deptId", Specialite.class
            );
            query.setParameter("deptId", departmentId);
            return query.getResultList();
        }finally {
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
