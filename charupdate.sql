-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.17-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for gta
CREATE DATABASE IF NOT EXISTS `gta` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gta`;

-- Dumping structure for table gta.__characters
CREATE TABLE IF NOT EXISTS `__characters` (
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `dob` varchar(100) NOT NULL,
  `food` varchar(50) NOT NULL DEFAULT '100',
  `water` varchar(50) NOT NULL DEFAULT '100',
  `stress` varchar(50) NOT NULL DEFAULT '0',
  `armor` varchar(50) NOT NULL DEFAULT '0',
  `health` varchar(50) NOT NULL DEFAULT '0',
  `gender` tinyint(4) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `cash` int(11) NOT NULL DEFAULT 500,
  `bank` int(11) NOT NULL DEFAULT 5000,
  `story` varchar(255) NOT NULL,
  `job` varchar(50) NOT NULL DEFAULT 'None',
  `rank` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `stocks` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;