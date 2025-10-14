package org.example.clinique.service;

import org.example.clinique.dto.*;
import org.example.clinique.mapper.DoctorMapper;
import org.example.clinique.mapper.PatientMapper;
import org.example.clinique.mapper.SpecialiteMapper;
import org.example.clinique.mapper.StaffMapper;
import org.example.clinique.model.*;
import org.example.clinique.model.enums.Role;
import org.example.clinique.repository.*;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class AuthService {
    private final UserRepository userRepository;
    private final PatientRepository patientRepository;
    private final DoctorRepository doctorRepository;
    private final StaffRepository staffRepository;
    private final SpecialiteRepository specialiteRepository;

    private UserResponseLoginDTO currentUser;

    public AuthService(UserRepository userRepository,
                       PatientRepository patientRepository,
                       DoctorRepository doctorRepository,
                       StaffRepository staffRepository,
                       SpecialiteRepository specialiteRepository) {
        this.userRepository = userRepository;
        this.patientRepository = patientRepository;
        this.doctorRepository = doctorRepository;
        this.staffRepository = staffRepository;
        this.specialiteRepository = specialiteRepository;
    }

    public void registerPatient(PatientRegisterRequestDTO dto) {
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


    public void registerDoctor(DoctorRegisterRequestDTO doctorRegisterRequestDTO) {
        try {
            String hashedPassword = BCrypt.hashpw(doctorRegisterRequestDTO.getPassword(), BCrypt.gensalt());

            User user = DoctorMapper.toUserEntity(doctorRegisterRequestDTO, hashedPassword);
            userRepository.saveAndFlush(user);

            Specialite specialite = null;
            if (doctorRegisterRequestDTO.getSpecialiteId() != null) {
                specialite = specialiteRepository.findById(doctorRegisterRequestDTO.getSpecialiteId())
                        .orElseThrow(() -> new RuntimeException("Spécialité introuvable"));
            }

            Doctor doctor = DoctorMapper.toDoctorEntity(doctorRegisterRequestDTO, user, specialite);

            doctorRepository.save(doctor);

            System.out.println("Doctor registered successfully!");
        } catch (Exception e) {
            System.out.println("Error creating doctor: " + e.getMessage());
        }
    }


    public void registerStaff(StaffRegisterRequestDTO staffRegisterRequestDTO) {
        try {
            String hashedPassword = BCrypt.hashpw(staffRegisterRequestDTO.getPassword(), BCrypt.gensalt());

            User user = StaffMapper.toUserEntity(staffRegisterRequestDTO, hashedPassword);
            userRepository.saveAndFlush(user);

            Staff staff = StaffMapper.toStaffEntity(staffRegisterRequestDTO, user);
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

    public List<UserListDTO> getAllUsers() {
        try {
            List<User> users = userRepository.findAll();

            return users.stream()
                    .map(user -> new UserListDTO(
                            user.getFullName(),
                            user.getEmail(),
                            user.getRole().name()
                    ))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            System.out.println("Error fetching users: " + e.getMessage());
            return List.of();
        }
    }

    public List<SpecialiteResponseDTO> getAllSpecialites() {
        return specialiteRepository.findAll()
                .stream()
                .map(SpecialiteMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public List<DoctorResponseDTO> getAllDoctors(){
        return doctorRepository.findAll()
                .stream()
                .map(DoctorMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public void updateDoctor(UUID doctorId, DoctorRegisterRequestDTO dto) {
        doctorRepository.findById(doctorId).ifPresent(existingDoctor -> {
            User user = existingDoctor.getUser();

            if (dto.getFullName() != null && !dto.getFullName().isEmpty()) {
                user.setFullName(dto.getFullName());
            }

            if (dto.getEmail() != null && !dto.getEmail().isEmpty()) {
                user.setEmail(dto.getEmail());
            }

            if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
                String hashedPassword = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
                user.setPassword(hashedPassword);
            }

            if (dto.getMatricule() != null && !dto.getMatricule().isEmpty()) {
                existingDoctor.setMatricule(dto.getMatricule());
            }

            if (dto.getSpecialiteId() != null) {
                Specialite specialite = specialiteRepository.findById(dto.getSpecialiteId())
                        .orElseThrow(() -> new RuntimeException("Spécialité introuvable"));
                existingDoctor.setSpecialite(specialite);
            }

            userRepository.update(user);
            doctorRepository.update(existingDoctor);
        });
    }

    public void deleteDoctor(UUID doctorId) {
        doctorRepository.findById(doctorId).ifPresent(doctor -> {
            User user = doctor.getUser();
            if (user != null) {
                user.setActive(false);
                userRepository.update(user);
            }
        });
    }

    public Optional<DoctorResponseDTO> getDoctorById(UUID id) {
        return doctorRepository.findById(id)
                .map(DoctorMapper::toResponseDTO);
    }

    public List<StaffResponseDTO> getAllStaffs(){
        return staffRepository.findAll()
                .stream()
                .map(StaffMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public void deleteStaff(UUID staffId){
        staffRepository.findById(staffId).ifPresent(staff -> {
            User user = staff.getUser();
            if(user != null){
                user.setActive(false);
                userRepository.update(user);
            }
        });
    }

    public void updateStaff(UUID staffId, StaffRegisterRequestDTO dto){
        staffRepository.findById(staffId).ifPresent(existingStaff -> {
            User user = existingStaff.getUser();

            if (dto.getFullName() != null && !dto.getFullName().isEmpty()) {
                user.setFullName(dto.getFullName());
            }

            if (dto.getEmail() != null && !dto.getEmail().isEmpty()) {
                user.setEmail(dto.getEmail());
            }

            if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
                String hashedPassword = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
                user.setPassword(hashedPassword);
            }

            if (dto.getPosition() != null && !dto.getPosition().isEmpty()) {
                existingStaff.setPosition(dto.getPosition());
            }

            userRepository.update(user);
            staffRepository.update(existingStaff);
        });
    }

    public Optional<StaffResponseDTO> getStaffById(UUID id){
        return staffRepository.findById(id)
                .map(StaffMapper::toResponseDTO);
    }

}
