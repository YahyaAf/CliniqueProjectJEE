package org.example.clinique.validator;

import org.example.clinique.dto.StaffRegisterRequestDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class StaffValidator {
    public List<String> validate(StaffRegisterRequestDTO dto){
        List<String> errors = new ArrayList<>();

        if(dto.getFullName() == null || dto.getFullName().trim().isEmpty()){
            errors.add("Full name is required");
        }

        if (dto.getEmail() == null || !Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", dto.getEmail())) {
            errors.add("Invalid email format.");
        }

        if(dto.getPassword() == null || dto.getPassword().length()<6){
            errors.add("Password must be at least 6 characters long");
        }

        if(dto.getPosition() == null || dto.getPosition().trim().isEmpty()){
            errors.add("Position is required");
        }

        return errors;

    }

}
