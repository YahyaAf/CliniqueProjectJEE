package org.example.clinique.dto;

public class UserListDTO {
    private String fullName;
    private String email;
    private String role;

    public UserListDTO(String fullName, String email, String role) {
        this.fullName = fullName;
        this.email = email;
        this.role = role;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }
}
