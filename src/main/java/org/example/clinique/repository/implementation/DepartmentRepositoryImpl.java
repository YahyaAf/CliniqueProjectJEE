package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Department;
import org.example.clinique.repository.DepartmentRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class DepartmentRepositoryImpl implements DepartmentRepository {

    public void save(Department department){
        executeInTransaction(em -> em.persist(department));
    }

    public Optional<Department> findById(UUID id){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            Department dept = em.find(Department.class, id);
            return Optional.ofNullable(dept);
        }finally {
            em.close();
        }
    }

    public List<Department> findAll(){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            TypedQuery<Department> query = em.createQuery(
                    "SELECT d FROM Department d",
                    Department.class
            );
            return query.getResultList();
        }finally {
            em.close();
        }
    }

    public void update(Department department){
        executeInTransaction(em->em.merge(department));
    }

    public void delete(UUID id){
        executeInTransaction(em->{
            Department dept = em.find(Department.class, id);
            if(dept != null){
                em.remove(dept);
            }
        });
    }

    @Override
    public Optional<Department> findByName(String name) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Department> query = em.createQuery(
                    "SELECT d FROM Department d WHERE LOWER(d.name) = LOWER(:name)",
                    Department.class
            );
            query.setParameter("name", name);
            List<Department> result = query.getResultList();
            if (result.isEmpty()) return Optional.empty();
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
            if (tx.isActive()) tx.rollback();
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
