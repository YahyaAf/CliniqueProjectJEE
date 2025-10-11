package org.example.clinique.validator;

import org.example.clinique.dto.LoginDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class LoginValidator {

    public List<String> validate(LoginDTO loginDTO){
        List<String> errors = new ArrayList<>();

        if(loginDTO.getEmail() == null || loginDTO.getEmail().trim().isEmpty()){
            errors.add("Email is required");
        }else if(!Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", loginDTO.getEmail())){
            errors.add("Email invalid format");
        }

        if(loginDTO.getPassword() == null || loginDTO.getPassword().trim().isEmpty()){
            errors.add("Password is required");
        }else if(loginDTO.getPassword().length()<6){
            errors.add("Password must be at least 6 characters long");
        }
        return errors;
    }
}
