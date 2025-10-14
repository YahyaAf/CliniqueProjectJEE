package org.example.clinique.validator;

import org.example.clinique.dto.DoctorRegisterRequestDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class DoctorValidator {

    public List<String> validate(DoctorRegisterRequestDTO dto) {
        List<String> errors = new ArrayList<>();

        if (dto.getFullName() == null || dto.getFullName().trim().isEmpty()) {
            errors.add("Full name is required.");
        }

        if (dto.getEmail() == null || !Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", dto.getEmail())) {
            errors.add("Email is not valid.");
        }

        if (dto.getPassword() == null || dto.getPassword().length() < 6) {
            errors.add("Password must be at least 6 characters long.");
        }

        if (dto.getMatricule() == null || dto.getMatricule().trim().isEmpty()) {
            errors.add("Matricule is required.");
        }

        if (dto.getSpecialiteId() == null) {
            errors.add("Specialité must be selected.");
        }

        return errors;
    }
}
