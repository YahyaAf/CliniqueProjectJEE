package org.example.clinique.validator;

import org.example.clinique.dto.AvailabilityRequestDTO;
import org.example.clinique.model.Availability;
import org.example.clinique.model.enums.DayOfWeekEnum;
import org.example.clinique.repository.AvailabilityRepository;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AvailabilityValidator {

    private final AvailabilityRepository availabilityRepository;

    public AvailabilityValidator(AvailabilityRepository availabilityRepository) {
        this.availabilityRepository = availabilityRepository;
    }

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

        if (dto.getDoctorId() != null && dto.getDayOfWeek() != null) {
            List<Availability> existingAvailabilities =
                    availabilityRepository.findByDoctorId(dto.getDoctorId());

            DayOfWeekEnum dtoDay = DayOfWeekEnum.valueOf(dto.getDayOfWeek().toUpperCase());

            boolean duplicateDay = existingAvailabilities.stream()
                    .anyMatch(a ->
                            a.getDayOfWeek() == dtoDay &&
                                    a.isAvailable()
                    );

            if (duplicateDay) {
                errors.add("This doctor already has an active availability for that day. Please deactivate or delete it first.");
            }
        }

        return errors;
    }
}
