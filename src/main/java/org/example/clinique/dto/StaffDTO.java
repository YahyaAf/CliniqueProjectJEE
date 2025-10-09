package org.example.clinique.dto;

public class StaffDTO {
    private String fullName;
    private String email;
    private String password;
    private String position;

    public StaffDTO() {}

    public StaffDTO(String fullName, String email, String password, String position) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.position = position;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
