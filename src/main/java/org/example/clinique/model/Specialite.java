package org.example.clinique.model;

import jakarta.persistence.*;

import java.util.UUID;

@Entity
@Table(name="specialites")
public class Specialite {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private String name;

    @Column
    private String description;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id")
    private Department department;

    public Specialite(){}

    public Specialite(String name, String description, Boolean isActive, Department department){
        this.name = name;
        this.description = description;
        this.isActive = isActive;
        this.department = department;

    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
}
