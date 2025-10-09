package org.example.clinique.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "matricule", nullable = false, unique = true)
    private String matricule;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "specialite_id")
    private UUID specialiteId;

    public Doctor() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public UUID getSpecialiteId() {
        return specialiteId;
    }

    public void setSpecialiteId(UUID specialiteId) {
        this.specialiteId = specialiteId;
    }
}
