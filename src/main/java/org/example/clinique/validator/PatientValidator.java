package org.example.clinique.validator;

import org.example.clinique.dto.PatientDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class PatientValidator {

    public List<String> validate(PatientDTO dto) {
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

        if (dto.getCin() == null || dto.getCin().length() != 8) {
            errors.add("CIN must contain 8 characters.");
        }

        if (dto.getDateOfBirth() == null) {
            errors.add("Date of birth is required.");
        }

        return errors;
    }
}
