package com.diaconn_mall.website.service;

import com.diaconn_mall.website.dto.OrderDetailDto;
import com.diaconn_mall.website.dto.OrderDto;
import com.diaconn_mall.website.dto.OrderSummaryDto;
import com.diaconn_mall.website.entity.Order;
import com.diaconn_mall.website.entity.OrderDetail;
import com.diaconn_mall.website.entity.Pay;
import com.diaconn_mall.website.entity.Product;
import com.diaconn_mall.website.repository.OrderRepository;
import com.diaconn_mall.website.repository.OrderDetailRepository;
import com.diaconn_mall.website.repository.PayRepository;
import com.diaconn_mall.website.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final PayRepository payRepository;
    private final ProductRepository productRepository;
    
    // 주문 저장
    @Transactional
    public Order saveOrder(OrderDto orderDto) {
        // 1. c_order 업데이트
        Order order = new Order();
        order.setTotalPrice(orderDto.getTotalPrice());
        order.setRegdate(LocalDateTime.now());
        order.setAddress(orderDto.getAddress());
        order.setAddressDetail(orderDto.getAddressDetail());
        order.setPhone(orderDto.getPhone());
        order.setName(orderDto.getName());
        order.setUserId(orderDto.getUserId());
        order.setMemo(orderDto.getMemo());

        // order ID 확보
        Order savedOrder = orderRepository.save(order);

        // 2. c_order_datail 업데이트
        List<OrderDetail> orderDetails = Optional.ofNullable(orderDto.getOrderDetails())
                .orElse(Collections.emptyList())
                .stream()
                .map(detailDto -> {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrder(savedOrder);
                    detail.setProductId(detailDto.getProductId());
                    Long productPrice = detailDto.getProductPrice();
                    Long productQuantity = detailDto.getProductQuantity();
                    detail.setProductPrice(productPrice);
                    detail.setProductQuantity(productQuantity);
                    detail.setProductTotalPrice(productPrice * productQuantity);
                    return detail;
                })
                .toList();
        orderDetailRepository.saveAll(orderDetails);

        // 3. c_pay 업데이트
        Pay pay = payRepository.findByOrderId(savedOrder.getId())
                .orElse(new Pay());
        pay.setPayDate(LocalDateTime.now());
        pay.setStatus("pay_done");
        pay.setAmount(savedOrder.getTotalPrice());
        pay.setOrder(savedOrder);

        payRepository.save(pay);
        return savedOrder;
    }

    // 사용자별 주문 목록 조회 (요약 정보)
    @Transactional(readOnly = true)
    public List<OrderSummaryDto> getOrderHistory(Long userId) {
        List<Order> orders = orderRepository.findByUserIdOrderByRegdateDesc(userId);

        return orders.stream()
                .map(order -> {
                    OrderSummaryDto summaryDto = new OrderSummaryDto();
                    summaryDto.setId(order.getId());
                    summaryDto.setTotalPrice(order.getTotalPrice());
                    summaryDto.setRegDate(order.getRegdate());
                    summaryDto.setAddress(order.getAddress());
                    summaryDto.setAddressDetail(order.getAddressDetail());
                    summaryDto.setName(order.getName());

                    // 대표 상품 정보 (첫 번째 상품)
                    List<OrderDetail> details = order.getOrderDetails();
                    if (!details.isEmpty()) {
                        OrderDetail firstDetail = details.get(0);
                        productRepository.findById(firstDetail.getProductId())
                                .ifPresent(product -> {
                                    summaryDto.setFirstProductName(product.getNm());
                                    summaryDto.setFirstProductImgUrl(product.getImgUrl());
                                });
                        summaryDto.setTotalProductCount(details.size());
                    }

                    return summaryDto;
                })
                .collect(Collectors.toList());
    }

    // 주문 상세 조회
    @Transactional(readOnly = true)
    public OrderDto getOrderDetail(Long orderId, Long userId) {
        Order order = orderRepository.findByIdAndUserId(orderId, userId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));

        OrderDto orderDto = new OrderDto();
        orderDto.setId(order.getId());
        orderDto.setTotalPrice(order.getTotalPrice());
        orderDto.setRegDate(order.getRegdate());
        orderDto.setAddress(order.getAddress());
        orderDto.setAddressDetail(order.getAddressDetail());
        orderDto.setPhone(order.getPhone());
        orderDto.setName(order.getName());
        orderDto.setUserId(order.getUserId());
        orderDto.setMemo(order.getMemo());

        // OrderDetail과 제품 정보 매핑
        List<OrderDetailDto> detailDtos = order.getOrderDetails().stream()
                .map(detail -> {
                    OrderDetailDto detailDto = new OrderDetailDto();
                    detailDto.setId(detail.getId());
                    detailDto.setOrderId(order.getId());
                    detailDto.setProductId(detail.getProductId());
                    detailDto.setProductPrice(detail.getProductPrice());
                    detailDto.setProductQuantity(detail.getProductQuantity());
                    detailDto.setProductTotalPrice(detail.getProductTotalPrice());

                    // 제품 정보 조회
                    productRepository.findById(detail.getProductId())
                            .ifPresent(product -> {
                                detailDto.setProductName(product.getNm());
                                detailDto.setProductImgUrl(product.getImgUrl());
                                detailDto.setProductCategory(product.getCategory());
                            });

                    return detailDto;
                })
                .collect(Collectors.toList());

        orderDto.setOrderDetails(detailDtos);
        return orderDto;
    }
}