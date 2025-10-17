package org.example.clinique.service;

import org.example.clinique.dto.AvailabilityRequestDTO;
import org.example.clinique.dto.AvailabilityResponseDTO;
import org.example.clinique.mapper.AvailabilityMapper;
import org.example.clinique.model.Availability;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.enums.DayOfWeekEnum;
import org.example.clinique.repository.AvailabilityRepository;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class AvailabilityService {

    private final AvailabilityRepository availabilityRepository;
    private final DoctorRepositoryImpl doctorRepository;

    public AvailabilityService(AvailabilityRepository availabilityRepository) {
        this.availabilityRepository = availabilityRepository;
        this.doctorRepository = new DoctorRepositoryImpl();
    }

    public void createAvailability(AvailabilityRequestDTO dto) {
        Optional<Doctor> doctorOpt = doctorRepository.findById(dto.getDoctorId());
        if (doctorOpt.isEmpty()) {
            throw new RuntimeException("Doctor not found with id: " + dto.getDoctorId());
        }

        Availability availability = AvailabilityMapper.toEntity(dto, doctorOpt.get());
        availabilityRepository.save(availability);
    }

    public AvailabilityResponseDTO getAvailabilityById(UUID id) {
        return availabilityRepository.findById(id)
                .map(AvailabilityMapper::toResponseDTO)
                .orElseThrow(() -> new RuntimeException("Availability not found with id: " + id));
    }

    public List<AvailabilityResponseDTO> getAllAvailabilities() {
        return availabilityRepository.findAll()
                .stream()
                .map(AvailabilityMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public void updateAvailability(UUID id, AvailabilityRequestDTO dto) {
        Optional<Availability> existingOpt = availabilityRepository.findById(id);
        if (existingOpt.isEmpty()) {
            throw new RuntimeException("Availability not found with id: " + id);
        }

        Availability existing = existingOpt.get();
        existing.setDayOfWeek(Enum.valueOf(DayOfWeekEnum.class, dto.getDayOfWeek().toUpperCase()));
        existing.setStartTime(dto.getStartTime());
        existing.setEndTime(dto.getEndTime());
        existing.setAvailable(dto.isAvailable());
        existing.setSlotDuration(dto.getSlotDuration());

        if (!existing.getDoctor().getId().equals(dto.getDoctorId())) {
            Optional<Doctor> doctorOpt = doctorRepository.findById(dto.getDoctorId());
            doctorOpt.ifPresent(existing::setDoctor);
        }

        availabilityRepository.update(existing);
    }

    public void deleteAvailability(UUID id) {
        availabilityRepository.delete(id);
    }

    public List<AvailabilityResponseDTO> getAvailabilitiesByDoctorId(UUID doctorId) {
        return availabilityRepository.findByDoctorId(doctorId)
                .stream()
                .map(AvailabilityMapper::toResponseDTO)
                .collect(Collectors.toList());
    }

    public List<AvailabilityResponseDTO> getAvailabilitiesByDayOfWeek(String dayOfWeek) {
        return availabilityRepository.findByDayOfWeek(dayOfWeek)
                .stream()
                .map(AvailabilityMapper::toResponseDTO)
                .collect(Collectors.toList());
    }
}
