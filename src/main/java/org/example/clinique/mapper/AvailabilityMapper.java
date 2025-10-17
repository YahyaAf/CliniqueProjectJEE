package org.example.clinique.mapper;

import org.example.clinique.dto.AvailabilityRequestDTO;
import org.example.clinique.dto.AvailabilityResponseDTO;
import org.example.clinique.model.Availability;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.enums.DayOfWeekEnum;

public class AvailabilityMapper {

    public static Availability toEntity(AvailabilityRequestDTO dto, Doctor doctor) {
        Availability availability = new Availability();
        availability.setDayOfWeek(DayOfWeekEnum.valueOf(dto.getDayOfWeek().toUpperCase()));
        availability.setStartTime(dto.getStartTime());
        availability.setEndTime(dto.getEndTime());
        availability.setAvailable(dto.isAvailable());
        availability.setSlotDuration(dto.getSlotDuration());
        availability.setDoctor(doctor);
        return availability;
    }

    public static AvailabilityResponseDTO toResponseDTO(Availability availability) {
        AvailabilityResponseDTO dto = new AvailabilityResponseDTO();
        dto.setId(availability.getId());
        dto.setDayOfWeek(availability.getDayOfWeek().name());
        dto.setStartTime(availability.getStartTime());
        dto.setEndTime(availability.getEndTime());
        dto.setAvailable(availability.isAvailable());
        dto.setSlotDuration(availability.getSlotDuration());
        dto.setDoctorId(availability.getDoctor().getId());
        dto.setDoctorName(availability.getDoctor().getUser().getFullName());
        return dto;
    }
}
