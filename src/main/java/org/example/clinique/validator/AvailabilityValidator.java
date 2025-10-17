package org.example.clinique.validator;

import org.example.clinique.dto.AvailabilityRequestDTO;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AvailabilityValidator {

    public List<String> validate(AvailabilityRequestDTO dto) {
        List<String> errors = new ArrayList<>();

        if (dto.getDayOfWeek() == null || dto.getDayOfWeek().trim().isEmpty()) {
            errors.add("Day of week is required.");
        }

        if (dto.getStartTime() == null) {
            errors.add("Start time is required.");
        }

        if (dto.getEndTime() == null) {
            errors.add("End time is required.");
        }

        if (dto.getStartTime() != null && dto.getEndTime() != null) {
            if (!dto.getEndTime().isAfter(dto.getStartTime())) {
                errors.add("End time must be after start time.");
            }
        }

        if (dto.getSlotDuration() <= 0) {
            errors.add("Slot duration must be greater than 0.");
        }

        if (dto.getDoctorId() == null) {
            errors.add("Doctor ID is required.");
        }

        return errors;
    }
}
