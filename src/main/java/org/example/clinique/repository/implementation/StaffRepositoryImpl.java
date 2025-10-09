package org.example.clinique.repository.implementation;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import org.example.clinique.config.JpaUtil;
import org.example.clinique.model.Staff;
import org.example.clinique.model.User;
import org.example.clinique.repository.StaffRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class StaffRepositoryImpl implements StaffRepository {

    public void save(Staff staff){
        executeInTransaction(em -> em.persist(staff));
    }

    public Optional<Staff> findById(UUID id){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            Staff staff = em.find(Staff.class,id);
            return Optional.ofNullable(staff);
        }finally{
            em.close();
        }
    }

    public List<Staff> findAll(){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            TypedQuery<Staff> query = em.createQuery("SELECT s FROM Staff s", Staff.class);
            return query.getResultList();
        }finally {
            em.close();
        }
    }


    public void update(Staff staff){
        executeInTransaction(em -> em.merge(staff));
    }

    public void delete(UUID id){
        executeInTransaction(em->{
            Staff staff = em.find(Staff.class,id);
            if(staff != null){
                em.remove(staff);
            }
        });
    }

    public Optional<Staff> findByUser(User user){
        EntityManager em = JpaUtil.getEntityManager();
        try{
            TypedQuery<Staff> query = em.createQuery("SELECT s FROM Staff s WHERE s.user=:user", Staff.class);
            query.setParameter("user",user);
            List<Staff> result = query.getResultList();
            if(result.isEmpty()){
                return Optional.empty();
            }
            return Optional.of(result.get(0));
        }finally {
            em.close();
        }
    }

    private void executeInTransaction(EntityManagerConsumer action){
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            tx.begin();
            action.accept(em);
            tx.commit();
        }catch (Exception e){
            if(tx.isActive()){
                tx.rollback();
            }
            throw new RuntimeException("Database operation failed",e);
        }finally {
            em.close();
        }
    }

    private interface EntityManagerConsumer{
        void accept(EntityManager em);
    }


}
