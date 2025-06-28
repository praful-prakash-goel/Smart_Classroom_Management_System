-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: school_management_system
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_details`
--

DROP TABLE IF EXISTS `appointment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_details` (
  `instructor_id` int NOT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday') NOT NULL,
  `time` varchar(20) NOT NULL,
  PRIMARY KEY (`instructor_id`,`day`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_details`
--

LOCK TABLES `appointment_details` WRITE;
/*!40000 ALTER TABLE `appointment_details` DISABLE KEYS */;
INSERT INTO `appointment_details` VALUES (101,'Thursday','3:00-4:00 PM'),(102,'Thursday','3:00-4:00 PM'),(105,'Tuesday','2:00-4:00 PM');
/*!40000 ALTER TABLE `appointment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_report`
--

DROP TABLE IF EXISTS `attendance_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_report` (
  `roll_no` int NOT NULL,
  `subject` varchar(50) NOT NULL,
  `attendance_percentage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`roll_no`,`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_report`
--

LOCK TABLES `attendance_report` WRITE;
/*!40000 ALTER TABLE `attendance_report` DISABLE KEYS */;
INSERT INTO `attendance_report` VALUES (2301001,'Artificial Intelligence',73.39),(2301001,'Data Structures',71.17),(2301001,'Operating Systems',63.62),(2301002,'Artificial Intelligence',83.70),(2301002,'Data Structures',89.24),(2301002,'Operating Systems',73.55),(2301003,'Artificial Intelligence',81.69),(2301003,'Data Structures',61.27),(2301003,'Operating Systems',79.57),(2301004,'Artificial Intelligence',80.99),(2301004,'Data Structures',69.40),(2301004,'Operating Systems',80.04),(2301005,'Artificial Intelligence',85.73),(2301005,'Data Structures',94.83),(2301005,'Operating Systems',75.36),(2301006,'Artificial Intelligence',89.54),(2301006,'Data Structures',75.32),(2301006,'Operating Systems',89.62),(2301007,'Artificial Intelligence',73.66),(2301007,'Data Structures',70.83),(2301007,'Operating Systems',95.35),(2301008,'Artificial Intelligence',60.29),(2301008,'Data Structures',69.93),(2301008,'Operating Systems',64.95),(2301009,'Artificial Intelligence',66.75),(2301009,'Data Structures',97.77),(2301009,'Operating Systems',72.13),(2301010,'Artificial Intelligence',82.57),(2301010,'Data Structures',94.30),(2301010,'Operating Systems',94.59),(2301011,'Artificial Intelligence',70.82),(2301011,'Data Structures',76.01),(2301011,'Operating Systems',62.01),(2301012,'Artificial Intelligence',82.47),(2301012,'Data Structures',65.24),(2301012,'Operating Systems',91.66),(2301013,'Artificial Intelligence',84.52),(2301013,'Data Structures',65.29),(2301013,'Operating Systems',82.09),(2301014,'Artificial Intelligence',94.17),(2301014,'Data Structures',85.59),(2301014,'Operating Systems',80.30),(2301015,'Artificial Intelligence',62.50),(2301015,'Data Structures',96.67),(2301015,'Operating Systems',66.53),(2301016,'Artificial Intelligence',62.91),(2301016,'Data Structures',94.74),(2301016,'Operating Systems',61.34),(2301017,'Artificial Intelligence',67.20),(2301017,'Data Structures',72.12),(2301017,'Operating Systems',99.32),(2301018,'Artificial Intelligence',78.26),(2301018,'Data Structures',77.55),(2301018,'Operating Systems',89.53),(2301019,'Artificial Intelligence',93.53),(2301019,'Data Structures',80.29),(2301019,'Operating Systems',71.25),(2301020,'Artificial Intelligence',78.95),(2301020,'Data Structures',95.00),(2301020,'Operating Systems',87.47),(2301021,'Artificial Intelligence',84.80),(2301021,'Data Structures',79.61),(2301021,'Operating Systems',70.29),(2301022,'Artificial Intelligence',73.95),(2301022,'Data Structures',78.22),(2301022,'Operating Systems',91.88),(2301023,'Artificial Intelligence',72.05),(2301023,'Data Structures',67.30),(2301023,'Operating Systems',73.52),(2301024,'Artificial Intelligence',64.30),(2301024,'Data Structures',67.68),(2301024,'Operating Systems',68.30),(2301025,'Artificial Intelligence',70.39),(2301025,'Data Structures',78.06),(2301025,'Operating Systems',80.43),(2301026,'Artificial Intelligence',72.18),(2301026,'Data Structures',64.50),(2301026,'Operating Systems',93.85),(2301027,'Artificial Intelligence',92.59),(2301027,'Data Structures',65.54),(2301027,'Operating Systems',63.80),(2301028,'Artificial Intelligence',63.35),(2301028,'Data Structures',67.09),(2301028,'Operating Systems',86.60),(2301029,'Artificial Intelligence',61.67),(2301029,'Data Structures',82.81),(2301029,'Operating Systems',66.60),(2301030,'Artificial Intelligence',93.21),(2301030,'Data Structures',97.25),(2301030,'Operating Systems',90.66),(2301031,'Artificial Intelligence',77.96),(2301031,'Data Structures',94.32),(2301031,'Operating Systems',98.36),(2301032,'Artificial Intelligence',94.51),(2301032,'Data Structures',78.87),(2301032,'Operating Systems',85.01),(2301033,'Artificial Intelligence',81.10),(2301033,'Data Structures',95.77),(2301033,'Operating Systems',71.64),(2301034,'Artificial Intelligence',79.63),(2301034,'Data Structures',67.32),(2301034,'Operating Systems',89.83),(2301035,'Artificial Intelligence',92.67),(2301035,'Data Structures',76.55),(2301035,'Operating Systems',92.45),(2301036,'Artificial Intelligence',90.77),(2301036,'Data Structures',80.01),(2301036,'Operating Systems',67.63),(2301037,'Artificial Intelligence',97.13),(2301037,'Data Structures',95.32),(2301037,'Operating Systems',66.57),(2301038,'Artificial Intelligence',99.79),(2301038,'Data Structures',72.30),(2301038,'Operating Systems',63.93),(2301039,'Artificial Intelligence',68.04),(2301039,'Data Structures',93.81),(2301039,'Operating Systems',64.96),(2301040,'Artificial Intelligence',81.06),(2301040,'Data Structures',81.20),(2301040,'Operating Systems',72.33),(2301041,'Artificial Intelligence',63.36),(2301041,'Data Structures',68.40),(2301041,'Operating Systems',85.69),(2301042,'Artificial Intelligence',64.14),(2301042,'Data Structures',89.32),(2301042,'Operating Systems',69.14),(2301043,'Artificial Intelligence',70.28),(2301043,'Data Structures',77.35),(2301043,'Operating Systems',61.95),(2301044,'Artificial Intelligence',80.85),(2301044,'Data Structures',93.76),(2301044,'Operating Systems',97.93),(2301045,'Artificial Intelligence',79.79),(2301045,'Data Structures',90.27),(2301045,'Operating Systems',93.13),(2301046,'Artificial Intelligence',66.01),(2301046,'Data Structures',88.29),(2301046,'Operating Systems',87.96),(2301047,'Artificial Intelligence',82.74),(2301047,'Data Structures',74.14),(2301047,'Operating Systems',83.75),(2301048,'Artificial Intelligence',84.77),(2301048,'Data Structures',91.43),(2301048,'Operating Systems',92.99),(2301049,'Artificial Intelligence',92.87),(2301049,'Data Structures',76.16),(2301049,'Operating Systems',77.25),(2301050,'Artificial Intelligence',81.71),(2301050,'Data Structures',80.65),(2301050,'Operating Systems',95.76),(2301051,'Artificial Intelligence',61.96),(2301051,'Data Structures',98.99),(2301051,'Operating Systems',88.86),(2301052,'Artificial Intelligence',75.94),(2301052,'Data Structures',60.28),(2301052,'Operating Systems',83.45),(2301053,'Artificial Intelligence',63.41),(2301053,'Data Structures',83.36),(2301053,'Operating Systems',93.05),(2301054,'Artificial Intelligence',91.58),(2301054,'Data Structures',87.29),(2301054,'Operating Systems',70.54),(2301055,'Artificial Intelligence',74.11),(2301055,'Data Structures',86.07),(2301055,'Operating Systems',92.66),(2301056,'Artificial Intelligence',72.12),(2301056,'Data Structures',90.63),(2301056,'Operating Systems',60.09),(2301057,'Artificial Intelligence',61.57),(2301057,'Data Structures',86.87),(2301057,'Operating Systems',69.87),(2301058,'Artificial Intelligence',90.79),(2301058,'Data Structures',97.25),(2301058,'Operating Systems',83.39),(2301059,'Artificial Intelligence',85.74),(2301059,'Data Structures',66.22),(2301059,'Operating Systems',76.08),(2301060,'Artificial Intelligence',63.39),(2301060,'Data Structures',78.61),(2301060,'Operating Systems',73.99),(2301061,'Artificial Intelligence',79.21),(2301061,'Data Structures',75.57),(2301061,'Operating Systems',73.93),(2301062,'Artificial Intelligence',63.47),(2301062,'Data Structures',85.33),(2301062,'Operating Systems',92.89),(2301063,'Artificial Intelligence',81.34),(2301063,'Data Structures',91.34),(2301063,'Operating Systems',60.01),(2301064,'Artificial Intelligence',63.57),(2301064,'Data Structures',84.22),(2301064,'Operating Systems',87.68),(2301065,'Artificial Intelligence',85.37),(2301065,'Data Structures',81.33),(2301065,'Operating Systems',83.83),(2301066,'Artificial Intelligence',81.92),(2301066,'Data Structures',92.35),(2301066,'Operating Systems',80.22),(2301067,'Artificial Intelligence',63.13),(2301067,'Data Structures',71.08),(2301067,'Operating Systems',93.01),(2301068,'Artificial Intelligence',99.86),(2301068,'Data Structures',77.74),(2301068,'Operating Systems',93.57),(2301069,'Artificial Intelligence',73.49),(2301069,'Data Structures',97.28),(2301069,'Operating Systems',87.85),(2301070,'Artificial Intelligence',85.62),(2301070,'Data Structures',73.97),(2301070,'Operating Systems',90.38),(2301071,'Artificial Intelligence',79.51),(2301071,'Data Structures',64.15),(2301071,'Operating Systems',68.20),(2301072,'Artificial Intelligence',62.47),(2301072,'Data Structures',85.52),(2301072,'Operating Systems',87.26),(2301073,'Artificial Intelligence',64.44),(2301073,'Data Structures',66.93),(2301073,'Operating Systems',74.52),(2301074,'Artificial Intelligence',90.78),(2301074,'Data Structures',90.16),(2301074,'Operating Systems',74.52),(2301075,'Artificial Intelligence',80.37),(2301075,'Data Structures',85.22),(2301075,'Operating Systems',82.37),(2301076,'Artificial Intelligence',99.05),(2301076,'Data Structures',75.71),(2301076,'Operating Systems',82.48),(2301077,'Artificial Intelligence',93.16),(2301077,'Data Structures',68.13),(2301077,'Operating Systems',73.44),(2301078,'Artificial Intelligence',64.37),(2301078,'Data Structures',72.95),(2301078,'Operating Systems',64.96),(2301079,'Artificial Intelligence',88.10),(2301079,'Data Structures',74.02),(2301079,'Operating Systems',88.02),(2301080,'Artificial Intelligence',65.80),(2301080,'Data Structures',83.80),(2301080,'Operating Systems',89.12),(2301081,'Artificial Intelligence',76.59),(2301081,'Data Structures',98.51),(2301081,'Operating Systems',96.96),(2301082,'Artificial Intelligence',86.49),(2301082,'Data Structures',92.34),(2301082,'Operating Systems',87.01),(2301083,'Artificial Intelligence',89.53),(2301083,'Data Structures',91.29),(2301083,'Operating Systems',88.35),(2301084,'Artificial Intelligence',91.28),(2301084,'Data Structures',63.29),(2301084,'Operating Systems',72.78),(2301085,'Artificial Intelligence',82.46),(2301085,'Data Structures',64.60),(2301085,'Operating Systems',61.08),(2301086,'Artificial Intelligence',90.05),(2301086,'Data Structures',69.65),(2301086,'Operating Systems',99.35),(2301087,'Artificial Intelligence',94.08),(2301087,'Data Structures',98.41),(2301087,'Operating Systems',71.31),(2301088,'Artificial Intelligence',74.08),(2301088,'Data Structures',85.99),(2301088,'Operating Systems',69.67),(2301089,'Artificial Intelligence',85.74),(2301089,'Data Structures',70.28),(2301089,'Operating Systems',88.91),(2301090,'Artificial Intelligence',65.04),(2301090,'Data Structures',86.01),(2301090,'Operating Systems',88.63),(2301091,'Artificial Intelligence',63.52),(2301091,'Data Structures',70.98),(2301091,'Operating Systems',90.18),(2301092,'Artificial Intelligence',73.86),(2301092,'Data Structures',83.24),(2301092,'Operating Systems',70.31),(2301093,'Artificial Intelligence',80.17),(2301093,'Data Structures',90.53),(2301093,'Operating Systems',82.04),(2301094,'Artificial Intelligence',72.53),(2301094,'Data Structures',60.54),(2301094,'Operating Systems',65.28),(2301095,'Artificial Intelligence',67.90),(2301095,'Data Structures',64.74),(2301095,'Operating Systems',84.89),(2301096,'Artificial Intelligence',91.24),(2301096,'Data Structures',76.16),(2301096,'Operating Systems',89.96),(2301097,'Artificial Intelligence',70.31),(2301097,'Data Structures',63.36),(2301097,'Operating Systems',88.44),(2301098,'Artificial Intelligence',87.63),(2301098,'Data Structures',81.56),(2301098,'Operating Systems',80.89),(2301099,'Artificial Intelligence',87.84),(2301099,'Data Structures',81.01),(2301099,'Operating Systems',87.99),(2301100,'Artificial Intelligence',78.43),(2301100,'Data Structures',92.14),(2301100,'Operating Systems',94.69),(2301101,'Artificial Intelligence',82.15),(2301101,'Data Structures',73.65),(2301101,'Operating Systems',86.07),(2301102,'Artificial Intelligence',63.98),(2301102,'Data Structures',87.33),(2301102,'Operating Systems',92.98),(2301103,'Artificial Intelligence',78.03),(2301103,'Data Structures',60.71),(2301103,'Operating Systems',91.76),(2301104,'Artificial Intelligence',74.17),(2301104,'Data Structures',69.01),(2301104,'Operating Systems',73.05),(2301105,'Artificial Intelligence',88.56),(2301105,'Data Structures',70.08),(2301105,'Operating Systems',62.44),(2301106,'Artificial Intelligence',90.95),(2301106,'Data Structures',90.71),(2301106,'Operating Systems',95.77),(2301107,'Artificial Intelligence',80.18),(2301107,'Data Structures',68.98),(2301107,'Operating Systems',90.06),(2301108,'Artificial Intelligence',97.01),(2301108,'Data Structures',89.34),(2301108,'Operating Systems',62.54),(2301109,'Artificial Intelligence',80.54),(2301109,'Data Structures',91.93),(2301109,'Operating Systems',79.11),(2301110,'Artificial Intelligence',89.73),(2301110,'Data Structures',80.23),(2301110,'Operating Systems',67.33),(2301111,'Artificial Intelligence',66.89),(2301111,'Data Structures',75.65),(2301111,'Operating Systems',83.13),(2301112,'Artificial Intelligence',87.73),(2301112,'Data Structures',67.45),(2301112,'Operating Systems',72.96),(2301113,'Artificial Intelligence',67.58),(2301113,'Data Structures',62.23),(2301113,'Operating Systems',83.52),(2301114,'Artificial Intelligence',61.57),(2301114,'Data Structures',93.68),(2301114,'Operating Systems',92.89),(2301115,'Artificial Intelligence',99.23),(2301115,'Data Structures',66.27),(2301115,'Operating Systems',99.65),(2301116,'Artificial Intelligence',69.14),(2301116,'Data Structures',72.01),(2301116,'Operating Systems',84.88),(2301117,'Artificial Intelligence',68.40),(2301117,'Data Structures',90.31),(2301117,'Operating Systems',91.27),(2301118,'Artificial Intelligence',70.03),(2301118,'Data Structures',66.31),(2301118,'Operating Systems',68.14),(2301119,'Artificial Intelligence',78.74),(2301119,'Data Structures',78.88),(2301119,'Operating Systems',62.82),(2301120,'Artificial Intelligence',61.84),(2301120,'Data Structures',83.87),(2301120,'Operating Systems',88.09),(2301121,'Artificial Intelligence',86.48),(2301121,'Data Structures',99.91),(2301121,'Operating Systems',64.04),(2301122,'Artificial Intelligence',85.40),(2301122,'Data Structures',87.69),(2301122,'Operating Systems',79.31),(2301123,'Artificial Intelligence',99.69),(2301123,'Data Structures',71.76),(2301123,'Operating Systems',86.00),(2301124,'Artificial Intelligence',70.56),(2301124,'Data Structures',75.61),(2301124,'Operating Systems',78.62),(2301125,'Artificial Intelligence',70.34),(2301125,'Data Structures',62.98),(2301125,'Operating Systems',65.25),(2301126,'Artificial Intelligence',76.66),(2301126,'Data Structures',73.11),(2301126,'Operating Systems',76.38),(2301127,'Artificial Intelligence',73.23),(2301127,'Data Structures',60.24),(2301127,'Operating Systems',93.31),(2301128,'Artificial Intelligence',61.38),(2301128,'Data Structures',73.96),(2301128,'Operating Systems',66.02),(2301129,'Artificial Intelligence',83.82),(2301129,'Data Structures',92.07),(2301129,'Operating Systems',72.59),(2301130,'Artificial Intelligence',82.45),(2301130,'Data Structures',66.56),(2301130,'Operating Systems',91.38),(2301131,'Artificial Intelligence',74.72),(2301131,'Data Structures',88.33),(2301131,'Operating Systems',74.43),(2301132,'Artificial Intelligence',74.07),(2301132,'Data Structures',67.61),(2301132,'Operating Systems',89.49),(2301133,'Artificial Intelligence',96.98),(2301133,'Data Structures',60.34),(2301133,'Operating Systems',89.68),(2301134,'Artificial Intelligence',62.29),(2301134,'Data Structures',99.47),(2301134,'Operating Systems',75.15),(2301135,'Artificial Intelligence',63.45),(2301135,'Data Structures',69.70),(2301135,'Operating Systems',68.54),(2301136,'Artificial Intelligence',61.64),(2301136,'Data Structures',69.40),(2301136,'Operating Systems',63.36),(2301137,'Artificial Intelligence',61.93),(2301137,'Data Structures',63.90),(2301137,'Operating Systems',73.61),(2301138,'Artificial Intelligence',60.23),(2301138,'Data Structures',67.47),(2301138,'Operating Systems',81.39),(2301139,'Artificial Intelligence',81.72),(2301139,'Data Structures',68.04),(2301139,'Operating Systems',66.68),(2301140,'Artificial Intelligence',83.98),(2301140,'Data Structures',65.35),(2301140,'Operating Systems',94.12),(2301141,'Artificial Intelligence',64.72),(2301141,'Data Structures',72.61),(2301141,'Operating Systems',85.12),(2301142,'Artificial Intelligence',69.03),(2301142,'Data Structures',63.14),(2301142,'Operating Systems',66.00),(2301143,'Artificial Intelligence',74.05),(2301143,'Data Structures',80.11),(2301143,'Operating Systems',66.96),(2301144,'Artificial Intelligence',97.45),(2301144,'Data Structures',97.82),(2301144,'Operating Systems',60.61),(2301145,'Artificial Intelligence',68.74),(2301145,'Data Structures',63.50),(2301145,'Operating Systems',69.47),(2301146,'Artificial Intelligence',86.08),(2301146,'Data Structures',78.53),(2301146,'Operating Systems',91.74),(2301147,'Artificial Intelligence',83.78),(2301147,'Data Structures',61.43),(2301147,'Operating Systems',63.30),(2301148,'Artificial Intelligence',72.53),(2301148,'Data Structures',98.13),(2301148,'Operating Systems',86.20),(2301149,'Artificial Intelligence',60.78),(2301149,'Data Structures',95.38),(2301149,'Operating Systems',74.56),(2301150,'Artificial Intelligence',91.76),(2301150,'Data Structures',85.64),(2301150,'Operating Systems',68.62),(2301151,'Artificial Intelligence',91.16),(2301151,'Data Structures',95.29),(2301151,'Operating Systems',92.18),(2301152,'Artificial Intelligence',93.48),(2301152,'Data Structures',71.95),(2301152,'Operating Systems',68.50),(2301153,'Artificial Intelligence',64.09),(2301153,'Data Structures',85.64),(2301153,'Operating Systems',90.46),(2301154,'Artificial Intelligence',88.07),(2301154,'Data Structures',62.07),(2301154,'Operating Systems',66.11),(2301155,'Artificial Intelligence',86.88),(2301155,'Data Structures',64.95),(2301155,'Operating Systems',70.77),(2301156,'Artificial Intelligence',62.45),(2301156,'Data Structures',70.10),(2301156,'Operating Systems',72.98),(2301157,'Artificial Intelligence',73.38),(2301157,'Data Structures',83.77),(2301157,'Operating Systems',74.83),(2301158,'Artificial Intelligence',93.74),(2301158,'Data Structures',97.96),(2301158,'Operating Systems',98.96),(2301159,'Artificial Intelligence',93.85),(2301159,'Data Structures',96.67),(2301159,'Operating Systems',91.82),(2301160,'Artificial Intelligence',95.46),(2301160,'Data Structures',84.65),(2301160,'Operating Systems',73.11),(2301161,'Artificial Intelligence',80.20),(2301161,'Data Structures',65.46),(2301161,'Operating Systems',87.24),(2301162,'Artificial Intelligence',63.65),(2301162,'Data Structures',64.49),(2301162,'Operating Systems',73.31),(2301163,'Artificial Intelligence',64.04),(2301163,'Data Structures',99.15),(2301163,'Operating Systems',63.07),(2301164,'Artificial Intelligence',78.47),(2301164,'Data Structures',92.49),(2301164,'Operating Systems',84.22),(2301165,'Artificial Intelligence',93.59),(2301165,'Data Structures',61.59),(2301165,'Operating Systems',70.66),(2301166,'Artificial Intelligence',98.16),(2301166,'Data Structures',78.25),(2301166,'Operating Systems',96.24),(2301167,'Artificial Intelligence',77.91),(2301167,'Data Structures',96.26),(2301167,'Operating Systems',70.82),(2301168,'Artificial Intelligence',73.48),(2301168,'Data Structures',98.75),(2301168,'Operating Systems',99.24),(2301169,'Artificial Intelligence',96.94),(2301169,'Data Structures',68.07),(2301169,'Operating Systems',98.81),(2301170,'Artificial Intelligence',88.15),(2301170,'Data Structures',77.54),(2301170,'Operating Systems',94.62),(2301171,'Artificial Intelligence',87.27),(2301171,'Data Structures',67.07),(2301171,'Operating Systems',84.92),(2301172,'Artificial Intelligence',62.84),(2301172,'Data Structures',91.52),(2301172,'Operating Systems',70.33),(2301173,'Artificial Intelligence',95.28),(2301173,'Data Structures',61.48),(2301173,'Operating Systems',70.12),(2301174,'Artificial Intelligence',86.19),(2301174,'Data Structures',65.24),(2301174,'Operating Systems',78.38),(2301175,'Artificial Intelligence',62.98),(2301175,'Data Structures',72.06),(2301175,'Operating Systems',83.85),(2301176,'Artificial Intelligence',65.11),(2301176,'Data Structures',68.37),(2301176,'Operating Systems',62.46),(2301177,'Artificial Intelligence',86.13),(2301177,'Data Structures',96.22),(2301177,'Operating Systems',80.89),(2301178,'Artificial Intelligence',74.10),(2301178,'Data Structures',96.54),(2301178,'Operating Systems',66.35),(2301179,'Artificial Intelligence',71.57),(2301179,'Data Structures',69.24),(2301179,'Operating Systems',62.01),(2301180,'Artificial Intelligence',81.66),(2301180,'Data Structures',68.59),(2301180,'Operating Systems',86.27),(2301181,'Artificial Intelligence',72.55),(2301181,'Data Structures',98.62),(2301181,'Operating Systems',87.93),(2301182,'Artificial Intelligence',77.31),(2301182,'Data Structures',69.78),(2301182,'Operating Systems',90.64),(2301183,'Artificial Intelligence',87.51),(2301183,'Data Structures',96.69),(2301183,'Operating Systems',96.76),(2301184,'Artificial Intelligence',61.70),(2301184,'Data Structures',85.67),(2301184,'Operating Systems',61.78),(2301185,'Artificial Intelligence',82.37),(2301185,'Data Structures',62.91),(2301185,'Operating Systems',88.82),(2301186,'Artificial Intelligence',86.18),(2301186,'Data Structures',98.83),(2301186,'Operating Systems',72.06),(2301187,'Artificial Intelligence',65.95),(2301187,'Data Structures',86.44),(2301187,'Operating Systems',68.86),(2301188,'Artificial Intelligence',80.40),(2301188,'Data Structures',60.30),(2301188,'Operating Systems',82.57),(2301189,'Artificial Intelligence',77.38),(2301189,'Data Structures',92.87),(2301189,'Operating Systems',92.97),(2301190,'Artificial Intelligence',98.78),(2301190,'Data Structures',71.23),(2301190,'Operating Systems',60.93),(2301191,'Artificial Intelligence',90.20),(2301191,'Data Structures',64.27),(2301191,'Operating Systems',71.14),(2301192,'Artificial Intelligence',99.62),(2301192,'Data Structures',80.14),(2301192,'Operating Systems',93.60),(2301193,'Artificial Intelligence',89.27),(2301193,'Data Structures',88.71),(2301193,'Operating Systems',64.21),(2301194,'Artificial Intelligence',89.29),(2301194,'Data Structures',80.02),(2301194,'Operating Systems',64.19),(2301195,'Artificial Intelligence',97.43),(2301195,'Data Structures',94.63),(2301195,'Operating Systems',83.56),(2301196,'Artificial Intelligence',78.53),(2301196,'Data Structures',89.60),(2301196,'Operating Systems',93.66),(2301197,'Artificial Intelligence',90.32),(2301197,'Data Structures',98.44),(2301197,'Operating Systems',98.81),(2301198,'Artificial Intelligence',60.82),(2301198,'Data Structures',74.39),(2301198,'Operating Systems',85.17),(2301199,'Artificial Intelligence',77.72),(2301199,'Data Structures',77.96),(2301199,'Operating Systems',77.53),(2301200,'Artificial Intelligence',96.86),(2301200,'Data Structures',95.57),(2301200,'Operating Systems',73.92),(2301201,'Artificial Intelligence',68.02),(2301201,'Data Structures',92.78),(2301201,'Operating Systems',91.53),(2301202,'Artificial Intelligence',92.88),(2301202,'Data Structures',67.23),(2301202,'Operating Systems',98.99),(2301203,'Artificial Intelligence',84.92),(2301203,'Data Structures',68.75),(2301203,'Operating Systems',74.88),(2301204,'Artificial Intelligence',87.01),(2301204,'Data Structures',91.25),(2301204,'Operating Systems',70.72),(2301205,'Artificial Intelligence',83.48),(2301205,'Data Structures',94.04),(2301205,'Operating Systems',66.69),(2301206,'Artificial Intelligence',93.37),(2301206,'Data Structures',92.46),(2301206,'Operating Systems',70.03),(2301207,'Artificial Intelligence',95.42),(2301207,'Data Structures',67.51),(2301207,'Operating Systems',94.90),(2301208,'Artificial Intelligence',87.71),(2301208,'Data Structures',99.37),(2301208,'Operating Systems',72.39),(2301209,'Artificial Intelligence',68.38),(2301209,'Data Structures',93.01),(2301209,'Operating Systems',79.39),(2301210,'Artificial Intelligence',77.68),(2301210,'Data Structures',64.95),(2301210,'Operating Systems',97.59),(2301211,'Artificial Intelligence',77.12),(2301211,'Data Structures',60.12),(2301211,'Operating Systems',84.62),(2301212,'Artificial Intelligence',75.80),(2301212,'Data Structures',62.06),(2301212,'Operating Systems',62.66),(2301213,'Artificial Intelligence',84.68),(2301213,'Data Structures',87.46),(2301213,'Operating Systems',62.92),(2301214,'Artificial Intelligence',72.04),(2301214,'Data Structures',85.91),(2301214,'Operating Systems',66.16),(2301215,'Artificial Intelligence',92.79),(2301215,'Data Structures',72.36),(2301215,'Operating Systems',67.84),(2301216,'Artificial Intelligence',88.68),(2301216,'Data Structures',92.25),(2301216,'Operating Systems',81.83),(2301217,'Artificial Intelligence',74.83),(2301217,'Data Structures',83.31),(2301217,'Operating Systems',63.60),(2301218,'Artificial Intelligence',87.16),(2301218,'Data Structures',64.31),(2301218,'Operating Systems',69.42),(2301219,'Artificial Intelligence',72.67),(2301219,'Data Structures',80.32),(2301219,'Operating Systems',68.32),(2301220,'Artificial Intelligence',89.05),(2301220,'Data Structures',79.45),(2301220,'Operating Systems',70.93),(2301221,'Artificial Intelligence',62.17),(2301221,'Data Structures',97.27),(2301221,'Operating Systems',84.53),(2301222,'Artificial Intelligence',94.49),(2301222,'Data Structures',76.38),(2301222,'Operating Systems',63.90),(2301223,'Artificial Intelligence',69.30),(2301223,'Data Structures',65.84),(2301223,'Operating Systems',76.64),(2301224,'Artificial Intelligence',72.14),(2301224,'Data Structures',69.02),(2301224,'Operating Systems',67.07),(2301225,'Artificial Intelligence',67.48),(2301225,'Data Structures',82.73),(2301225,'Operating Systems',98.34),(2301226,'Artificial Intelligence',82.47),(2301226,'Data Structures',75.35),(2301226,'Operating Systems',62.26),(2301227,'Artificial Intelligence',99.27),(2301227,'Data Structures',81.19),(2301227,'Operating Systems',92.52),(2301228,'Artificial Intelligence',80.55),(2301228,'Data Structures',85.43),(2301228,'Operating Systems',65.99),(2301229,'Artificial Intelligence',99.94),(2301229,'Data Structures',93.85),(2301229,'Operating Systems',68.75),(2301230,'Artificial Intelligence',89.36),(2301230,'Data Structures',69.19),(2301230,'Operating Systems',89.70),(2301231,'Artificial Intelligence',65.09),(2301231,'Data Structures',69.03),(2301231,'Operating Systems',93.49),(2301232,'Artificial Intelligence',88.25),(2301232,'Data Structures',76.43),(2301232,'Operating Systems',92.69),(2301233,'Artificial Intelligence',67.48),(2301233,'Data Structures',87.37),(2301233,'Operating Systems',91.37),(2301234,'Artificial Intelligence',65.85),(2301234,'Data Structures',89.62),(2301234,'Operating Systems',79.51),(2301235,'Artificial Intelligence',97.71),(2301235,'Data Structures',81.60),(2301235,'Operating Systems',74.69),(2301236,'Artificial Intelligence',72.62),(2301236,'Data Structures',75.66),(2301236,'Operating Systems',78.07),(2301237,'Artificial Intelligence',79.46),(2301237,'Data Structures',73.82),(2301237,'Operating Systems',62.28),(2301238,'Artificial Intelligence',74.77),(2301238,'Data Structures',90.00),(2301238,'Operating Systems',87.33),(2301239,'Artificial Intelligence',83.36),(2301239,'Data Structures',75.45),(2301239,'Operating Systems',80.91),(2301240,'Artificial Intelligence',78.37),(2301240,'Data Structures',80.94),(2301240,'Operating Systems',98.19),(2301241,'Artificial Intelligence',73.09),(2301241,'Data Structures',90.01),(2301241,'Operating Systems',85.89),(2301242,'Artificial Intelligence',84.26),(2301242,'Data Structures',69.64),(2301242,'Operating Systems',80.59),(2301243,'Artificial Intelligence',80.52),(2301243,'Data Structures',73.33),(2301243,'Operating Systems',73.95),(2301244,'Artificial Intelligence',70.47),(2301244,'Data Structures',72.64),(2301244,'Operating Systems',86.99),(2301245,'Artificial Intelligence',81.70),(2301245,'Data Structures',82.88),(2301245,'Operating Systems',88.02),(2301246,'Artificial Intelligence',84.22),(2301246,'Data Structures',68.94),(2301246,'Operating Systems',87.47),(2301247,'Artificial Intelligence',65.43),(2301247,'Data Structures',71.81),(2301247,'Operating Systems',75.16),(2301248,'Artificial Intelligence',69.24),(2301248,'Data Structures',60.30),(2301248,'Operating Systems',79.15),(2301249,'Artificial Intelligence',94.32),(2301249,'Data Structures',68.70),(2301249,'Operating Systems',62.01),(2301250,'Artificial Intelligence',65.30),(2301250,'Data Structures',90.53),(2301250,'Operating Systems',88.21);
/*!40000 ALTER TABLE `attendance_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_schedule`
--

DROP TABLE IF EXISTS `class_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_schedule` (
  `semester` int NOT NULL,
  `day` varchar(15) NOT NULL,
  `offering_id` int NOT NULL,
  `subject_code` varchar(20) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`semester`,`day`,`offering_id`),
  KEY `offering_id` (`offering_id`),
  CONSTRAINT `class_schedule_ibfk_1` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_schedule`
--

LOCK TABLES `class_schedule` WRITE;
/*!40000 ALTER TABLE `class_schedule` DISABLE KEYS */;
INSERT INTO `class_schedule` VALUES (4,'Friday',184,'EC251','09:00:00','10:00:00'),(4,'Friday',185,'EC252','10:00:00','11:00:00'),(4,'Friday',186,'HS203','11:00:00','12:00:00'),(4,'Friday',187,'HS203','12:00:00','13:00:00'),(4,'Monday',173,'CS231','09:00:00','10:00:00'),(4,'Monday',174,'CS231','10:00:00','11:00:00'),(4,'Monday',175,'CS232','11:00:00','13:00:00'),(4,'Monday',176,'CS232','13:00:00','15:00:00'),(4,'Monday',188,'HS301','09:00:00','10:00:00'),(4,'Monday',189,'HS301','10:00:00','11:00:00'),(4,'Monday',190,'SC202','11:00:00','12:00:00'),(4,'Monday',191,'SC202','12:00:00','13:00:00'),(4,'Thursday',181,'CS241','09:00:00','11:00:00'),(4,'Thursday',182,'EC243','11:00:00','12:00:00'),(4,'Thursday',183,'EC244','12:00:00','13:00:00'),(4,'Tuesday',177,'CS235','09:00:00','10:00:00'),(4,'Tuesday',178,'CS235','10:00:00','11:00:00'),(4,'Tuesday',192,'MA204','09:00:00','10:00:00'),(4,'Tuesday',193,'MA204','10:00:00','11:00:00'),(4,'Wednesday',179,'CS236','11:00:00','13:00:00'),(4,'Wednesday',180,'CS240','13:00:00','14:00:00'),(4,'Wednesday',194,'MA205','11:00:00','12:00:00'),(4,'Wednesday',195,'MA205','12:00:00','13:00:00');
/*!40000 ALTER TABLE `class_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `room_id` varchar(50) NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('C1','lecture',92),('C112','lecture',56),('C56','lecture',54),('CSE Lab 1','lab',39),('CSE Lab 2','lab',39),('CSE Lab 5','lab',26),('ECE Lab 2','lab',35),('LG2','lecture',64);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_offerings`
--

DROP TABLE IF EXISTS `course_offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_offerings` (
  `offering_id` int NOT NULL,
  `subject_code` varchar(20) DEFAULT NULL,
  `stream` varchar(10) DEFAULT NULL,
  `instructor_id` int DEFAULT NULL,
  `room_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`offering_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `course_offerings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `classroom` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offerings`
--

LOCK TABLES `course_offerings` WRITE;
/*!40000 ALTER TABLE `course_offerings` DISABLE KEYS */;
INSERT INTO `course_offerings` VALUES (173,'CS231','CSE',101,'C56'),(174,'CS231','CSE',102,'C112'),(175,'CS232','CSE',101,'CSE Lab 1'),(176,'CS232','CSE',102,'CSE Lab 2'),(177,'CS235','CSE',104,'C112'),(178,'CS235','CSE',104,'C56'),(179,'CS236','CSE',104,'CSE Lab 1'),(180,'CS240','CSE',103,'C56'),(181,'CS241','CSE',103,'CSE Lab 5'),(182,'EC243','ECE',113,'C1'),(183,'EC244','ECE',113,'ECE Lab 2'),(184,'EC251','ECE',111,'C1'),(185,'EC252','ECE',112,'ECE Lab 2'),(186,'HS203','CSE',109,'C56'),(187,'HS203','ECE',109,'LG2'),(188,'HS301','CSE',115,'C1'),(189,'HS301','ECE',115,'C1'),(190,'SC202','CSE',108,'C1'),(191,'SC202','ECE',108,'C56'),(192,'MA204','CSE',106,'C1'),(193,'MA204','ECE',107,'C1'),(194,'MA205','CSE',116,'C112'),(195,'MA205','ECE',116,'C112');
/*!40000 ALTER TABLE `course_offerings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extra_class_schedule`
--

DROP TABLE IF EXISTS `extra_class_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extra_class_schedule` (
  `extra_class_id` int NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(10) DEFAULT NULL,
  `instructor_id` int DEFAULT NULL,
  `room_id` varchar(20) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `semester` int DEFAULT NULL,
  `status` enum('pending','confirmed') DEFAULT 'pending',
  PRIMARY KEY (`extra_class_id`),
  KEY `room_id` (`room_id`),
  KEY `subject_code` (`subject_code`),
  CONSTRAINT `extra_class_schedule_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `classroom` (`room_id`),
  CONSTRAINT `extra_class_schedule_ibfk_2` FOREIGN KEY (`subject_code`) REFERENCES `subject_details` (`subject_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extra_class_schedule`
--

LOCK TABLES `extra_class_schedule` WRITE;
/*!40000 ALTER TABLE `extra_class_schedule` DISABLE KEYS */;
INSERT INTO `extra_class_schedule` VALUES (1,'CS235',105,'C1','12:00:00','13:00:00','Wednesday',4,'confirmed'),(3,'CS235',105,'C112','14:00:00','16:00:00','Thursday',4,'confirmed');
/*!40000 ALTER TABLE `extra_class_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_slots`
--

DROP TABLE IF EXISTS `faculty_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_slots` (
  `instructor_id` int NOT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday') NOT NULL,
  `time` varchar(20) NOT NULL,
  PRIMARY KEY (`instructor_id`,`day`,`time`),
  CONSTRAINT `faculty_slots_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor_details` (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_slots`
--

LOCK TABLES `faculty_slots` WRITE;
/*!40000 ALTER TABLE `faculty_slots` DISABLE KEYS */;
INSERT INTO `faculty_slots` VALUES (101,'Monday','2:00-4:00 PM'),(101,'Thursday','3:00-4:00 PM'),(102,'Monday','2:00-4:00 PM'),(102,'Thursday','3:00-4:00 PM'),(103,'Monday','3:00-4:00 PM'),(103,'Thursday','1:00-2:00 PM'),(104,'Tuesday','2:00-4:00 PM'),(104,'Wednesday','3:00-4:00 PM'),(105,'Tuesday','2:00-4:00 PM'),(105,'Wednesday','3:00-4:00 PM'),(106,'Monday','1:00-3:00 PM'),(106,'Wednesday','2:00-4:00 PM'),(107,'Tuesday','10:00-12:00 PM'),(107,'Friday','3:00-5:00 PM'),(108,'Wednesday','2:00-3:00 PM'),(108,'Thursday','9:00-11:00 AM'),(109,'Monday','3:00-5:00 PM'),(109,'Thursday','1:00-2:00 PM'),(110,'Tuesday','11:00-1:00 PM'),(110,'Friday','2:00-4:00 PM');
/*!40000 ALTER TABLE `faculty_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_details`
--

DROP TABLE IF EXISTS `instructor_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_details` (
  `instructor_id` int NOT NULL,
  `instructor_name` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_details`
--

LOCK TABLES `instructor_details` WRITE;
/*!40000 ALTER TABLE `instructor_details` DISABLE KEYS */;
INSERT INTO `instructor_details` VALUES (101,'Krishnandu Hazra','Operating Systems','Computer Science and Engineering'),(102,'Nilkanta Sahu','Operating Systems','Computer Science and Engineering'),(103,'Sanjay Moulik','Database Management Systems','Computer Science and Engineering'),(104,'Moumita Roy','Artificial Intelligence','Computer Science and Engineering'),(105,'Kaustuv Nag','Artificial Intelligence','Computer Science and Engineering'),(106,'Pawan Kumar Mishra','Algorithms','Computer Science and Engineering'),(107,'Harun Mohd','Discrete Maths','Science and Mathematics'),(108,'Shanta Bhar','Chemistry','Science and Mathematics'),(109,'Rajarshi Mitra','Science Fiction','Humanities'),(110,'David Lal','Introduction to Politics','Humanities'),(111,'Kukil Khaniker','Principles of Communication','Electronics and Communication Engineering'),(112,'Komal Janghel','Principles of Communication','Electronics and Communication Engineering'),(113,'Bijit Kumar Das','Digital Signal Processing','Electronics and Communication Engineering'),(114,'Sudip Biswas','Digital Signal Processing','Electronics and Communication Engineering'),(115,'Kaveri Dev','Economics','Humanities'),(116,'Ummey Habiba','Optimization Techniques','Science and Mathematics');
/*!40000 ALTER TABLE `instructor_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_details`
--

DROP TABLE IF EXISTS `student_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_details` (
  `roll_no` int NOT NULL,
  `student_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roll_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_details`
--

LOCK TABLES `student_details` WRITE;
/*!40000 ALTER TABLE `student_details` DISABLE KEYS */;
INSERT INTO `student_details` VALUES (2301001,'AADITYA SRIVASTAVA'),(2301002,'AAKANKSHA MEHTA'),(2301003,'AAROHEE SHARMA'),(2301004,'AARYAN'),(2301005,'ABBURI VENKATA RAMA GOWTHAM'),(2301006,'ABHAS SEN'),(2301007,'ABHAY KUMAR YADAV'),(2301008,'ABHIJIT SARUKAD'),(2301009,'ABHINAV PRATAP'),(2301010,'ABHIRAJ TOMAR'),(2301011,'ABHISHEK YADAV'),(2301012,'ABHRADIP SIRCAR'),(2301013,'ADARSH KUMAR'),(2301014,'ADITYA BAJOLIYA'),(2301015,'ADITYA BHATT'),(2301016,'ADITYA GUPTA'),(2301017,'ADITYA KASHYAP'),(2301018,'ADITYA KUMAR'),(2301019,'ADWAITH M D'),(2301020,'AGNIDIPTO BANIK'),(2301021,'AKASH KUMAR'),(2301022,'ALAJANGI BHAVYA'),(2301023,'ALAKESH BORO'),(2301024,'ANAMIKA KUMARI'),(2301025,'ANANT SANGAL'),(2301026,'ANANYA ANURAG LENKA'),(2301027,'ANIKET'),(2301028,'ANIMESH KHARE'),(2301029,'ANIRUDDHA KARLE'),(2301030,'ANIRUDH LAXMIKANT GADE'),(2301031,'ANKIT KUMAR'),(2301032,'ANKIT KUMAR ARUN'),(2301033,'ANKIT SARKAR'),(2301034,'ANKITA BISWAS'),(2301035,'ANMOL KUSHWAHA'),(2301036,'ANUBHAV ANAND'),(2301037,'ANUPAM KUMAR PAUL'),(2301038,'ANUPAM TRIPATHI'),(2301039,'ANURAG SAHOO'),(2301040,'ANVESH SHRIVASTAVA'),(2301041,'APURVA KUMAR SINGH'),(2301042,'ARAV JADON'),(2301043,'ARIJIT SEN'),(2301044,'ARNABJYOTI BUJAR BARUAH'),(2301045,'ARNAV SAIKIA'),(2301046,'ARUP BRAHMA'),(2301047,'ARYADEEP'),(2301048,'ARYAN AGARWAL'),(2301049,'ARYAN GUPTA'),(2301050,'ARYAN JAITELY'),(2301051,'ARYAN PANDEY'),(2301052,'ARYAN SONKER'),(2301053,'ARZOO KUSHWAHA'),(2301054,'ASHISH SONKAR'),(2301055,'ASHOK BIDIYASAR'),(2301056,'ATHARV AGARWAL'),(2301057,'AWANI MAHESH VAIDYA'),(2301058,'AYUSH DUTT MISHRA'),(2301059,'AYUSH KUMAR PATEL'),(2301060,'AYUSHI KUMARI'),(2301061,'BAHETI DEVKUMAR GOPAL'),(2301062,'BANAVATH BALACHANDRA NAIK'),(2301063,'BARMAVATH GANESH'),(2301064,'BHAUMIK KHANDELA'),(2301065,'BHAVISH SAI VISHWAS MELEKOTE'),(2301066,'BOPPANI ROHAN'),(2301067,'BUKKYA RAJESH NAIK'),(2301068,'CHIRANJIT SAHA'),(2301069,'DAIWIK SINGH'),(2301070,'DAKSH BAIRAGI'),(2301071,'DEBRUP DAS'),(2301072,'DEEPAK'),(2301073,'DEEPANSHU SINGH'),(2301074,'DHRUV HOODA'),(2301075,'DIBASISH BORAH'),(2301076,'DIPANSHU RAJ'),(2301077,'DIPTI SHAW'),(2301078,'DISHA KHAKHA'),(2301079,'DIVY SANTOSH SAKHALA'),(2301080,'EADARA LASYA SAI RAGHAVI'),(2301081,'GAJENDRA GANGWAR'),(2301082,'GAUTAM GIRI'),(2301083,'GAUTAM RAJ'),(2301084,'GORLE PAUL DINAKARAN'),(2301085,'GUTHIKONDA SREE PRANEETH'),(2301086,'HARISH UIKEY'),(2301087,'HARSH MISHRA'),(2301088,'HARSH RAJ'),(2301089,'HARSHAL SANAS'),(2301090,'HARSHIT JAIN'),(2301091,'HARSHIT SHARMA'),(2301092,'HARSHITA GUPTA'),(2301093,'HEMANT KAPIL'),(2301094,'HEMANT KUMAR'),(2301095,'HIMANSHU KUMAR'),(2301096,'HITEN KUMAR'),(2301097,'HRISHI SHEKHAR'),(2301098,'IPSHITA RANJAN'),(2301099,'ISHAN TIWARI'),(2301100,'ISHWARI RAJENDRA UMAK'),(2301101,'JUNAID ISLAM'),(2301102,'K.SHREEJA'),(2301103,'KADALI VENKATA KRISHNA TANOOJ'),(2301104,'KARAN GUPTA'),(2301105,'KARRI MOHITH BHANU'),(2301106,'KARTIK AGRAWAL'),(2301107,'KARTIK RAJORA'),(2301108,'KARTIKEYA OJHA'),(2301109,'KATA UMESH REDDY'),(2301110,'KATROVATH RAMU NAIK'),(2301111,'KAVITA YADAV'),(2301112,'KHUSHBOO PATHARI'),(2301113,'KHUSHI ROKDE'),(2301114,'KOLA HARSHITH'),(2301115,'KOLAPURI ABHISHEK'),(2301116,'KOLU KONDA MANOJ'),(2301117,'KUMAR UTKARSH'),(2301118,'KUNAL PUROHIT'),(2301119,'KUNDAN KUMAR'),(2301120,'LALIT KUMAR'),(2301121,'LIKKI SAMARTH REDDY'),(2301122,'MAHIPAL'),(2301123,'MALLENA VARDHAN'),(2301124,'MANGAT RAM CHOPRA'),(2301125,'MARAKATTU PURUSHOTTAM'),(2301126,'MATTA SRI CHANDRA SEKHAR'),(2301127,'MD FAIZAN KHAN'),(2301128,'MD ZIYAD HUSSAIN'),(2301129,'MEDAMONI SUJAY MANAS'),(2301130,'MOHIT KUMAWAT'),(2301131,'MRIDUL RAHANGDALE'),(2301132,'MUSINI VENKATTEJESHWAR'),(2301133,'MYADA SRIKAR'),(2301134,'NAGARAJ B'),(2301135,'NAVNEET'),(2301136,'NIKHIL'),(2301137,'NIKHIL'),(2301138,'NISHANT PRABHAT'),(2301139,'NITIKA BANSIWAL'),(2301140,'NITIN MISHRA'),(2301141,'OMKAR GUSAIN'),(2301142,'PALAVALASA SAI KIRAN'),(2301143,'PARMAR DHRUVKUMAR DILIPKUMAR'),(2301144,'PIYUSH DILIPRAO BALE'),(2301145,'PIYUSH KUMAR'),(2301146,'POGURU SREEKANTH'),(2301147,'POORVI AGARWAL'),(2301148,'PRAFUL PRAKASH GOEL'),(2301149,'PRAKSHAY SAINI'),(2301150,'PRANAY SIWACH'),(2301151,'PRANITA MAHAJAN'),(2301152,'PRANJAL KUMAR'),(2301153,'PRASOON JOSHI'),(2301154,'PRATAPADITYA CHANDER'),(2301155,'PRATEEK ANAND'),(2301156,'PRATEEK SINGH'),(2301157,'PRERNA SHANTARAM SANGALE'),(2301158,'PRINCE GOYAL'),(2301159,'PRITHVI RAJ'),(2301160,'PRIYA DEORI'),(2301161,'PRIYANKA PRAJAPATI'),(2301162,'PRIYANSHU DAN'),(2301163,'PRIYANSHU KUMAR'),(2301164,'PRIYANSHU SUKIRTI'),(2301165,'PULKIT'),(2301166,'PURNIMA GARG'),(2301167,'RADHIKA'),(2301168,'RAHUL YADAV'),(2301169,'RAJ DHAWANIYA'),(2301170,'RAJ KUSHWAHA'),(2301171,'RATHOD LOKESH'),(2301172,'RATHOD VIVEK'),(2301173,'RATNA JAISWAL'),(2301174,'REA SINHA'),(2301175,'RISHABH KUMAR JAIN'),(2301176,'RISHABH SINGH TOMAR'),(2301177,'RISHAV KUMAR JHA'),(2301178,'RITIK YADAV'),(2301179,'ROCKEY KUMAR'),(2301180,'SACHIN MOHANTY'),(2301181,'SACHIN PATEL'),(2301182,'SAHARSH JAIN'),(2301183,'SAHIL'),(2301184,'SAKET TRIPATHI'),(2301185,'SAMADRITA MONDAL'),(2301186,'SAMRIDHI TIWARI'),(2301187,'SANCHIT DANGWAL'),(2301188,'SASANKA NARZARY'),(2301189,'SAUMYA KUMAR'),(2301190,'SAYANI ADHIKARY'),(2301191,'SEERAM KARTHIKEYA'),(2301192,'SHALENDER PRATAP SINGH'),(2301193,'SHAMBHAVI MISHRA'),(2301194,'SHANKARANAND'),(2301195,'SHASHANK KUMAR'),(2301196,'SHASHANK LODHI'),(2301197,'SHASHANK SHARMA'),(2301198,'SHESHAGIRI SAMPATH GIRISH VARDHAN'),(2301199,'SHIKHAR SHASHANK'),(2301200,'SHIVAM PANWAR'),(2301201,'SHIVAM RAJ'),(2301202,'SHIVAM RAJ'),(2301203,'SHIVANG SHARMA'),(2301204,'SHIVANKIT JAISWAL'),(2301205,'SHIVANSH GUPTA'),(2301206,'SHOURAYA MISHRA'),(2301207,'SHOURYA ASWAL'),(2301208,'SHREYA SARNAGAR'),(2301209,'SHREYA SINGH'),(2301210,'SHUBH TIWARI'),(2301211,'SHUBHAM KANOJIYA'),(2301212,'SHUBHAM KUMAR'),(2301213,'SHUBHASHISH SHUKLA'),(2301214,'SIDDHANT THETE'),(2301215,'SMIT'),(2301216,'SOHEL AKHTAR'),(2301217,'SOUMIL KHANNA'),(2301218,'SREYAN MUKHERJEE'),(2301219,'SUBHASH SESMA'),(2301220,'SUMIT KUMAR'),(2301221,'SUSMITA SAIN'),(2301222,'SWASTIKA KHAN'),(2301223,'TADIKONDA LOHITH ADITYA'),(2301224,'TALABATTULA ADARSH'),(2301225,'TANISH KASHYAP'),(2301226,'TANMAY CHATURVEDI'),(2301227,'TANUSHKA SHARMA'),(2301228,'TANVEE NITYANAND BHANGALE'),(2301229,'THAMAS PRAKASH GAYKAWAD'),(2301230,'THANGELLA MANAS'),(2301231,'TIPPIREDDY DEVENDAR REDDY'),(2301232,'TIRUMALASETTY SAI JASMITHA'),(2301233,'TUHIN ROY'),(2301234,'TUSHAR'),(2301235,'UDDHAV SINGH TOMAR'),(2301236,'UJJWAL KAUSHAL'),(2301237,'VADLAMURU PRANAVI'),(2301238,'VAIBHAV'),(2301239,'VAISHNAVI RAI'),(2301240,'VALLURI JAYA VENKATA SREE VARDHAN'),(2301241,'VANSH RAJPUT'),(2301242,'VANSHIKA GUPTA'),(2301243,'VEMALI DEEPIKA'),(2301244,'VINIT VINAY'),(2301245,'VINIT VINAYAK PANDEY'),(2301246,'VIPIN'),(2301247,'VISHWAS SINGH'),(2301248,'VIVEK KUMAR PATEL'),(2301249,'YASH SHARMA'),(2301250,'YASH SINGHAL');
/*!40000 ALTER TABLE `student_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_details`
--

DROP TABLE IF EXISTS `subject_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_details` (
  `subject_code` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `lecture_hours` int DEFAULT NULL,
  `tutorial_hours` int DEFAULT NULL,
  `practical_hours` int DEFAULT NULL,
  `credits` int DEFAULT NULL,
  PRIMARY KEY (`subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_details`
--

LOCK TABLES `subject_details` WRITE;
/*!40000 ALTER TABLE `subject_details` DISABLE KEYS */;
INSERT INTO `subject_details` VALUES ('CS231','Operating Systems',3,0,0,6),('CS232','Operating Systems Lab',0,0,3,3),('CS235','Artificial Intelligence',3,0,0,6),('CS236','Artificial Intelligence Lab',0,0,3,3),('CS240','Database Management Systems',3,0,0,6),('CS241','DBMS Lab',0,0,3,3),('EC243','Digital Signal Processing',3,0,0,6),('EC244','Digital Signal Processing Lab',0,0,3,3),('EC251','Principles of Communication',3,0,0,6),('EC252','Principles of Communication Lab',0,0,3,3),('HS203','Science Fiction I',3,0,0,6),('HS301','Economics',3,0,0,6),('MA204','Mathematics IV',3,0,0,6),('MA205','Optimization Techniques',3,0,0,6),('SC202','Chemistry',3,0,0,6);
/*!40000 ALTER TABLE `subject_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-27 22:19:20
