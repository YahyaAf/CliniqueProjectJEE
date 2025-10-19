package org.example.clinique.validator;

import org.example.clinique.model.Appointment;
import org.example.clinique.model.enums.AppointmentStatusEnum;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CancelAppointmentValidator {

    // Constant
    private static final int CANCELLATION_HOURS_BEFORE = 12;

    /**
     * Valider l'annulation d'un appointment
     */
    public ValidationResult validate(Appointment appointment) {
        ValidationResult result = new ValidationResult();

        // 1. Vérifier que l'appointment existe
        if (appointment == null) {
            result.addError("Appointment not found");
            return result;
        }

        // 2. Vérifier que l'appointment n'est pas déjà annulé
        if (appointment.getStatus() == AppointmentStatusEnum.CANCELED) {
            result.addError("This appointment is already cancelled");
            return result;
        }

        // 3. Vérifier que l'appointment n'est pas déjà complété
        if (appointment.getStatus() == AppointmentStatusEnum.DONE) {
            result.addError("Cannot cancel a completed appointment");
            return result;
        }

        // 4. Calculer le temps restant avant l'appointment
        LocalDateTime appointmentDateTime = LocalDateTime.of(
                appointment.getAppointmentDate(),
                appointment.getStartTime()
        );
        LocalDateTime now = LocalDateTime.now();

        // 5. Vérifier si l'appointment est dans le passé
        if (appointmentDateTime.isBefore(now) || appointmentDateTime.isEqual(now)) {
            result.addError("Cannot cancel an appointment that has already started or passed");
            return result;
        }

        // 6. Calculer les heures restantes
        long hoursUntilAppointment = java.time.Duration.between(now, appointmentDateTime).toHours();

        // 7. Vérifier la règle des 12 heures
        if (hoursUntilAppointment < CANCELLATION_HOURS_BEFORE) {
            result.addError("Appointments must be cancelled at least 12 hours in advance. " +
                    "Only " + hoursUntilAppointment + " hour(s) remaining until your appointment.");
            return result;
        }

        return result;
    }

    /**
     * Classe pour stocker les résultats de validation
     */
    public static class ValidationResult {
        private final List<String> errors = new ArrayList<>();

        public void addError(String error) {
            errors.add(error);
        }

        public boolean isValid() {
            return errors.isEmpty();
        }

        public List<String> getErrors() {
            return new ArrayList<>(errors);
        }

        public String getErrorMessage() {
            return String.join("; ", errors);
        }
    }
}