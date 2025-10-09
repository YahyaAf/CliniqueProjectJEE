package org.example.clinique.service;

import org.example.clinique.model.Doctor;
import org.example.clinique.model.Patient;
import org.example.clinique.model.Staff;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;
import org.example.clinique.repository.DoctorRepository;
import org.example.clinique.repository.PatientRepository;
import org.example.clinique.repository.StaffRepository;
import org.example.clinique.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Optional;

public class AuthService {
    private final UserRepository userRepository;
    private final PatientRepository patientRepository;
    private final DoctorRepository doctorRepository;
    private final StaffRepository staffRepository;
    private User currentUser;

    public AuthService(UserRepository userRepository,
                       PatientRepository patientRepository,
                       DoctorRepository doctorRepository,
                        StaffRepository staffRepository){
        this.userRepository = userRepository;
        this.patientRepository = patientRepository;
        this.doctorRepository = doctorRepository;
        this.staffRepository = staffRepository;
    }

    public void registerPatient(User user, Patient patient) {
        try {
            user.setRole(Role.PATIENT);
            user.setPassword(hashPassword(user.getPassword()));
            userRepository.saveAndFlush(user);
            patient.setUser(user);
            patientRepository.save(patient);

            System.out.println("Patient added successfully!");
        } catch (Exception e) {
            System.out.println("Error in creating patient: " + e.getMessage());
        }
    }


    public void registerDoctor(User user, Doctor doctor){
        try{
            user.setRole(Role.DOCTOR);
            user.setPassword(hashPassword(user.getPassword()));
            userRepository.saveAndFlush(user);

            doctor.setUser(user);
            doctor.setSpecialiteId(null);
            doctorRepository.save(doctor);
            System.out.println("Doctor added Success!");
        }catch(Exception e){
            System.out.println("Error in create doctor "+e.getMessage());
        }
    }

    public void registerStaff(User user, Staff staff){
        try{
            user.setRole(Role.STAFF);
            user.setPassword(hashPassword(user.getPassword()));
            userRepository.saveAndFlush(user);

            staff.setUser(user);
            staffRepository.save(staff);
            System.out.println("Staff added Success!");
        }catch(Exception e){
            System.out.println("Error in create staff "+e.getMessage());
        }
    }

    public boolean login(String email, String password){
        try{
            Optional<User> userOpt = userRepository.findByEmail(email);
            if(userOpt.isEmpty()){
                System.out.println("This user not found!!");
                return false;
            }
            User user = userOpt.get();
            if (!checkPassword(password, user.getPassword())) {
                System.out.println("Password is incorrect!");
                return false;
            }
            this.currentUser= user;
            System.out.println("User "+user.getFullName()+" is logged Success");
            return true;
        } catch (Exception e) {
            System.out.println("Error in login user "+e.getMessage());
            return false;
        }
    }

    public void logout(){
        if(currentUser!=null){
            System.out.println("User "+currentUser.getFullName()+" is logout Success ");
            currentUser= null;
        }else{
            System.out.println("No one logged");
        }
    }

    public User getCurrentUser(){
        return this.currentUser;
    }

    private String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    private boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
