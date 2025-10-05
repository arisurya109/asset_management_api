-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: asset_management_api_test
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `t_asset_types`
--

DROP TABLE IF EXISTS `t_asset_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_asset_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int DEFAULT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `t_asset_types_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `t_brands` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_asset_types`
--

LOCK TABLES `t_asset_types` WRITE;
/*!40000 ALTER TABLE `t_asset_types` DISABLE KEYS */;
INSERT INTO `t_asset_types` VALUES (1,1,'MF3010 Update');
/*!40000 ALTER TABLE `t_asset_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_assets`
--

DROP TABLE IF EXISTS `t_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(50) DEFAULT NULL,
  `asset_name` varchar(100) DEFAULT NULL,
  `asset_init` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_assets`
--

LOCK TABLES `t_assets` WRITE;
/*!40000 ALTER TABLE `t_assets` DISABLE KEYS */;
INSERT INTO `t_assets` VALUES (1,'D0001','DESKTOP STAND','DS'),(2,'D0002','PRINTER','PRN'),(3,'D0003','MONITOR UPDATE','MN');
/*!40000 ALTER TABLE `t_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_brands`
--

DROP TABLE IF EXISTS `t_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT NULL,
  `brand_code` varchar(50) DEFAULT NULL,
  `brand_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `t_brands_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `t_assets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_brands`
--

LOCK TABLES `t_brands` WRITE;
/*!40000 ALTER TABLE `t_brands` DISABLE KEYS */;
INSERT INTO `t_brands` VALUES (1,2,'CN','Canon Update'),(2,3,'DL','Dell');
/*!40000 ALTER TABLE `t_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_module_permission`
--

DROP TABLE IF EXISTS `t_module_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_module_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module_id` int DEFAULT NULL,
  `permission_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `t_module_permission_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `t_modules` (`id`),
  CONSTRAINT `t_module_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `t_permissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_module_permission`
--

LOCK TABLES `t_module_permission` WRITE;
/*!40000 ALTER TABLE `t_module_permission` DISABLE KEYS */;
INSERT INTO `t_module_permission` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4);
/*!40000 ALTER TABLE `t_module_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_modules`
--

DROP TABLE IF EXISTS `t_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module_name` varchar(100) DEFAULT NULL,
  `module_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_name` (`module_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_modules`
--

LOCK TABLES `t_modules` WRITE;
/*!40000 ALTER TABLE `t_modules` DISABLE KEYS */;
INSERT INTO `t_modules` VALUES (1,'user','User Management');
/*!40000 ALTER TABLE `t_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_permissions`
--

DROP TABLE IF EXISTS `t_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) DEFAULT NULL,
  `permission_label` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_name` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_permissions`
--

LOCK TABLES `t_permissions` WRITE;
/*!40000 ALTER TABLE `t_permissions` DISABLE KEYS */;
INSERT INTO `t_permissions` VALUES (1,'view','View'),(2,'add','Add'),(3,'update','Update'),(4,'delete','Delete');
/*!40000 ALTER TABLE `t_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_permission_module`
--

DROP TABLE IF EXISTS `t_user_permission_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user_permission_module` (
  `user_id` int NOT NULL,
  `module_permission_id` int NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `module_permission_id` (`module_permission_id`),
  CONSTRAINT `t_user_permission_module_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_user_permission_module_ibfk_2` FOREIGN KEY (`module_permission_id`) REFERENCES `t_module_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_permission_module`
--

LOCK TABLES `t_user_permission_module` WRITE;
/*!40000 ALTER TABLE `t_user_permission_module` DISABLE KEYS */;
INSERT INTO `t_user_permission_module` VALUES (1,1),(1,2),(1,3),(1,4),(11,1),(11,4),(12,1),(12,4);
/*!40000 ALTER TABLE `t_user_permission_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_users`
--

DROP TABLE IF EXISTS `t_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_active` int NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_users`
--

LOCK TABLES `t_users` WRITE;
/*!40000 ALTER TABLE `t_users` DISABLE KEYS */;
INSERT INTO `t_users` VALUES (1,'TESTING','TESTING1','9eae9f3c86aaa919bf84bab1abfce3c1e13c72f9184cad4f6107b9d5a1597385',1,'2025-10-04 01:59:27','ADMIN'),(4,'TESTING2','TESTING2','64d75d49184c277952cc26398f661d9c50a5f059b4c5bc2a993323b22718f158',0,'2025-10-04 02:29:25','ADMIN'),(6,'Testing3','Testing3','ce367d990000238a0f5c84a1e321c7afa4f2b189618bfb95bb8d67b00141a5ad',1,'2025-10-04 20:32:58','TESTING'),(7,'Testing4','Testing4','806e0f0f0ca2f793811b4b9860e6267e940e1b2f841a1739cfb8d8228c6e84a1',0,'2025-10-04 20:34:18','TESTING'),(8,'Testing5','Testing5','b07274720300138d9405bda5f83c981f3ae25ac31324034c846ab339647d4ff0',1,'2025-10-04 20:35:31','TESTING'),(9,'Testing6','Testing6','f09fde143d2f36445deeb14ce478b14e3a28a8502f47c3e3b038c2227548fbb3',1,'2025-10-05 07:10:23','TESTING'),(11,'Testing7','Testing7','9eae9f3c86aaa919bf84bab1abfce3c1e13c72f9184cad4f6107b9d5a1597385',1,'2025-10-06 04:47:51',NULL),(12,'Testing8','Testing8','9eae9f3c86aaa919bf84bab1abfce3c1e13c72f9184cad4f6107b9d5a1597385',1,'2025-10-06 04:50:54','TESTING');
/*!40000 ALTER TABLE `t_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'asset_management_api_test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-06  4:53:39
