package org.example.clinique.repository;

import org.example.clinique.model.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository {
    void save(User user);
    Optional<User> findById(UUID id);
    List<User> findAll();
    void update(User user);
    void delete(UUID id);
}
