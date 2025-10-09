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

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public Staff(){}

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
