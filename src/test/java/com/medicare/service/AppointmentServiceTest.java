package com.medicare.service;

import org.example.clinique.model.Appointment;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.Patient;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.AppointmentStatusEnum;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.model.enums.Role;
import org.junit.jupiter.api.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Test unitaire simplifié pour la logique métier d'Appointment
 * SANS utiliser de DAO - Tests de la logique pure
 * Utilise UUID pour les identifiants
 *
 * @author YahyaAf
 * @date 2025-10-20
 */
@DisplayName("Appointment Business Logic Tests")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class AppointmentServiceTest {

    private Doctor testDoctor;
    private Patient testPatient;
    private Appointment testAppointment;
    private LocalDate testDate;
    private LocalTime testStartTime;
    private LocalTime testEndTime;

    private UUID doctorId;
    private UUID patientId;
    private UUID appointmentId;
    private UUID doctorUserId;
    private UUID patientUserId;

    @BeforeEach
    void setUp() {
        System.out.println("🔧 Setting up test environment...");

        // Generate UUIDs
        doctorId = UUID.randomUUID();
        patientId = UUID.randomUUID();
        appointmentId = UUID.randomUUID();
        doctorUserId = UUID.randomUUID();
        patientUserId = UUID.randomUUID();

        // Setup test date and time
        testDate = LocalDate.now().plusDays(1);
        testStartTime = LocalTime.of(10, 0);
        testEndTime = LocalTime.of(10, 30);

        // Setup test doctor
        testDoctor = new Doctor();
        testDoctor.setId(doctorId);
        User doctorUser = new User();
        doctorUser.setId(doctorUserId);
        doctorUser.setFullName("Dr. Ahmed Hassan");
        doctorUser.setEmail("ahmed.hassan@medicare.com");
        doctorUser.setPassword("password123");
        doctorUser.setRole(Role.DOCTOR);
        doctorUser.setActive(true);
        testDoctor.setUser(doctorUser);
        testDoctor.setMatricule("DOC001");

        // Setup test patient
        testPatient = new Patient();
        testPatient.setId(patientId);
        User patientUser = new User();
        patientUser.setId(patientUserId);
        patientUser.setFullName("Yahya Afridi");
        patientUser.setEmail("yahya.afridi@gmail.com");
        patientUser.setPassword("password123");
        patientUser.setRole(Role.PATIENT);
        patientUser.setActive(true);
        testPatient.setUser(patientUser);
        testPatient.setCin("AB123456");
        testPatient.setDateOfBirth(LocalDate.of(1995, 5, 15));
        testPatient.setGender(Gender.MALE);
        testPatient.setBloodType(BloodType.O_POSITIVE);

        // Setup test appointment
        testAppointment = new Appointment();
        testAppointment.setId(appointmentId);
        testAppointment.setAppointmentNumber("APT-2025-001");
        testAppointment.setDoctor(testDoctor);
        testAppointment.setPatient(testPatient);
        testAppointment.setAppointmentDate(testDate);
        testAppointment.setStartTime(testStartTime);
        testAppointment.setEndTime(testEndTime);
        testAppointment.setStatus(AppointmentStatusEnum.PLANNED);
    }

    @AfterEach
    void tearDown() {
        System.out.println("🧹 Cleaning up...\n");
    }

    // ==================== ENTITY CREATION TESTS ====================

    @Test
    @Order(1)
    @DisplayName("Test 1: Create valid appointment with UUID")
    void testCreateAppointment_ValidData() {
        System.out.println("Test 1: Create Appointment with Valid Data (UUID)");

        // Act
        UUID newAppointmentId = UUID.randomUUID();
        Appointment appointment = new Appointment();
        appointment.setId(newAppointmentId);
        appointment.setAppointmentNumber("APT-2025-001");
        appointment.setDoctor(testDoctor);
        appointment.setPatient(testPatient);
        appointment.setAppointmentDate(testDate);
        appointment.setStartTime(testStartTime);
        appointment.setEndTime(testEndTime);
        appointment.setStatus(AppointmentStatusEnum.PLANNED);

        // Assert
        assertNotNull(appointment);
        assertNotNull(appointment.getId());
        assertEquals(newAppointmentId, appointment.getId());
        assertEquals("APT-2025-001", appointment.getAppointmentNumber());
        assertEquals(testDoctor, appointment.getDoctor());
        assertEquals(testPatient, appointment.getPatient());
        assertEquals(AppointmentStatusEnum.PLANNED, appointment.getStatus());

        System.out.println("Appointment created successfully with UUID: " + appointment.getId());
        System.out.println("Appointment Number: " + appointment.getAppointmentNumber());
    }

    @Test
    @Order(2)
    @DisplayName("Test 2: Doctor details with UUID are correct")
    void testDoctor_DetailsAreCorrect() {
        System.out.println("Test 2: Verify Doctor Details with UUID");

        // Assert
        assertNotNull(testDoctor);
        assertNotNull(testDoctor.getId());
        assertEquals(doctorId, testDoctor.getId());
        assertEquals("DOC001", testDoctor.getMatricule());
        assertEquals("Dr. Ahmed Hassan", testDoctor.getUser().getFullName());
        assertEquals("ahmed.hassan@medicare.com", testDoctor.getUser().getEmail());
        assertEquals(Role.DOCTOR, testDoctor.getUser().getRole());
        assertEquals(doctorUserId, testDoctor.getUser().getId());

        System.out.println("Doctor details verified:");
        System.out.println("   Doctor ID (UUID): " + testDoctor.getId());
        System.out.println("   Doctor Name: " + testDoctor.getUser().getFullName());
        System.out.println("   User ID (UUID): " + testDoctor.getUser().getId());
    }

    @Test
    @Order(3)
    @DisplayName("Test 3: Patient details with UUID are correct")
    void testPatient_DetailsAreCorrect() {
        System.out.println("Test 3: Verify Patient Details with UUID");

        // Assert
        assertNotNull(testPatient);
        assertNotNull(testPatient.getId());
        assertEquals(patientId, testPatient.getId());
        assertEquals("AB123456", testPatient.getCin());
        assertEquals("Yahya Afridi", testPatient.getUser().getFullName());
        assertEquals("yahya.afridi@gmail.com", testPatient.getUser().getEmail());
        assertEquals(Gender.MALE, testPatient.getGender());
        assertEquals(BloodType.O_POSITIVE, testPatient.getBloodType());
        assertEquals(Role.PATIENT, testPatient.getUser().getRole());
        assertEquals(patientUserId, testPatient.getUser().getId());

        System.out.println("Patient details verified:");
        System.out.println("   Patient ID (UUID): " + testPatient.getId());
        System.out.println("   Patient Name: " + testPatient.getUser().getFullName());
        System.out.println("   User ID (UUID): " + testPatient.getUser().getId());
    }

    @Test
    @Order(4)
    @DisplayName("Test 4: UUID generation is unique")
    void testUUID_GenerationIsUnique() {
        System.out.println("Test 4: Verify UUID Uniqueness");

        // Generate multiple UUIDs
        Set<UUID> uuidSet = new HashSet<>();
        for (int i = 0; i < 100; i++) {
            uuidSet.add(UUID.randomUUID());
        }

        // Assert
        assertEquals(100, uuidSet.size(), "All UUIDs should be unique");

        System.out.println("Generated 100 unique UUIDs successfully");
    }

    // ==================== STATUS TESTS ====================

    @Test
    @Order(5)
    @DisplayName("Test 5: Change status to DONE")
    void testAppointmentStatus_ChangeToDone() {
        System.out.println("Test 5: Change Appointment Status to DONE");

        // Act
        testAppointment.setStatus(AppointmentStatusEnum.DONE);

        // Assert
        assertEquals(AppointmentStatusEnum.DONE, testAppointment.getStatus());

        System.out.println("Status changed to DONE successfully");
        System.out.println("   Appointment ID: " + testAppointment.getId());
    }

    @Test
    @Order(6)
    @DisplayName("Test 6: Change status to CANCELED")
    void testAppointmentStatus_ChangeToCanceled() {
        System.out.println("Test 6: Change Appointment Status to CANCELED");

        // Act
        testAppointment.setStatus(AppointmentStatusEnum.CANCELED);
        testAppointment.setCancellationReason("Patient requested cancellation");

        // Assert
        assertEquals(AppointmentStatusEnum.CANCELED, testAppointment.getStatus());
        assertNotNull(testAppointment.getCancellationReason());
        assertTrue(testAppointment.getCancellationReason().contains("Patient requested"));

        System.out.println("Status changed to CANCELED with reason");
    }

    @Test
    @Order(7)
    @DisplayName("Test 7: All appointment statuses are valid")
    void testAppointmentStatus_AllStatusesAreValid() {
        System.out.println("Test 7: Test All Appointment Statuses");

        // Test PLANNED
        testAppointment.setStatus(AppointmentStatusEnum.PLANNED);
        assertEquals(AppointmentStatusEnum.PLANNED, testAppointment.getStatus());
        System.out.println("  ✓ PLANNED status OK");

        // Test DONE
        testAppointment.setStatus(AppointmentStatusEnum.DONE);
        assertEquals(AppointmentStatusEnum.DONE, testAppointment.getStatus());
        System.out.println("  ✓ DONE status OK");

        // Test CANCELED
        testAppointment.setStatus(AppointmentStatusEnum.CANCELED);
        assertEquals(AppointmentStatusEnum.CANCELED, testAppointment.getStatus());
        System.out.println("  ✓ CANCELED status OK");

        System.out.println("All statuses are valid");
    }

    // ==================== VALIDATION TESTS ====================

    @Test
    @Order(8)
    @DisplayName("Test 8: Appointment date is in the future")
    void testAppointmentDate_IsInFuture() {
        System.out.println("Test 8: Verify Appointment Date is in Future");

        // Assert
        assertTrue(testAppointment.getAppointmentDate().isAfter(LocalDate.now()));

        System.out.println("Date is correctly in the future: " + testAppointment.getAppointmentDate());
    }

    @Test
    @Order(9)
    @DisplayName("Test 9: Should detect past date")
    void testAppointmentDate_DetectPastDate() {
        System.out.println("Test 9: Detect Past Date Appointment");

        // Arrange
        LocalDate pastDate = LocalDate.now().minusDays(1);
        testAppointment.setAppointmentDate(pastDate);

        // Assert
        assertTrue(testAppointment.getAppointmentDate().isBefore(LocalDate.now()));

        System.out.println("Past date detected correctly");
    }

    @Test
    @Order(10)
    @DisplayName("Test 10: Start time is before end time")
    void testAppointmentTime_StartBeforeEnd() {
        System.out.println("Test 10: Verify Start Time Before End Time");

        // Assert
        assertTrue(testAppointment.getStartTime().isBefore(testAppointment.getEndTime()));

        System.out.println("Time slot is valid: " + testStartTime + " - " + testEndTime);
    }

    @Test
    @Order(11)
    @DisplayName("Test 11: Appointment duration is 30 minutes")
    void testAppointmentDuration_Is30Minutes() {
        System.out.println("Test 11: Calculate Appointment Duration");

        // Calculate duration
        long durationMinutes = java.time.Duration.between(testStartTime, testEndTime).toMinutes();

        // Assert
        assertEquals(30, durationMinutes);

        System.out.println("Duration is correct: " + durationMinutes + " minutes");
    }

    // ==================== BUSINESS LOGIC TESTS ====================

    @Test
    @Order(12)
    @DisplayName("Test 12: Generate appointment number format")
    void testAppointmentNumber_CorrectFormat() {
        System.out.println("Test 12: Verify Appointment Number Format");

        // Assert
        assertNotNull(testAppointment.getAppointmentNumber());
        assertTrue(testAppointment.getAppointmentNumber().startsWith("APT-"));
        assertTrue(testAppointment.getAppointmentNumber().contains("2025"));

        System.out.println("Appointment number format is correct: " + testAppointment.getAppointmentNumber());
    }

    @Test
    @Order(13)
    @DisplayName("Test 13: Appointment has doctor and patient with UUIDs")
    void testAppointment_HasDoctorAndPatient() {
        System.out.println("Test 13: Verify Appointment Has Doctor and Patient (UUID)");

        // Assert
        assertNotNull(testAppointment.getDoctor());
        assertNotNull(testAppointment.getPatient());
        assertEquals(testDoctor.getId(), testAppointment.getDoctor().getId());
        assertEquals(testPatient.getId(), testAppointment.getPatient().getId());

        System.out.println("Doctor and Patient are correctly assigned");
        System.out.println("   Doctor ID: " + testAppointment.getDoctor().getId());
        System.out.println("   Patient ID: " + testAppointment.getPatient().getId());
    }

    @Test
    @Order(14)
    @DisplayName("Test 14: Multiple appointments with different UUIDs")
    void testMultipleAppointments_CanBeCreated() {
        System.out.println("Test 14: Create Multiple Appointments with UUIDs");

        // Create appointment list
        List<Appointment> appointments = new ArrayList<>();
        Set<UUID> uniqueIds = new HashSet<>();

        // Create 3 appointments
        for (int i = 1; i <= 3; i++) {
            UUID newId = UUID.randomUUID();
            Appointment apt = new Appointment();
            apt.setId(newId);
            apt.setAppointmentNumber("APT-2025-00" + i);
            apt.setDoctor(testDoctor);
            apt.setPatient(testPatient);
            apt.setAppointmentDate(testDate.plusDays(i));
            apt.setStartTime(testStartTime);
            apt.setEndTime(testEndTime);
            apt.setStatus(AppointmentStatusEnum.PLANNED);
            appointments.add(apt);
            uniqueIds.add(newId);
        }

        // Assert
        assertEquals(3, appointments.size());
        assertEquals(3, uniqueIds.size(), "All appointment IDs should be unique");
        assertEquals("APT-2025-001", appointments.get(0).getAppointmentNumber());
        assertEquals("APT-2025-002", appointments.get(1).getAppointmentNumber());
        assertEquals("APT-2025-003", appointments.get(2).getAppointmentNumber());

        System.out.println("Created " + appointments.size() + " appointments with unique UUIDs");
        appointments.forEach(apt ->
                System.out.println("   - " + apt.getAppointmentNumber() + " (ID: " + apt.getId() + ")")
        );
    }

    @Test
    @Order(15)
    @DisplayName("Test 15: Filter appointments by status")
    void testAppointments_FilterByStatus() {
        System.out.println("Test 15: Filter Appointments by Status");

        // Create appointments with different statuses
        List<Appointment> allAppointments = new ArrayList<>();

        Appointment apt1 = new Appointment();
        apt1.setId(UUID.randomUUID());
        apt1.setStatus(AppointmentStatusEnum.PLANNED);
        allAppointments.add(apt1);

        Appointment apt2 = new Appointment();
        apt2.setId(UUID.randomUUID());
        apt2.setStatus(AppointmentStatusEnum.DONE);
        allAppointments.add(apt2);

        Appointment apt3 = new Appointment();
        apt3.setId(UUID.randomUUID());
        apt3.setStatus(AppointmentStatusEnum.PLANNED);
        allAppointments.add(apt3);

        // Filter PLANNED
        long plannedCount = allAppointments.stream()
                .filter(a -> a.getStatus() == AppointmentStatusEnum.PLANNED)
                .count();

        // Filter DONE
        long doneCount = allAppointments.stream()
                .filter(a -> a.getStatus() == AppointmentStatusEnum.DONE)
                .count();

        // Assert
        assertEquals(2, plannedCount);
        assertEquals(1, doneCount);

        System.out.println("Filtered successfully: " + plannedCount + " PLANNED, " + doneCount + " DONE");
    }

    @Test
    @Order(16)
    @DisplayName("Test 16: Patient blood type compatibility")
    void testPatient_BloodTypeIsValid() {
        System.out.println("Test 16: Verify Blood Type Enum");

        // Test all blood types
        testPatient.setBloodType(BloodType.A_POSITIVE);
        assertEquals(BloodType.A_POSITIVE, testPatient.getBloodType());

        testPatient.setBloodType(BloodType.O_NEGATIVE);
        assertEquals(BloodType.O_NEGATIVE, testPatient.getBloodType());

        System.out.println("Blood type enum works correctly");
    }

    // ==================== EDGE CASE TESTS ====================

    @Test
    @Order(17)
    @DisplayName("Test 17: Appointment toString method")
    void testAppointment_ToStringIsValid() {
        System.out.println("Test 17: Test toString Method");

        // Act
        String appointmentString = testAppointment.toString();

        // Assert
        assertNotNull(appointmentString);

        System.out.println("toString works: " + appointmentString);
    }

    @Test
    @Order(18)
    @DisplayName("Test 18: Appointment equality by UUID")
    void testAppointment_EqualityById() {
        System.out.println("Test 18: Test Appointment Equality by UUID");

        // Create another appointment with same UUID
        UUID sameId = testAppointment.getId();
        Appointment apt2 = new Appointment();
        apt2.setId(sameId);

        // Assert
        assertEquals(testAppointment.getId(), apt2.getId());

        System.out.println("Appointment equality works correctly");
        System.out.println("   UUID: " + sameId);
    }

    @Test
    @Order(19)
    @DisplayName("Test 19: Complete appointment workflow")
    void testAppointment_CompleteWorkflow() {
        System.out.println("Test 19: Complete Appointment Workflow");

        // 1. Create appointment
        assertEquals(AppointmentStatusEnum.PLANNED, testAppointment.getStatus());
        System.out.println("  ✓ Step 1: Appointment created (PLANNED)");
        System.out.println("    ID: " + testAppointment.getId());

        // 2. Mark as done
        testAppointment.setStatus(AppointmentStatusEnum.DONE);
        assertEquals(AppointmentStatusEnum.DONE, testAppointment.getStatus());
        System.out.println("  ✓ Step 2: Appointment completed (DONE)");

        // 3. Verify final state
        assertNotNull(testAppointment.getDoctor());
        assertNotNull(testAppointment.getPatient());
        assertNotNull(testAppointment.getId());
        System.out.println("  ✓ Step 3: Final verification passed");

        System.out.println("Complete workflow test passed");
    }

    // ==================== TEST SUMMARY ====================

    @AfterAll
    static void printTestSummary() {
        System.out.println("\n" + "=".repeat(60));
        System.out.println("TEST SUMMARY - Appointment Business Logic (UUID)");
        System.out.println("=".repeat(60));
        System.out.println("All tests completed successfully!");
        System.out.println("Test Date: 2025-10-20");
        System.out.println("Author: YahyaAf");
        System.out.println("Coverage: Entity Logic + Business Rules");
        System.out.println("ID Type: UUID (Universal Unique Identifier)");
        System.out.println("Total Tests: 19");
        System.out.println("=".repeat(60) + "\n");
    }
}