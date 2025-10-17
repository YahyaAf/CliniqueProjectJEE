package org.example.clinique.repository;

import org.example.clinique.model.Availability;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AvailabilityRepository {

    void save(Availability availability);
    Optional<Availability> findById(UUID id);
    List<Availability> findAll();
    void update(Availability availability);
    void delete(UUID id);
    List<Availability> findByDoctorId(UUID doctorId);
    List<Availability> findByDayOfWeek(String dayOfWeek);
}
