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
-- Table structure for table `t_asset_brands`
--

DROP TABLE IF EXISTS `t_asset_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_asset_brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `init` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_asset_categories`
--

DROP TABLE IF EXISTS `t_asset_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_asset_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `init` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_asset_models`
--

DROP TABLE IF EXISTS `t_asset_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_asset_models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `has_serial` int DEFAULT NULL,
  `unit` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `last_updated_at` datetime DEFAULT NULL,
  `last_updated_by` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `is_consumable` int DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `last_updated_by` (`last_updated_by`),
  KEY `type_id` (`type_id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `t_asset_models_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_asset_models_ibfk_2` FOREIGN KEY (`last_updated_by`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_asset_models_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `t_asset_types` (`id`),
  CONSTRAINT `t_asset_models_ibfk_4` FOREIGN KEY (`category_id`) REFERENCES `t_asset_categories` (`id`),
  CONSTRAINT `t_asset_models_ibfk_5` FOREIGN KEY (`brand_id`) REFERENCES `t_asset_brands` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_asset_types`
--

DROP TABLE IF EXISTS `t_asset_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_asset_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `init` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_assets`
--

DROP TABLE IF EXISTS `t_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `registred_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `registred_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `asset_model_id` int DEFAULT NULL,
  `color_id` int DEFAULT NULL,
  `purchase_order_number` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `location_id` int DEFAULT NULL,
  `status` enum('READY','USE','REPAIR','DISPOSAL') DEFAULT NULL,
  `conditions` enum('NEW','GOOD','OLD','BAD','NEED TO CHECK') DEFAULT NULL,
  `asset_id_old` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `color_id` (`color_id`),
  KEY `registred_by` (`registred_by`),
  KEY `updated_by` (`updated_by`),
  KEY `asset_model_id` (`asset_model_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `t_assets_ibfk_3` FOREIGN KEY (`registred_by`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_assets_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_assets_ibfk_5` FOREIGN KEY (`asset_model_id`) REFERENCES `t_asset_models` (`id`),
  CONSTRAINT `t_assets_ibfk_6` FOREIGN KEY (`location_id`) REFERENCES `t_locations` (`id`),
  CONSTRAINT `t_assets_ibfk_7` FOREIGN KEY (`color_id`) REFERENCES `t_colors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_colors`
--

DROP TABLE IF EXISTS `t_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `hex` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_locations`
--

DROP TABLE IF EXISTS `t_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `location_type` enum('OFFICE','STORE','WAREHOUSE','DIVISION','RACK','BOX','TABLE') DEFAULT NULL,
  `box_type` enum('CARDBOX','TOTEBOX') DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `init` varchar(100) DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `t_locations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `t_locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `t_purchase_order_details`
--

DROP TABLE IF EXISTS `t_purchase_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_purchase_order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int DEFAULT NULL,
  `asset_model_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `asset_model_id` (`asset_model_id`),
  CONSTRAINT `t_purchase_order_details_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `t_purchase_orders` (`id`),
  CONSTRAINT `t_purchase_order_details_ibfk_2` FOREIGN KEY (`asset_model_id`) REFERENCES `t_asset_models` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_purchase_orders`
--

DROP TABLE IF EXISTS `t_purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_purchase_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `po_number` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('DRAFT','PENDING','APPROVED','COMPLETED') DEFAULT 'PENDING',
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `t_purchase_orders_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `t_users` (`id`),
  CONSTRAINT `t_purchase_orders_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `t_suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_receives`
--

DROP TABLE IF EXISTS `t_receives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_receives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `purchase_order_id` int DEFAULT NULL,
  `received_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `received_by` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `location_detail_id` int DEFAULT NULL,
  `location_team_id` int DEFAULT NULL,
  `status` enum('DRAFT','PENDING','IN_PROGRESS','COMPLETED') DEFAULT 'DRAFT',
  PRIMARY KEY (`id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `received_by` (`received_by`),
  KEY `location_id` (`location_id`),
  KEY `location_detail_id` (`location_detail_id`),
  KEY `location_team_id` (`location_team_id`),
  CONSTRAINT `t_receives_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `t_purchase_orders` (`id`),
  CONSTRAINT `t_receives_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `t_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_suppliers`
--

DROP TABLE IF EXISTS `t_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2025-10-14  7:29:22
