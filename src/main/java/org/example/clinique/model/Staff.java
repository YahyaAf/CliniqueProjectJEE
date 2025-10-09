package org.example.clinique.model;

import jakarta.persistence.*;

import java.util.UUID;

@Entity
@Table(name="staff")
public class Staff {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private String position;

    @Column(name="user_id",nullable = false)
    private UUID userId;

    public Staff(){}

    public Staff(String position, UUID userId){
        this.position = position;
        this.userId = userId;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }
}
