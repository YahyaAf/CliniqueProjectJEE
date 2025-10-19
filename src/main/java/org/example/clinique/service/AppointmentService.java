package org.example.clinique.service;

import org.example.clinique.dto.AppointmentRequestDTO;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.dto.TimeSlotDTO;
import org.example.clinique.mapper.AppointmentMapper;
import org.example.clinique.model.Appointment;
import org.example.clinique.model.Availability;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.Patient;
import org.example.clinique.model.Staff;
import org.example.clinique.model.enums.AppointmentStatusEnum;
import org.example.clinique.repository.AppointmentRepository;
import org.example.clinique.repository.implementation.AppointmentRepositoryImpl;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;
import org.example.clinique.repository.implementation.PatientRepositoryImpl;
import org.example.clinique.repository.implementation.StaffRepositoryImpl;
import org.example.clinique.repository.implementation.AvailabilityRepositoryImpl;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.TextStyle;
import java.util.*;
import java.util.stream.Collectors;

public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final DoctorRepositoryImpl doctorRepository;
    private final PatientRepositoryImpl patientRepository;
    private final StaffRepositoryImpl staffRepository;
    private final AvailabilityRepositoryImpl availabilityRepository;

    public AppointmentService() {
        this.appointmentRepository = new AppointmentRepositoryImpl();
        this.doctorRepository = new DoctorRepositoryImpl();
        this.patientRepository = new PatientRepositoryImpl();
        this.staffRepository = new StaffRepositoryImpl();
        this.availabilityRepository = new AvailabilityRepositoryImpl();
    }

    // Création d'appointment (sans validation - validation sera dans Servlet)
    public AppointmentResponseDTO createAppointment(AppointmentRequestDTO dto) {
        Optional<Doctor> doctorOpt = doctorRepository.findById(dto.getDoctorId());
        if (doctorOpt.isEmpty()) {
            throw new RuntimeException("Doctor not found with id: " + dto.getDoctorId());
        }

        Optional<Patient> patientOpt = patientRepository.findById(dto.getPatientId());
        if (patientOpt.isEmpty()) {
            throw new RuntimeException("Patient not found with id: " + dto.getPatientId());
        }

        Staff staff = null;
        if (dto.getStaffId() != null) {
            Optional<Staff> staffOpt = staffRepository.findById(dto.getStaffId());
            if (staffOpt.isPresent()) {
                staff = staffOpt.get();
            }
        }

        Appointment appointment = AppointmentMapper.toEntity(dto, doctorOpt.get(), patientOpt.get(), staff);
        appointment.setAppointmentNumber(generateAppointmentNumber());
        appointment.setStatus(AppointmentStatusEnum.PLANNED);

        appointmentRepository.save(appointment);

        return AppointmentMapper.toResponseDTO(appointment);
    }

    // Récupération par ID
    public AppointmentResponseDTO getAppointmentById(UUID id) {
        return appointmentRepository.findById(id)
                .map(AppointmentMapper::toResponseDTO)
                .orElseThrow(() -> new RuntimeException("Appointment not found with id: " + id));
    }

    // Récupération par numéro
    public AppointmentResponseDTO getAppointmentByNumber(String appointmentNumber) {
        return appointmentRepository.findByAppointmentNumber(appointmentNumber)
                .map(AppointmentMapper::toResponseDTO)
                .orElseThrow(() -> new RuntimeException("Appointment not found with number: " + appointmentNumber));
    }

    // Tous les appointments
    public List<AppointmentResponseDTO> getAllAppointments() {
        return appointmentRepository.findAll()
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Doctor ID
    public List<AppointmentResponseDTO> getAppointmentsByDoctorId(UUID doctorId) {
        return appointmentRepository.findByDoctorId(doctorId)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Doctor ID et Date
    public List<AppointmentResponseDTO> getAppointmentsByDoctorIdAndDate(UUID doctorId, LocalDate date) {
        return appointmentRepository.findByDoctorIdAndDate(doctorId, date)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Doctor ID et Status
    public List<AppointmentResponseDTO> getAppointmentsByDoctorIdAndStatus(UUID doctorId, AppointmentStatusEnum status) {
        return appointmentRepository.findByDoctorIdAndStatus(doctorId, status)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Patient ID
    public List<AppointmentResponseDTO> getAppointmentsByPatientId(UUID patientId) {
        return appointmentRepository.findByPatientId(patientId)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Patient ID et Status
    public List<AppointmentResponseDTO> getAppointmentsByPatientIdAndStatus(UUID patientId, AppointmentStatusEnum status) {
        return appointmentRepository.findByPatientIdAndStatus(patientId, status)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Status
    public List<AppointmentResponseDTO> getAppointmentsByStatus(AppointmentStatusEnum status) {
        return appointmentRepository.findByStatus(status)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par Date
    public List<AppointmentResponseDTO> getAppointmentsByDate(LocalDate date) {
        return appointmentRepository.findByDate(date)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Par plage de dates
    public List<AppointmentResponseDTO> getAppointmentsByDateRange(LocalDate startDate, LocalDate endDate) {
        return appointmentRepository.findByDateRange(startDate, endDate)
                .stream()
                .map(AppointmentMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    // Annuler un appointment
    public void cancelAppointment(UUID appointmentId, String canceledBy, String reason) {
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);
        if (appointmentOpt.isEmpty()) {
            throw new RuntimeException("Appointment not found with id: " + appointmentId);
        }

        Appointment appointment = appointmentOpt.get();

        if (appointment.getStatus() == AppointmentStatusEnum.DONE) {
            throw new RuntimeException("Cannot cancel a completed appointment");
        }

        if (appointment.getStatus() == AppointmentStatusEnum.CANCELED) {
            throw new RuntimeException("Appointment is already canceled");
        }

        appointmentRepository.cancelAppointment(appointmentId, canceledBy, reason);
    }

    // Marquer comme terminé (DONE)
    public void markAppointmentAsDone(UUID appointmentId) {
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);
        if (appointmentOpt.isEmpty()) {
            throw new RuntimeException("Appointment not found with id: " + appointmentId);
        }

        Appointment appointment = appointmentOpt.get();

        if (appointment.getStatus() == AppointmentStatusEnum.CANCELED) {
            throw new RuntimeException("Cannot mark a canceled appointment as done");
        }

        if (appointment.getStatus() == AppointmentStatusEnum.DONE) {
            throw new RuntimeException("Appointment is already marked as done");
        }

        appointmentRepository.updateStatus(appointmentId, AppointmentStatusEnum.DONE);
    }

    // Suppression
    public void deleteAppointment(UUID appointmentId) {
        appointmentRepository.delete(appointmentId);
    }

    public List<TimeSlotDTO> getAvailableTimeSlots(UUID doctorId, LocalDate date) {
        // Constants pour validation
        final int BUFFER = 5; // minutes
        final LocalTime LUNCH_START = LocalTime.of(12, 0);
        final LocalTime LUNCH_END = LocalTime.of(13, 0);

        // 1. Récupérer le jour de la semaine
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        String dayName = dayOfWeek.getDisplayName(TextStyle.FULL, Locale.ENGLISH).toUpperCase();

        // 2. Récupérer les availabilities du doctor pour ce jour
        List<Availability> availabilities = availabilityRepository.findByDoctorId(doctorId).stream()
                .filter(av -> av.getDayOfWeek().name().equals(dayName) && av.isAvailable())
                .collect(Collectors.toList());

        if (availabilities.isEmpty()) {
            return Collections.emptyList();
        }

        // 3. Récupérer les appointments existants (triés par heure)
        List<Appointment> existingAppointments = appointmentRepository.findByDoctorIdAndDate(doctorId, date).stream()
                .filter(app -> app.getStatus() != AppointmentStatusEnum.CANCELED)
                .sorted((a, b) -> a.getStartTime().compareTo(b.getStartTime()))
                .collect(Collectors.toList());

        // 4. Récupérer le nom du doctor
        Optional<Doctor> doctorOpt = doctorRepository.findById(doctorId);
        String doctorName = doctorOpt.map(d -> d.getUser().getFullName()).orElse("Unknown");

        // 5. Générer les slots pour chaque availability
        List<TimeSlotDTO> availableSlots = new ArrayList<>();

        for (Availability availability : availabilities) {
            LocalTime availabilityStart = availability.getStartTime();
            LocalTime availabilityEnd = availability.getEndTime();
            int slotDuration = availability.getSlotDuration();

            // Commencer du début de l'availability
            LocalTime currentTime = availabilityStart;
            int appointmentIndex = 0;

            while (currentTime.plusMinutes(slotDuration).isBefore(availabilityEnd) ||
                    currentTime.plusMinutes(slotDuration).equals(availabilityEnd)) {

                // Vérifier s'il y a un appointment à cette heure
                boolean slotOccupied = false;

                if (appointmentIndex < existingAppointments.size()) {
                    Appointment nextApt = existingAppointments.get(appointmentIndex);
                    LocalTime aptStart = nextApt.getStartTime();
                    LocalTime aptEnd = nextApt.getEndTime();

                    // Si on arrive à un appointment existant DANS cette availability
                    if ((aptStart.isAfter(availabilityStart) || aptStart.equals(availabilityStart)) &&
                            (aptEnd.isBefore(availabilityEnd) || aptEnd.equals(availabilityEnd))) {

                        if (currentTime.equals(aptStart) ||
                                (currentTime.isBefore(aptStart) && currentTime.plusMinutes(slotDuration).isAfter(aptStart))) {

                            // Afficher le slot comme OCCUPIED
                            TimeSlotDTO occupiedSlot = new TimeSlotDTO(
                                    date,
                                    aptStart,
                                    aptEnd,
                                    doctorId,
                                    doctorName,
                                    false // not available
                            );
                            availableSlots.add(occupiedSlot);

                            // Sauter au temps APRÈS l'appointment + buffer
                            currentTime = aptEnd.plusMinutes(BUFFER);
                            appointmentIndex++;
                            slotOccupied = true;
                        }
                    }
                }

                if (!slotOccupied) {
                    LocalTime slotStart = currentTime;
                    LocalTime slotEnd = currentTime.plusMinutes(slotDuration);

                    // Vérifier si le slot dépasse l'availability end
                    if (slotEnd.isAfter(availabilityEnd)) {
                        break;
                    }

                    // Vérifier lunch break (12h-13h)
                    boolean overlapsLunch = !(slotEnd.isBefore(LUNCH_START) ||
                            slotEnd.equals(LUNCH_START) ||
                            slotStart.isAfter(LUNCH_END) ||
                            slotStart.equals(LUNCH_END));

                    if (overlapsLunch) {
                        // Sauter la pause déjeuner
                        if (currentTime.isBefore(LUNCH_START)) {
                            currentTime = LUNCH_END;
                        } else {
                            currentTime = currentTime.plusMinutes(slotDuration + BUFFER);
                        }
                    } else {
                        // Créer un slot AVAILABLE
                        TimeSlotDTO slot = new TimeSlotDTO(
                                date,
                                slotStart,
                                slotEnd,
                                doctorId,
                                doctorName,
                                true // available
                        );
                        availableSlots.add(slot);

                        // Avancer de slotDuration + buffer
                        currentTime = slotEnd.plusMinutes(BUFFER);
                    }
                }
            }
        }

        return availableSlots;
    }

    // Vérifier si doctor disponible
    public boolean isDoctorAvailable(UUID doctorId, LocalDate date, LocalTime startTime, LocalTime endTime) {
        return appointmentRepository.isDoctorAvailableAtTime(doctorId, date, startTime, endTime);
    }

    // Générer un numéro d'appointment unique
    public String generateAppointmentNumber() {
        String prefix = "APT";
        String timestamp = String.valueOf(System.currentTimeMillis());
        String randomPart = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        return prefix + "-" + timestamp.substring(timestamp.length() - 6) + "-" + randomPart;
    }

    // Ajouter cette méthode dans AppointmentService
    public void cancelAppointment(UUID appointmentId) {
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);

        if (appointmentOpt.isEmpty()) {
            throw new RuntimeException("Appointment not found with id: " + appointmentId);
        }

        Appointment appointment = appointmentOpt.get();

        // Vérifier que l'appointment n'est pas déjà annulé ou complété
        if (appointment.getStatus() == AppointmentStatusEnum.CANCELED) {
            throw new RuntimeException("Appointment is already cancelled");
        }

        if (appointment.getStatus() == AppointmentStatusEnum.CANCELED) {
            throw new RuntimeException("Cannot cancel a completed appointment");
        }

        // Changer le status à CANCELLED
        appointment.setStatus(AppointmentStatusEnum.CANCELED);
        appointmentRepository.update(appointment);
    }

    /**
     * Annuler appointment sans validation (validation déjà faite dans servlet)
     */
    public void cancelAppointmentWithoutValidation(UUID appointmentId) {
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);

        if (appointmentOpt.isEmpty()) {
            throw new RuntimeException("Appointment not found with id: " + appointmentId);
        }

        Appointment appointment = appointmentOpt.get();
        appointment.setStatus(AppointmentStatusEnum.CANCELED);
        appointmentRepository.update(appointment);
    }
}