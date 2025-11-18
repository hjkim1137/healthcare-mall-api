package com.diaconn_mall.website.repository;

import com.diaconn_mall.website.entity.Order;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {

    @EntityGraph(attributePaths = {"orderDetails"})
    List<Order> findByUserIdOrderByRegdateDesc(Long userId);

    @EntityGraph(attributePaths = {"orderDetails"})
    Optional<Order> findByIdAndUserId(Long id, Long userId);
}
