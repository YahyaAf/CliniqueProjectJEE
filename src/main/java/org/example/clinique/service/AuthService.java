package org.example.clinique.service;

import org.example.clinique.dto.DoctorDTO;
import org.example.clinique.dto.PatientDTO;
import org.example.clinique.dto.StaffDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.mapper.DoctorMapper;
import org.example.clinique.mapper.PatientMapper;
import org.example.clinique.mapper.StaffMapper;
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
    private UserResponseLoginDTO currentUser;

    public AuthService(UserRepository userRepository,
                       PatientRepository patientRepository,
                       DoctorRepository doctorRepository,
                        StaffRepository staffRepository){
        this.userRepository = userRepository;
        this.patientRepository = patientRepository;
        this.doctorRepository = doctorRepository;
        this.staffRepository = staffRepository;
    }

    public void registerPatient(PatientDTO dto) {
        try {
            String hashedPassword = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
            User user = PatientMapper.toUserEntity(dto, hashedPassword);
            userRepository.saveAndFlush(user);

            Patient patient = PatientMapper.toPatientEntity(dto, user);
            patientRepository.save(patient);

            System.out.println("Patient registered successfully!");
        } catch (Exception e) {
            System.out.println("Error creating patient: " + e.getMessage());
        }
    }


    public void registerDoctor(DoctorDTO doctorDTO) {
        try {
            String hashedPassword = BCrypt.hashpw(doctorDTO.getPassword(), BCrypt.gensalt());

            User user = DoctorMapper.toUserEntity(doctorDTO, hashedPassword);
            userRepository.saveAndFlush(user);

            Doctor doctor = DoctorMapper.toDoctorEntity(doctorDTO, user);
            doctorRepository.save(doctor);

            System.out.println("Doctor registered successfully!");
        } catch (Exception e) {
            System.out.println("Error creating doctor: " + e.getMessage());
        }
    }

    public void registerStaff(StaffDTO staffDTO) {
        try {
            String hashedPassword = BCrypt.hashpw(staffDTO.getPassword(), BCrypt.gensalt());

            User user = StaffMapper.toUserEntity(staffDTO, hashedPassword);
            userRepository.saveAndFlush(user);

            Staff staff = StaffMapper.toStaffEntity(staffDTO, user);
            staffRepository.save(staff);

            System.out.println("Staff registered successfully!");
        } catch (Exception e) {
            System.out.println("Error creating staff: " + e.getMessage());
        }
    }

    public void registerAdmin(User user){
        try{
            user.setRole(Role.ADMIN);
            user.setPassword(hashPassword(user.getPassword()));
            userRepository.saveAndFlush(user);

            System.out.println("Admin added Success!");
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
            this.currentUser= new UserResponseLoginDTO(
                    user.getEmail(),
                    user.getFullName(),
                    user.getRole().name()
            );
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

    public UserResponseLoginDTO getCurrentUser(){
        return this.currentUser;
    }

    private String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    private boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
