-- MySQL dump 10.13  Distrib 8.4.5, for Win64 (x86_64)
--
-- Host: localhost    Database: diaconn_mall_clone
-- ------------------------------------------------------
-- Server version	8.4.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `diaconn_mall_clone`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `diaconn_mall_clone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `diaconn_mall_clone`;

--
-- Table structure for table `c_cart`
--

DROP TABLE IF EXISTS `c_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `count` int NOT NULL,
  `added_at` datetime NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_user` (`user_id`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `c_user` (`id`),
  CONSTRAINT `product_id` FOREIGN KEY (`id`) REFERENCES `c_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_cart`
--

LOCK TABLES `c_cart` WRITE;
/*!40000 ALTER TABLE `c_cart` DISABLE KEYS */;
INSERT INTO `c_cart` VALUES (6,1,'2025-09-10 22:17:38',4,11),(7,1,'2025-09-10 22:17:54',4,5),(8,2,'2025-09-11 12:38:10',5,4),(9,1,'2025-09-11 12:38:16',5,5),(12,1,'2025-10-16 12:53:35',4,3);
/*!40000 ALTER TABLE `c_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_category`
--

DROP TABLE IF EXISTS `c_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_category` (
  `id` int NOT NULL,
  `nm` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_category`
--

LOCK TABLES `c_category` WRITE;
/*!40000 ALTER TABLE `c_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_order`
--

DROP TABLE IF EXISTS `c_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_price` bigint DEFAULT NULL,
  `regdate` datetime NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `address_detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `user_id` bigint NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_user` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `c_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_order`
--

LOCK TABLES `c_order` WRITE;
/*!40000 ALTER TABLE `c_order` DISABLE KEYS */;
INSERT INTO `c_order` VALUES (12,185000,'2025-10-16 12:49:49','대구시 동구','아아아','01094046005','정세인',4,'');
/*!40000 ALTER TABLE `c_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_order_detail`
--

DROP TABLE IF EXISTS `c_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `product_price` bigint NOT NULL DEFAULT '0',
  `product_quantity` bigint NOT NULL DEFAULT '0',
  `product_total_price` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_orderdetail_order` (`order_id`),
  CONSTRAINT `fk_orderdetail_order` FOREIGN KEY (`order_id`) REFERENCES `c_order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_order_detail`
--

LOCK TABLES `c_order_detail` WRITE;
/*!40000 ALTER TABLE `c_order_detail` DISABLE KEYS */;
INSERT INTO `c_order_detail` VALUES (4,12,4,185000,1,185000);
/*!40000 ALTER TABLE `c_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_pay`
--

DROP TABLE IF EXISTS `c_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_pay` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pay_date` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `amount` bigint DEFAULT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pay_order` (`order_id`),
  CONSTRAINT `fk_pay_order` FOREIGN KEY (`order_id`) REFERENCES `c_order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_pay`
--

LOCK TABLES `c_pay` WRITE;
/*!40000 ALTER TABLE `c_pay` DISABLE KEYS */;
INSERT INTO `c_pay` VALUES (12,'2025-10-16 12:49:49','pay_done',185000,12);
/*!40000 ALTER TABLE `c_pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_product`
--

DROP TABLE IF EXISTS `c_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_product` (
  `id` bigint NOT NULL,
  `nm` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `count` int NOT NULL,
  `price` int NOT NULL,
  `img_url` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `alt_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `is_banner` bit(1) NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `content_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_product`
--

LOCK TABLES `c_product` WRITE;
/*!40000 ALTER TABLE `c_product` DISABLE KEYS */;
INSERT INTO `c_product` VALUES (1,'banner','상품 설명',1,0,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/banner/banner.png','판매중','배너',0x01,'5',NULL),(2,'[바로잰] 펄스플러스 자동전자혈압계','상품 설명',1,120000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5B%EB%B0%94%EB%A1%9C%EC%9E%B0%5D+%ED%8E%84%EC%8A%A4%ED%94%8C%EB%9F%AC%EC%8A%A4+%EC%9E%90%EB%8F%99%EC%A0%84%EC%9E%90%ED%98%88%EC%95%95%EA%B3%84_120000.png','판매중','이미지',0x00,'3',NULL),(3,'[바로잰]바로잰2 혈당시험지 50매','상품 설명',1,12000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5B%EB%B0%94%EB%A1%9C%EC%9E%B0%5D%EB%B0%94%EB%A1%9C%EC%9E%B02+%ED%98%88%EB%8B%B9%EC%8B%9C%ED%97%98%EC%A7%80+50%EB%A7%A4_12000.png','판매중','이미지',0x00,'3',NULL),(4,'[뷰노]하티브 퍼스널 심전도 측정기 P30','상품 설명',1,185000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5B%EB%B7%B0%EB%85%B8%5D%ED%95%98%ED%8B%B0%EB%B8%8C+%ED%8D%BC%EC%8A%A4%EB%84%90+%EC%8B%AC%EC%A0%84%EB%8F%84+%EC%B8%A1%EC%A0%95%EA%B8%B0+P30_185000.png','판매중','이미지',0x00,'3',NULL),(5,'[큐라에스] 리펩(14포) 웰니스 부스터 몰입+활력 누트로픽','상품 설명',1,19800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5B%ED%81%90%EB%9D%BC%EC%97%90%EC%8A%A4%5D+%EB%A6%AC%ED%8E%A9(14%ED%8F%AC)+%EC%9B%B0%EB%8B%88%EC%8A%A4+%EB%B6%80%EC%8A%A4%ED%84%B0+%EB%AA%B0%EC%9E%85%2B%ED%99%9C%EB%A0%A5+%EB%88%84%ED%8A%B8%EB%A1%9C%ED%94%BD_19800.png','판매중','이미지',0x00,'3',NULL),(6,'[CGM]바로잰Fit 연속혈당측정기+나랑드사이다 1박스(30개입)','상품 설명',1,80000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5BCGM%5D%EB%B0%94%EB%A1%9C%EC%9E%B0Fit+%EC%97%B0%EC%86%8D%ED%98%88%EB%8B%B9%EC%B8%A1%EC%A0%95%EA%B8%B0%2B%EB%82%98%EB%9E%91%EB%93%9C%EC%82%AC%EC%9D%B4%EB%8B%A4+1%EB%B0%95%EC%8A%A4(30%EA%B0%9C%EC%9E%85)_80000.png','판매중','이미지',0x00,'3',NULL),(7,'[CJ바이오사이언스] 스마일것 장내미생물검사','상품 설명',1,135000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%5BCJ%EB%B0%94%EC%9D%B4%EC%98%A4%EC%82%AC%EC%9D%B4%EC%96%B8%EC%8A%A4%5D+%EC%8A%A4%EB%A7%88%EC%9D%BC%EA%B2%83+%EC%9E%A5%EB%82%B4%EB%AF%B8%EC%83%9D%EB%AC%BC%EA%B2%80%EC%82%AC_135000.png','판매중','이미지',0x00,'3',NULL),(8,'바로잰 펄스 자동전자혈압계','상품 설명',1,70000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%EB%B0%94%EB%A1%9C%EC%9E%B0+%ED%8E%84%EC%8A%A4+%EC%9E%90%EB%8F%99%EC%A0%84%EC%9E%90%ED%98%88%EC%95%95%EA%B3%84_70000.png','판매중','이미지',0x00,'3',NULL),(9,'바로잰Fit 연속혈당측정기','상품 설명',1,80000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%EB%B0%94%EB%A1%9C%EC%9E%B0Fit+%EC%97%B0%EC%86%8D%ED%98%88%EB%8B%B9%EC%B8%A1%EC%A0%95%EA%B8%B0_80000.png','판매중','이미지',0x00,'3',NULL),(10,'프리스타일 리브레2 2개 연속혈당측정기','상품 설명',1,184000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_%ED%94%84%EB%A6%AC%EC%8A%A4%ED%83%80%EC%9D%BC+%EB%A6%AC%EB%B8%8C%EB%A0%882+2%EA%B0%9C+%EC%97%B0%EC%86%8D%ED%98%88%EB%8B%B9%EC%B8%A1%EC%A0%95%EA%B8%B0_184000.png','판매중','이미지',0x00,'3',NULL),(11,'SOL-M 33G 펜니들','상품 설명',1,21000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/3_SOL-M+33G+%ED%8E%9C%EB%8B%88%EB%93%A4_21000.jpg','판매중','이미지',0x00,'3',NULL),(12,'바로잰 핏','상품 설명',1,32000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/devices/fit.png','판매중','이미지',0x00,'3',NULL),(13,'[메디푸드] 당뇨식 글루트롤 200ml (30캔box)','상품 설명',1,49500,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EB%A9%94%EB%94%94%ED%91%B8%EB%93%9C%5D+%EB%8B%B9%EB%87%A8%EC%8B%9D+%EA%B8%80%EB%A3%A8%ED%8A%B8%EB%A1%A4+200ml+(30%EC%BA%94box)_49500.jpg','판매중','이미지',0x00,'2',NULL),(14,'[웅진] 아침햇살 제로슈가 500ml 20개','상품 설명',1,26300,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%9B%85%EC%A7%84%5D+%EC%95%84%EC%B9%A8%ED%96%87%EC%82%B4+%EC%A0%9C%EB%A1%9C%EC%8A%88%EA%B0%80+500ml+20%EA%B0%9C_26300.png','판매중','이미지',0x00,'2',NULL),(15,'[웅진] 자연은 더말린 복숭아 500ml 6입','상품 설명',1,8500,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%9B%85%EC%A7%84%5D+%EC%9E%90%EC%97%B0%EC%9D%80+%EB%8D%94%EB%A7%90%EB%A6%B0+%EB%B3%B5%EC%88%AD%EC%95%84+500ml+6%EC%9E%85_8500.png','판매중','이미지',0x00,'2',NULL),(16,'[웅진] 자연은 알로에 제로 500ml 6입_8900','상품 설명',1,8900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%9B%85%EC%A7%84%5D+%EC%9E%90%EC%97%B0%EC%9D%80+%EC%95%8C%EB%A1%9C%EC%97%90+%EC%A0%9C%EB%A1%9C+500ml+6%EC%9E%85_8900.png','판매중','이미지',0x00,'2',NULL),(17,'[웅진] 초록매실 스파클링 제로 350ml 20개','상품 설명',1,16300,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%9B%85%EC%A7%84%5D+%EC%B4%88%EB%A1%9D%EB%A7%A4%EC%8B%A4+%EC%8A%A4%ED%8C%8C%ED%81%B4%EB%A7%81+%EC%A0%9C%EB%A1%9C+350ml+20%EA%B0%9C_16300.png','판매중','이미지',0x00,'2',NULL),(18,'[입점할인]앳원스커피 에스프레소 샷 스틱 6개입(1박스)','상품 설명',1,13900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%9E%85%EC%A0%90%ED%95%A0%EC%9D%B8%5D%EC%95%B3%EC%9B%90%EC%8A%A4%EC%BB%A4%ED%94%BC+%EC%97%90%EC%8A%A4%ED%94%84%EB%A0%88%EC%86%8C+%EC%83%B7+%EC%8A%A4%ED%8B%B1+6%EA%B0%9C%EC%9E%85(1%EB%B0%95%EC%8A%A4)_13900.jpg','판매중','이미지',0x00,'2',NULL),(19,'[정기배송] 글루어트 애플사이다비니거,애사비 3종(오리지널,파인애플,타트체리) 4BOX15포','상품 설명',1,42900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%EC%A0%95%EA%B8%B0%EB%B0%B0%EC%86%A1%5D+%EA%B8%80%EB%A3%A8%EC%96%B4%ED%8A%B8+%EC%95%A0%ED%94%8C%EC%82%AC%EC%9D%B4%EB%8B%A4%EB%B9%84%EB%8B%88%EA%B1%B0%2C%EC%95%A0%EC%82%AC%EB%B9%84+3%EC%A2%85(%EC%98%A4%EB%A6%AC%EC%A7%80%EB%84%90%2C%ED%8C%8C%EC%9D%B8%EC%95%A0%ED%94%8C%2C%ED%83%80%ED%8A%B8%EC%B2%B4%EB%A6%AC)+4BOX15%ED%8F%AC_42900.png','판매중','이미지',0x00,'2',NULL),(20,'[한정수량] 무화당X메디웰 당당한 바나나맛 두유 250ml 1팩 (1인 1개)','상품 설명',1,1990,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%ED%95%9C%EC%A0%95%EC%88%98%EB%9F%89%5D+%EB%AC%B4%ED%99%94%EB%8B%B9X%EB%A9%94%EB%94%94%EC%9B%B0+%EB%8B%B9%EB%8B%B9%ED%95%9C+%EB%B0%94%EB%82%98%EB%82%98%EB%A7%9B+%EB%91%90%EC%9C%A0+250ml+1%ED%8C%A9+(1%EC%9D%B8+1%EA%B0%9C)_1990.png','판매중','이미지',0x00,'2',NULL),(21,'[헤밀레] 알파CD 알파시클로덱스트린 제로팻 자몽맛','상품 설명',1,22000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%ED%97%A4%EB%B0%80%EB%A0%88%5D+%EC%95%8C%ED%8C%8CCD+%EC%95%8C%ED%8C%8C%EC%8B%9C%ED%81%B4%EB%A1%9C%EB%8D%B1%EC%8A%A4%ED%8A%B8%EB%A6%B0+%EC%A0%9C%EB%A1%9C%ED%8C%BB+%EC%9E%90%EB%AA%BD%EB%A7%9B_22000.jpg','판매중','이미지',0x00,'2',NULL),(22,'[헤밀레] 여주 뽕잎 초산 5% 저당 발효 식초','상품 설명',1,18000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%5B%ED%97%A4%EB%B0%80%EB%A0%88%5D+%EC%97%AC%EC%A3%BC+%EB%BD%95%EC%9E%8E+%EC%B4%88%EC%82%B0+5%25+%EC%A0%80%EB%8B%B9+%EB%B0%9C%ED%9A%A8+%EC%8B%9D%EC%B4%88_18000.jpg','판매중','이미지',0x00,'2',NULL),(23,'모카 단백질 스테비아 커피믹스 30T','상품 설명',1,13200,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%EB%AA%A8%EC%B9%B4+%EB%8B%A8%EB%B0%B1%EC%A7%88+%EC%8A%A4%ED%85%8C%EB%B9%84%EC%95%84+%EC%BB%A4%ED%94%BC%EB%AF%B9%EC%8A%A4+30T_13200.jpg','판매중','이미지',0x00,'2',NULL),(24,'선재광의 피엔 제주 국산 비트차 쑥차 무차 모음','상품 설명',1,22500,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%EC%84%A0%EC%9E%AC%EA%B4%91%EC%9D%98+%ED%94%BC%EC%97%94+%EC%A0%9C%EC%A3%BC+%EA%B5%AD%EC%82%B0+%EB%B9%84%ED%8A%B8%EC%B0%A8+%EC%91%A5%EC%B0%A8+%EB%AC%B4%EC%B0%A8+%EB%AA%A8%EC%9D%8C_22500.jpg','판매중','이미지',0x00,'2',NULL),(25,'신앙촌 프리&프로바이오틱스 런 요구르트 14병','상품 설명',1,22000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/2_%EC%8B%A0%EC%95%99%EC%B4%8C+%ED%94%84%EB%A6%AC%26%ED%94%84%EB%A1%9C%EB%B0%94%EC%9D%B4%EC%98%A4%ED%8B%B1%EC%8A%A4+%EB%9F%B0+%EC%9A%94%EA%B5%AC%EB%A5%B4%ED%8A%B8+14%EB%B3%91_22000.jpg','판매중','이미지',0x00,'2',NULL),(26,'당당한 바나나맛','상품 설명',1,4900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/banana.png','판매중','이미지',0x00,'2',NULL),(27,'글루어트','상품 설명',1,4800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/gluet.png','판매중','이미지',0x00,'2',NULL),(28,'핫초코','상품 설명',1,4600,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/hotchoco.png','판매중','이미지',0x00,'2',NULL),(29,'글루어트 베지 스타터','상품 설명',1,9800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/hotchoco.png','판매중','이미지',0x00,'2',NULL),(30,'야구르트','상품 설명',1,2400,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/drink/yogurt.jpg','판매중','이미지',0x00,'2',NULL),(31,'[닥다몰 10% 추가할인] 세븐프로골드 7대 통합 올인원 쉐이크, 대용량팩 (28회분), 식단+혈당+체중 관리를 한번에','상품 설명',1,98000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0+10%25+%EC%B6%94%EA%B0%80%ED%95%A0%EC%9D%B8%5D+%EC%84%B8%EB%B8%90%ED%94%84%EB%A1%9C%EA%B3%A8%EB%93%9C+7%EB%8C%80+%ED%86%B5%ED%95%A9+%EC%98%AC%EC%9D%B8%EC%9B%90+%EC%89%90%EC%9D%B4%ED%81%AC%2C+%EB%8C%80%EC%9A%A9%EB%9F%89%ED%8C%A9+(28%ED%9A%8C%EB%B6%84)%2C+%EC%8B%9D%EB%8B%A8%2B%ED%98%88%EB%8B%B9%2B%EC%B2%B4%EC%A4%91+%EA%B4%80%EB%A6%AC%EB%A5%BC+%ED%95%9C%EB%B2%88%EC%97%90_98000.jpg','판매중','이미지',0x00,'1',NULL),(32,'[닥다몰&맘플레이]당뇨식단 장기할인(12주x주2회 배송)','상품 설명',1,612750,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0%26%EB%A7%98%ED%94%8C%EB%A0%88%EC%9D%B4%5D%EB%8B%B9%EB%87%A8%EC%8B%9D%EB%8B%A8+%EC%9E%A5%EA%B8%B0%ED%95%A0%EC%9D%B8(12%EC%A3%BCx%EC%A3%BC2%ED%9A%8C+%EB%B0%B0%EC%86%A1)_612750.png','판매중','이미지',0x00,'1',NULL),(33,'[닥다몰&맘플레이]당뇨식단(1개월 배송)','상품 설명',1,109000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0%26%EB%A7%98%ED%94%8C%EB%A0%88%EC%9D%B4%5D%EB%8B%B9%EB%87%A8%EC%8B%9D%EB%8B%A8(1%EA%B0%9C%EC%9B%94+%EB%B0%B0%EC%86%A1)_109000.png','판매중','이미지',0x00,'1',NULL),(34,'[닥다몰&맘플레이]임당식단(1개월 배송)','상품 설명',1,273600,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0%26%EB%A7%98%ED%94%8C%EB%A0%88%EC%9D%B4%5D%EC%9E%84%EB%8B%B9%EC%8B%9D%EB%8B%A8(1%EA%B0%9C%EC%9B%94+%EB%B0%B0%EC%86%A1)_273600.png','판매중','이미지',0x00,'1',NULL),(35,'[닥다몰&맘플레이]임당식단(2주 배송)','상품 설명',1,144000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0%26%EB%A7%98%ED%94%8C%EB%A0%88%EC%9D%B4%5D%EC%9E%84%EB%8B%B9%EC%8B%9D%EB%8B%A8(2%EC%A3%BC+%EB%B0%B0%EC%86%A1)_144000.png','판매중','이미지',0x00,'1',NULL),(36,'[닥다몰&맘플레이]저염식단(1개월 배송)','상품 설명',1,109000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EB%8B%A5%EB%8B%A4%EB%AA%B0%26%EB%A7%98%ED%94%8C%EB%A0%88%EC%9D%B4%5D%EC%A0%80%EC%97%BC%EC%8B%9D%EB%8B%A8(1%EA%B0%9C%EC%9B%94+%EB%B0%B0%EC%86%A1)_109000.png','판매중','이미지',0x00,'1',NULL),(37,'[이츠스포츠] 혈당커팅 프로틴 쉐이크 4종','상품 설명',1,26520,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EC%9D%B4%EC%B8%A0%EC%8A%A4%ED%8F%AC%EC%B8%A0%5D+%ED%98%88%EB%8B%B9%EC%BB%A4%ED%8C%85+%ED%94%84%EB%A1%9C%ED%8B%B4+%EC%89%90%EC%9D%B4%ED%81%AC+4%EC%A2%85_26520.png','판매중','이미지',0x00,'1',NULL),(38,'[천호엔케어] 액티브솔루션 프로틴플러스 30포','상품 설명',1,72000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%5B%EC%B2%9C%ED%98%B8%EC%97%94%EC%BC%80%EC%96%B4%5D+%EC%95%A1%ED%8B%B0%EB%B8%8C%EC%86%94%EB%A3%A8%EC%85%98+%ED%94%84%EB%A1%9C%ED%8B%B4%ED%94%8C%EB%9F%AC%EC%8A%A4+30%ED%8F%AC_72000.jpg','판매중','이미지',0x00,'1',NULL),(39,'세븐프로골드 7대 통합 올인원 쉐이크, 본품 2개 세트 (14회분), 식단+혈당+체중 관리를 한번에','상품 설명',1,59000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/mealplan/1_%EC%84%B8%EB%B8%90%ED%94%84%EB%A1%9C%EA%B3%A8%EB%93%9C+7%EB%8C%80+%ED%86%B5%ED%95%A9+%EC%98%AC%EC%9D%B8%EC%9B%90+%EC%89%90%EC%9D%B4%ED%81%AC%2C+%EB%B3%B8%ED%92%88+2%EA%B0%9C+%EC%84%B8%ED%8A%B8+(14%ED%9A%8C%EB%B6%84)%2C+%EC%8B%9D%EB%8B%A8%2B%ED%98%88%EB%8B%B9%2B%EC%B2%B4%EC%A4%91+%EA%B4%80%EB%A6%AC%EB%A5%BC+%ED%95%9C%EB%B2%88%EC%97%90_59000.jpg','판매중','이미지',0x00,'1',NULL),(40,'[고고단] 프로틴 그래놀라 4종 24팩','상품 설명',1,37900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EA%B3%A0%EA%B3%A0%EB%8B%A8%5D+%ED%94%84%EB%A1%9C%ED%8B%B4+%EA%B7%B8%EB%9E%98%EB%86%80%EB%9D%BC+4%EC%A2%85+24%ED%8C%A9_37900.jpg','판매중','이미지',0x00,'0',NULL),(41,'[바르닭] 곡물 곤약밥 25팩','상품 설명',1,36900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EB%B0%94%EB%A5%B4%EB%8B%AD%5D+%EA%B3%A1%EB%AC%BC+%EA%B3%A4%EC%95%BD%EB%B0%A5+25%ED%8C%A9_36900.jpg','판매중','이미지',0x00,'0',NULL),(42,'[바르닭] 셀렉트밀 소스 닭가슴살 x 2팩','상품 설명',1,3800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EB%B0%94%EB%A5%B4%EB%8B%AD%5D+%EC%85%80%EB%A0%89%ED%8A%B8%EB%B0%80+%EC%86%8C%EC%8A%A4+%EB%8B%AD%EA%B0%80%EC%8A%B4%EC%82%B4+x+2%ED%8C%A9_3800.jpg','판매중','이미지',0x00,'0',NULL),(43,'[바르닭] 소식좌 180g 볶음밥 4종 20팩','상품 설명',1,42900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EB%B0%94%EB%A5%B4%EB%8B%AD%5D+%EC%86%8C%EC%8B%9D%EC%A2%8C+180g+%EB%B3%B6%EC%9D%8C%EB%B0%A5+4%EC%A2%85+20%ED%8C%A9_42900.jpg','판매중','이미지',0x00,'0',NULL),(44,'[바르닭x오뚜기] 순후추 품은 닭가슴살 x 2팩','상품 설명',1,4800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EB%B0%94%EB%A5%B4%EB%8B%ADx%EC%98%A4%EB%9A%9C%EA%B8%B0%5D+%EC%88%9C%ED%9B%84%EC%B6%94+%ED%92%88%EC%9D%80+%EB%8B%AD%EA%B0%80%EC%8A%B4%EC%82%B4+x+2%ED%8C%A9_4800.jpg','판매중','이미지',0x00,'0',NULL),(45,'[바르닭x오뚜기] 순후추 품은 스테이크 x 2팩','상품 설명',1,4800,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EB%B0%94%EB%A5%B4%EB%8B%ADx%EC%98%A4%EB%9A%9C%EA%B8%B0%5D+%EC%88%9C%ED%9B%84%EC%B6%94+%ED%92%88%EC%9D%80+%EC%8A%A4%ED%85%8C%EC%9D%B4%ED%81%AC+x+2%ED%8C%A9_4800.jpg','판매중','이미지',0x00,'0',NULL),(46,'[이츠스포츠] 혈당커팅 프로틴 쉐이크 4종','상품 설명',1,26520,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%EC%9D%B4%EC%B8%A0%EC%8A%A4%ED%8F%AC%EC%B8%A0%5D+%ED%98%88%EB%8B%B9%EC%BB%A4%ED%8C%85+%ED%94%84%EB%A1%9C%ED%8B%B4+%EC%89%90%EC%9D%B4%ED%81%AC+4%EC%A2%85_26520.png','판매중','이미지',0x00,'0',NULL),(47,'[팀키토] 이베리코 저당 만두 냉동 굴림 글루텐프리(4팩번들상품)','상품 설명',1,23600,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%ED%8C%80%ED%82%A4%ED%86%A0%5D+%EC%9D%B4%EB%B2%A0%EB%A6%AC%EC%BD%94+%EC%A0%80%EB%8B%B9+%EB%A7%8C%EB%91%90+%EB%83%89%EB%8F%99+%EA%B5%B4%EB%A6%BC+%EA%B8%80%EB%A3%A8%ED%85%90%ED%94%84%EB%A6%AC(4%ED%8C%A9%EB%B2%88%EB%93%A4%EC%83%81%ED%92%88)_23600.png','판매중','이미지',0x00,'0',NULL),(48,'[한마당] 글루텐프리 국내산100% 메밀숙면 들기름막국수(3인분,1인분씩 개별포장)','상품 설명',1,34000,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%5B%ED%95%9C%EB%A7%88%EB%8B%B9%5D+%EA%B8%80%EB%A3%A8%ED%85%90%ED%94%84%EB%A6%AC+%EA%B5%AD%EB%82%B4%EC%82%B0100%25+%EB%A9%94%EB%B0%80%EC%88%99%EB%A9%B4+%EB%93%A4%EA%B8%B0%EB%A6%84%EB%A7%89%EA%B5%AD%EC%88%98(3%EC%9D%B8%EB%B6%84%2C1%EC%9D%B8%EB%B6%84%EC%94%A9+%EA%B0%9C%EB%B3%84%ED%8F%AC%EC%9E%A5)_34000.jpg','판매중','이미지',0x00,'0',NULL),(49,'국산 100% 5분도 현미 룽칩 380g 누룽지 아침 식사대용','상품 설명',1,20900,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/readymeal/0_%EA%B5%AD%EC%82%B0+100%25+5%EB%B6%84%EB%8F%84+%ED%98%84%EB%AF%B8+%EB%A3%BD%EC%B9%A9+380g+%EB%88%84%EB%A3%BD%EC%A7%80+%EC%95%84%EC%B9%A8+%EC%8B%9D%EC%82%AC%EB%8C%80%EC%9A%A9_20900.jpg','판매중','이미지',0x00,'0',NULL),(50,'banner2','상품 설명',1,0,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/banner/banner2.png','판매중','배너',0x01,'5',NULL),(51,'banner4','상품 설명',1,0,'https://mall-clone.s3.ap-northeast-2.amazonaws.com/banner/banner3.png','판매중','배너',0x01,'5',NULL);
/*!40000 ALTER TABLE `c_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_test`
--

DROP TABLE IF EXISTS `c_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_test` (
  `COL` varchar(255) DEFAULT NULL,
  `COL2` varchar(255) DEFAULT NULL,
  `COL3` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_test`
--

LOCK TABLES `c_test` WRITE;
/*!40000 ALTER TABLE `c_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_user`
--

DROP TABLE IF EXISTS `c_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `address_detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `signout` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `join_date` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `outdate_at` datetime DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_user`
--

LOCK TABLES `c_user` WRITE;
/*!40000 ALTER TABLE `c_user` DISABLE KEYS */;
INSERT INTO `c_user` VALUES (4,'현정','동작구',NULL,'test@test.com','01000000000','N','2025-09-10 22:00:40','2025-09-10 22:00:40',NULL,'$2a$10$kxZSqTrk9rjdHDaVG.Re8.WSuW1lZskk//goSGUq4anlsa2fa9ED2'),(5,'정세인','서울시',NULL,'sein@naver.com','01094046005','N','2025-09-11 12:37:41','2025-09-11 12:37:41',NULL,'$2a$10$.e51Q0aqkjxZy.jtkR95cebif6KN7YcntZB2ZSwdL/TpQznGw/U7m'),(9,'김현정','서울시 동작구',NULL,'hjk_1137@naver.com','01000001234','N','2025-10-16 12:47:43','2025-10-16 12:47:43',NULL,'$2a$10$1j3mzULkMQQ3IoJljU1hZOZIkUgWELXqANCdDfvl/yqsspq2KFTHa');
/*!40000 ALTER TABLE `c_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `token` varchar(255) NOT NULL,
  `used` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_g0guo4k8krgpwuagos61oc06j` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_token`
--

LOCK TABLES `password_reset_token` WRITE;
/*!40000 ALTER TABLE `password_reset_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-23  9:26:35
