
-- MySQL dump 10.13  Distrib 9.4.0, for Win64 (x86_64)
--
-- Host: localhost    Database: flight_reservation
-- ------------------------------------------------------
-- Server version	9.4.0

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

-- Create the database if it doesn't exist and switch to it
CREATE DATABASE IF NOT EXISTS `flight_reservation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `flight_reservation`;

--
-- Table structure for table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircrafts` (
    `aircraft_id` int NOT NULL AUTO_INCREMENT,
    `total_seats` int NOT NULL,
    PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircrafts`
--

LOCK TABLES `aircrafts` WRITE;
/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` VALUES (1,64),(2,124),(3,100),(4,75);
/*!40000 ALTER TABLE `aircrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
    `airport_id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(150) NOT NULL,
    `code` char(3) NOT NULL,
    `city` varchar(100) DEFAULT NULL,
    `country` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`airport_id`),
    UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES (2,'Jolly Grant','DEH','Dehradun','India'),(3,'Indira Gandhi Intl.','DEL','New Delhi','India'),(4,'Chhatrapati Shivaji Maharaj Intl.','BOM','Mumbai','India'),(5,'Chennai Intl.','MAA','Chennai','India'),(6,'Netaji Subhas Chandra Bose Intl.','CCU','Kolkata, West Bengal','India'),(7,'Rajiv Gandhi Intl.','HYD','Hyderabad, Telangana','India'),(8,'Cochin Intl.','COK','Kochi, Kerala','India'),(9,'Sardar Vallabhbhai Patel Intl.','AMD','Ahmedabad, Gujarat','India'),(10,'Goa Intl. (Dabolim)','GOI','Vasco da Gama, Goa','India'),(11,'Mopa Intl.','GOX','Mopa, Goa','India'),(12,'Trivandrum Intl.','TRV','Thiruvananthapuram, Kerala','India'),(13,'Calicut Intl.','CCJ','Kozhikode, Kerala','India'),(14,'Jaipur Intl.','JAI','Jaipur, Rajasthan','India'),(15,'Chaudhary Charan Singh Intl.','LKO','Lucknow, Uttar Pradesh','India'),(16,'Sri Guru Ram Dass Jee Intl.','ATQ','Amritsar, Punjab','India'),(17,'Chandigarh Intl.','IXC','Chandigarh, Punjab/Haryana','India'),(18,'Pune Intl.','PNQ','Pune, Maharashtra','India'),(19,'Kannur Intl.','CNN','Kannur, Kerala','India'),(20,'Mangalore Intl.','IXE','Mangalore, Karnataka','India'),(21,'Coimbatore Intl.','CJB','Coimbatore, Tamil Nadu','India'),(22,'Madurai Intl.','IXM','Madurai, Tamil Nadu','India'),(23,'Tiruchirappalli Intl.','TRZ','Tiruchirappalli, Tamil Nadu','India'),(24,'Visakhapatnam Intl.','VTZ','Visakhapatnam, Andhra Pradesh','India'),(25,'Vijayawada Intl.','VGA','Vijayawada, Andhra Pradesh','India'),(26,'Lokpriya Gopinath Bordoloi Intl.','GAU','Guwahati, Assam','India'),(27,'Bagdogra Intl.','IXB','Siliguri, West Bengal','India'),(28,'Maharaja Bir Bikram Intl.','IXA','Agartala, Tripura','India'),(29,'Bir Tikendrajit Intl.','IMF','Imphal, Manipur','India'),(30,'Dibrugarh Intl.','DIB','Dibrugarh, Assam','India'),(31,'Veer Savarkar Intl.','IXZ','Port Blair, Andaman & Nicobar','India'),(32,'Biju Patnaik Intl.','BBI','Bhubaneswar, Odisha','India'),(33,'Birsa Munda Intl.','IXR','Ranchi, Jharkhand','India'),(34,'Dr. Babasaheb Ambedkar Intl.','NAG','Nagpur, Maharashtra','India'),(35,'Gaya Intl.','GAY','Gaya, Bihar','India'),(36,'Kushinagar Intl.','KJU','Kushinagar, Uttar Pradesh','India'),(37,'Maharishi Valmiki Intl.','AYJ','Ayodhya, Uttar Pradesh','India');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_passengers`
--

DROP TABLE IF EXISTS `booking_passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_passengers` (
    `passenger_id` int NOT NULL AUTO_INCREMENT,
    `booking_id` int NOT NULL,
    `name` varchar(100) NOT NULL,
    `age` int DEFAULT NULL,
    `gender` enum('M','F','O') DEFAULT NULL,
    `seat_id` int DEFAULT NULL,
    PRIMARY KEY (`passenger_id`),
    KEY `booking_id` (`booking_id`),
    KEY `seat_id` (`seat_id`),
    CONSTRAINT `booking_passengers_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
    CONSTRAINT `booking_passengers_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_passengers`
--

LOCK TABLES `booking_passengers` WRITE;
/*!40000 ALTER TABLE `booking_passengers` DISABLE KEYS */;
INSERT INTO `booking_passengers` VALUES (1,1,'Kuldeep',22,'M',NULL),(2,1,'Kanchan',23,'F',NULL),(3,2,'Kuldeep',22,'M',NULL),(4,2,'Kanchan',23,'F',NULL);
/*!40000 ALTER TABLE `booking_passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
    `booking_id` int NOT NULL AUTO_INCREMENT,
    `user_id` int NOT NULL,
    `flight_id` int NOT NULL,
    `booking_reference` varchar(20) NOT NULL,
    `booking_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` enum('booked','cancelled') DEFAULT 'booked',
    PRIMARY KEY (`booking_id`),
    UNIQUE KEY `booking_reference` (`booking_reference`),
    KEY `user_id` (`user_id`),
    KEY `flight_id` (`flight_id`),
    CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,2,1,'BRMHPDLG3FDFM36E','2025-11-08 03:06:39','booked'),(2,2,1,'BRMHPDLLFT747AYE','2025-11-08 03:06:46','booked');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
    `flight_id` int NOT NULL AUTO_INCREMENT,
    `flight_number` varchar(20) NOT NULL,
    `aircraft_id` int NOT NULL,
    `departure_airport_id` int NOT NULL,
    `arrival_airport_id` int NOT NULL,
    `departure_time` datetime NOT NULL,
    `arrival_time` datetime NOT NULL,
    `base_fare` decimal(10,2) NOT NULL,
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
    PRIMARY KEY (`flight_id`),
    UNIQUE KEY `flight_number` (`flight_number`),
    KEY `aircraft_id` (`aircraft_id`),
    KEY `departure_airport_id` (`departure_airport_id`),
    KEY `arrival_airport_id` (`arrival_airport_id`),
    CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircrafts` (`aircraft_id`),
    CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`departure_airport_id`) REFERENCES `airports` (`airport_id`),
    CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`arrival_airport_id`) REFERENCES `airports` (`airport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'248198',1,2,14,'2025-11-08 23:30:00','2025-11-08 03:00:00',4000.00,0),(22,'6E201',1,2,3,'2025-11-10 07:30:00','2025-11-10 09:55:00',5500.00,0),(23,'AI405',2,3,4,'2025-11-11 12:00:00','2025-11-11 14:35:00',4800.00,0),(24,'SG302',1,4,5,'2025-11-12 08:45:00','2025-11-12 11:20:00',5100.00,0),(25,'UK501',2,5,6,'2025-11-13 09:30:00','2025-11-13 11:15:00',5200.00,0),(26,'G812',1,6,7,'2025-11-14 06:50:00','2025-11-14 08:25:00',4700.00,0),(27,'AI109',3,7,9,'2025-11-15 15:10:00','2025-11-15 17:30:00',6200.00,0),(28,'6E707',1,9,11,'2025-11-16 10:00:00','2025-11-16 12:10:00',5900.00,0),(29,'SG509',2,11,13,'2025-11-17 18:30:00','2025-11-17 21:00:00',5300.00,0),(30,'AI711',3,13,14,'2025-11-18 06:00:00','2025-11-18 08:20:00',5600.00,0),(31,'UK810',1,14,2,'2025-11-19 19:30:00','2025-11-19 21:45:00',6400.00,0);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
    `payment_id` int NOT NULL AUTO_INCREMENT,
    `booking_id` int NOT NULL,
    `amount` decimal(10,2) NOT NULL,
    `method` enum('card','upi','netbanking') NOT NULL,
    `payment_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` enum('success','failed','refunded') DEFAULT 'success',
    PRIMARY KEY (`payment_id`),
    KEY `booking_id` (`booking_id`),
    CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
    `seat_id` int NOT NULL AUTO_INCREMENT,
    `aircraft_id` int NOT NULL,
    `seat_number` varchar(10) NOT NULL,
    `seat_class` enum('economy','business','first') NOT NULL,
    PRIMARY KEY (`seat_id`),
    KEY `aircraft_id` (`aircraft_id`),
    CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircrafts` (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
    `user_id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `email` varchar(150) NOT NULL,
    `phone` varchar(20) DEFAULT NULL,
    `password_hash` varchar(255) NOT NULL,
    `role` enum('customer','admin') DEFAULT 'customer',
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alice','alice@example.com',NULL,'$2b$10$cAvl3jZIo/z6bzjy39npkOoMZ1l6ot2luFD4qIQz/P5mmr8lrylfO','customer'),(2,'Sarthak Singh','sarthak2528@gmail.com',NULL,'$2b$10$PLRznhw6IDK8sR1sxIZvWunCDIlBIQ1OKHaUNjc43Tndz0tU4Llq.','admin'),(3,'Abhinav','abhi@gmail.com','123456789','$2b$10$Xg9OtXCGRyDVF9IgX0ZEnejT1A4ndDMgdaKvB3FhQwIWY5sC.ABYC','customer');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 19:57:24
