-- MySQL dump 10.13  Distrib 9.5.0, for Win64 (x86_64)
--
-- Host: localhost    Database: final_exam
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'b815ae4d-d5f2-11f0-992b-745d222a05a6:1-20';

--
-- Table structure for table `applicanttable`
--

DROP TABLE IF EXISTS `applicanttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicanttable` (
  `applicant_id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) DEFAULT NULL,
  `contact` varchar(10) DEFAULT NULL,
  `education` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`applicant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicanttable`
--

LOCK TABLES `applicanttable` WRITE;
/*!40000 ALTER TABLE `applicanttable` DISABLE KEYS */;
INSERT INTO `applicanttable` VALUES (1,'vijay','1234567890','Masters','1994-12-15',12345678.00),(2,'Vijay','1234567890','Masters','1994-11-30',4500.50),(3,'Vijay Jannu','1234567891','Masters','1993-12-15',6000.50);
/*!40000 ALTER TABLE `applicanttable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employmentapplication`
--

DROP TABLE IF EXISTS `employmentapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employmentapplication` (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `applicant_id` int DEFAULT NULL,
  `applied_on` date DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `employmentapplication_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicanttable` (`applicant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employmentapplication`
--

LOCK TABLES `employmentapplication` WRITE;
/*!40000 ALTER TABLE `employmentapplication` DISABLE KEYS */;
INSERT INTO `employmentapplication` VALUES (1,1,'2025-12-11'),(2,2,'2025-12-11'),(3,3,'2025-12-11');
/*!40000 ALTER TABLE `employmentapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employmenttable`
--

DROP TABLE IF EXISTS `employmenttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employmenttable` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `applicant_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `applicant_id` (`applicant_id`),
  CONSTRAINT `employmenttable_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicanttable` (`applicant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employmenttable`
--

LOCK TABLES `employmenttable` WRITE;
/*!40000 ALTER TABLE `employmenttable` DISABLE KEYS */;
INSERT INTO `employmenttable` VALUES (1,1,'Pending'),(2,2,'Pending'),(3,3,'Pending');
/*!40000 ALTER TABLE `employmenttable` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11  9:58:18
