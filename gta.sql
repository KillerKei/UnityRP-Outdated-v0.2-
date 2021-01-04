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

-- Dumping structure for table gta.character_current
CREATE TABLE IF NOT EXISTS `character_current` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `model` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `drawables` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `props` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `drawtextures` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proptextures` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gta.character_current: ~0 rows (approximately)
DELETE FROM `character_current`;
/*!40000 ALTER TABLE `character_current` DISABLE KEYS */;
INSERT INTO `character_current` (`cid`, `model`, `drawables`, `props`, `drawtextures`, `proptextures`) VALUES
	(48, '1885233650', '{"1":["masks",0],"2":["hair",2],"3":["torsos",0],"4":["legs",0],"5":["bags",0],"6":["shoes",1],"7":["neck",0],"8":["undershirts",0],"9":["vest",0],"10":["decals",0],"11":["jackets",0],"0":["face",0]}', '{"1":["glasses",-1],"2":["earrings",-1],"3":["mouth",-1],"4":["lhand",-1],"5":["rhand",-1],"6":["watches",-1],"7":["braclets",-1],"0":["hats",-1]}', '[["face",0],["masks",0],["hair",0],["torsos",0],["legs",0],["bags",0],["shoes",2],["neck",0],["undershirts",1],["vest",0],["decals",0],["jackets",1]]', '[["hats",-1],["glasses",-1],["earrings",-1],["mouth",-1],["lhand",-1],["rhand",-1],["watches",-1],["braclets",-1]]');
/*!40000 ALTER TABLE `character_current` ENABLE KEYS */;

-- Dumping structure for table gta.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `hairColor` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headBlend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headOverlay` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headStructure` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gta.character_face: ~0 rows (approximately)
DELETE FROM `character_face`;
/*!40000 ALTER TABLE `character_face` DISABLE KEYS */;
INSERT INTO `character_face` (`cid`, `hairColor`, `headBlend`, `headOverlay`, `headStructure`) VALUES
	(48, '[1,1]', '{"skinSecond":0,"hasParent":false,"skinMix":1.0,"shapeSecond":0,"shapeThird":0,"thirdMix":0.0,"skinThird":0,"skinFirst":15,"shapeFirst":0,"shapeMix":0.0}', '[{"colourType":0,"name":"Blemishes","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":1,"name":"FacialHair","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":0.0},{"colourType":1,"name":"Eyebrows","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"Ageing","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":2,"name":"Makeup","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":2,"name":"Blush","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"Complexion","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"SunDamage","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":2,"name":"Lipstick","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"MolesFreckles","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":1,"name":"ChestHair","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"BodyBlemishes","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0},{"colourType":0,"name":"AddBodyBlemishes","firstColour":0,"secondColour":0,"overlayValue":255,"overlayOpacity":1.0}]', '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]');
/*!40000 ALTER TABLE `character_face` ENABLE KEYS */;

-- Dumping structure for table gta.character_outfits
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `cid` int(11) NOT NULL,
  `slot` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `drawables` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `props` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `drawtextures` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proptextures` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hairColor` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gta.character_outfits: ~0 rows (approximately)
DELETE FROM `character_outfits`;
/*!40000 ALTER TABLE `character_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_outfits` ENABLE KEYS */;

-- Dumping structure for table gta.mech_materials
CREATE TABLE IF NOT EXISTS `mech_materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Rubber` int(11) DEFAULT NULL,
  `Aluminum` int(11) DEFAULT NULL,
  `Scrap` int(11) DEFAULT NULL,
  `Plastic` int(11) DEFAULT NULL,
  `Copper` int(11) DEFAULT NULL,
  `Steel` int(11) DEFAULT NULL,
  `Glass` int(11) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table gta.mech_materials: ~0 rows (approximately)
DELETE FROM `mech_materials`;
/*!40000 ALTER TABLE `mech_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `mech_materials` ENABLE KEYS */;

-- Dumping structure for table gta.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table gta.phone_contacts: ~0 rows (approximately)
DELETE FROM `phone_contacts`;
/*!40000 ALTER TABLE `phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_contacts` ENABLE KEYS */;

-- Dumping structure for table gta.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7516 DEFAULT CHARSET=utf8;

-- Dumping data for table gta.phone_messages: 0 rows
DELETE FROM `phone_messages`;
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table gta.phone_yp
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `advert` varchar(500) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table gta.phone_yp: ~0 rows (approximately)
DELETE FROM `phone_yp`;
/*!40000 ALTER TABLE `phone_yp` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_yp` ENABLE KEYS */;

-- Dumping structure for table gta.playerstattoos
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `identifier` int(11) DEFAULT NULL,
  `tattoos` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.playerstattoos: ~0 rows (approximately)
DELETE FROM `playerstattoos`;
/*!40000 ALTER TABLE `playerstattoos` DISABLE KEYS */;
INSERT INTO `playerstattoos` (`identifier`, `tattoos`) VALUES
	(48, '[]');
/*!40000 ALTER TABLE `playerstattoos` ENABLE KEYS */;

-- Dumping structure for table gta.tweets
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table gta.tweets: ~0 rows (approximately)
DELETE FROM `tweets`;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

-- Dumping structure for table gta.user_inventory2
CREATE TABLE IF NOT EXISTS `user_inventory2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `quality` int(11) DEFAULT 100,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1449 DEFAULT CHARSET=latin1;

-- Dumping data for table gta.user_inventory2: ~266 rows (approximately)
DELETE FROM `user_inventory2`;
/*!40000 ALTER TABLE `user_inventory2` DISABLE KEYS */;
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(723, 'mobilephone', 'ply-48', '{}', 10, 0, 100, 1609283154584);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(724, 'idcard', 'ply-48', '{"Name":"Keiron","Surname":"Bates","Sex":"Male","DOB":"1999-04-26","Identifier":48}', 7, 0, 100, 1609283154582);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(727, '2578778090', 'ply-48', '{}', 17, 0, 100, 1609301073011);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(728, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609301271016);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(729, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609301271016);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(730, 'advlockpick', 'ply-48', '{}', 4, 0, 100, 1609305217235);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(742, '1gcocaine', 'ply-48', '{}', 9, 0, 100, 1609355129888);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(743, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609356001639);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(745, 'plastic', 'ply-48', '{}', 11, 0, 100, 1609356055596);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(746, 'plastic', 'ply-48', '{}', 11, 0, 100, 1609356055596);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(747, 'plastic', 'ply-48', '{}', 11, 0, 100, 1609356055596);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(748, 'plastic', 'ply-48', '{}', 11, 0, 100, 1609356055596);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(749, 'highgradefemaleseed', 'ply-48', '{}', 12, 0, 100, 1609356158894);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(751, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609356883397);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(752, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609356883397);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(753, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609356883397);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(754, 'rubber', 'ply-48', '{}', 5, 0, 100, 1609356883397);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(755, '453432689', 'ply-48', '{}', 1, 0, 100, 1609356917799);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(762, 'lockpick', 'ply-48', '{}', 2, 0, 100, 1609357669935);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(763, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609357788623);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(769, 'viagra', 'ply-48', '{}', 15, 0, 100, 1609364964682);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(770, '453432689', 'ply-48', '{}', 16, 0, 100, 1609365660806);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(776, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375475302);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(777, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375475302);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(778, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375475302);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(779, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375475302);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(780, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375534810);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(781, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609375534810);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1082, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376036070);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1083, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376036070);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1084, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376036070);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1085, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376036070);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1086, 'Gruppe6Card', 'Trunk-26SGL871', '{}', 1, 0, 100, 1609376161734);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1087, 'locksystem', 'ply-48', '{}', 18, 0, 100, 1609376161735);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1088, 'locksystem', 'ply-48', '{}', 18, 0, 100, 1609376161735);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1089, 'locksystem', 'ply-48', '{}', 18, 0, 100, 1609376161735);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1090, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376242572);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1091, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376242572);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1092, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376242572);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1093, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376242572);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1094, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376375920);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1095, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376375920);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1096, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376375920);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1097, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609376375920);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1100, 'repairkit', 'ply-48', '{}', 8, 0, 100, 1609470064978);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1101, 'repairkit', 'ply-48', '{}', 8, 0, 100, 1609470065232);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1102, 'advlockpick', 'ply-48', '{}', 4, 0, 100, 1609470382433);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1103, 'advlockpick', 'ply-48', '{}', 4, 0, 100, 1609470382587);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1119, 'water', 'ply-48', '{}', 22, 0, 100, 1609478639618);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1120, 'water', 'ply-48', '{}', 22, 0, 100, 1609478639618);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1128, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1129, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1130, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1131, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1132, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1133, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1134, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1135, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1136, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1137, 'band', 'ply-48', '{}', 21, 0, 100, 1609478808119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1141, 'binoculars', 'ply-48', '{}', 3, 0, 100, 1609479946959);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1143, 'bandage', 'ply-48', '{}', 23, 0, 100, 1609550205110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1144, 'bandage', 'ply-48', '{}', 23, 0, 100, 1609550205110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1145, 'bandage', 'ply-48', '{}', 23, 0, 100, 1609550205110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1146, 'bandage', 'ply-48', '{}', 23, 0, 100, 1609550205110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1168, 'band', 'ply-48', '{}', 21, 0, 100, 1609610535306);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1169, 'band', 'ply-48', '{}', 21, 0, 100, 1609610535306);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1170, 'band', 'ply-48', '{}', 21, 0, 100, 1609610535306);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1234, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610575325);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1235, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610575325);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1236, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610575325);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1237, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1238, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1239, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1240, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1241, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1242, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1243, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1244, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1245, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1246, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1247, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1248, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1249, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1250, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610579668);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1251, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1252, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1253, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1254, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1255, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1256, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1257, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610585166);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1258, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610590754);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1259, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610590754);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1260, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610590754);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1261, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610590754);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1262, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610590754);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1263, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1264, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1265, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1266, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1267, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1268, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1269, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1270, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1271, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1272, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1273, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1274, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1275, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1276, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1277, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610594812);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1278, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1279, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1280, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1281, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1282, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1283, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1284, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1285, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1286, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1287, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1288, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610599117);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1289, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610604568);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1290, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610604568);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1291, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1292, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1293, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1294, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1295, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1296, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1297, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1298, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1299, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1300, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1301, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1302, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1303, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1304, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1305, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610608689);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1306, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610612960);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1307, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610612960);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1308, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610612960);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1309, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610612960);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1310, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1311, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1312, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1313, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1314, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1315, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1316, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1317, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1318, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1319, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610618128);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1320, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1321, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1322, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1323, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1324, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1325, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1326, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1327, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1328, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1329, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1330, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1331, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1332, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1333, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610623445);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1334, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1335, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1336, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1337, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1338, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1339, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1340, 'band', 'ply-48', '{}', 21, 0, 100, 1609610628217);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1341, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1342, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1343, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1344, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1345, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1346, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1347, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1348, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610628218);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1349, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1350, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1351, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1352, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1353, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1354, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1355, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1356, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610633202);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1357, 'band', 'ply-48', '{}', 21, 0, 100, 1609610638096);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1358, 'band', 'ply-48', '{}', 21, 0, 100, 1609610638096);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1359, 'band', 'ply-48', '{}', 21, 0, 100, 1609610638096);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1360, 'band', 'ply-48', '{}', 21, 0, 100, 1609610638096);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1361, 'band', 'ply-48', '{}', 21, 0, 100, 1609610638096);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1362, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1363, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1364, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1365, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1366, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1367, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1368, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1369, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1370, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1371, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1372, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1373, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1374, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1375, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610638098);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1376, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610642313);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1377, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610642313);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1378, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610642313);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1379, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1380, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1381, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1382, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1383, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1384, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1385, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1386, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1387, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1388, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1389, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1390, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1391, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610648084);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1392, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610653110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1393, 'rollcash', 'ply-48', '{}', 20, 0, 100, 1609610653110);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1394, 'oxy', 'ply-48', '{}', 14, 0, 100, 1609612581580);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1395, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623505521);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1396, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623520681);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1397, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623525034);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1398, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623544878);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1399, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623565397);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1400, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623569697);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1401, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623590058);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1402, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623599758);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1403, 'alive_chicken', 'ply-48', '{}', 13, 0, 100, 1609623604207);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1420, 'radio', 'ply-48', '{}', 6, 0, 100, 1609762006953);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1422, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762117958);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1423, 'beer', 'ply-48', '{}', 27, 0, 100, 1609762276046);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1424, 'bandage', 'ply-48', '{}', 28, 0, 100, 1609762281995);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1425, 'beer', 'ply-48', '{}', 26, 0, 100, 1609762349124);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1426, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762358985);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1427, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762364493);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1428, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762368338);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1429, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762370151);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1430, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762370505);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1431, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762373486);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1432, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762378441);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1433, 'donut', 'ply-48', '{}', 19, 0, 100, 1609762379552);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1434, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762399265);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1435, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762399265);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1436, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762399265);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1437, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762399265);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1438, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762399265);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1439, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762404119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1440, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762404119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1441, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762404119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1442, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762404119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1443, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762404119);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1444, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762405439);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1445, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762405439);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1446, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762405439);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1447, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762405439);
INSERT INTO `user_inventory2` (`id`, `item_id`, `name`, `information`, `slot`, `dropped`, `quality`, `creationDate`) VALUES
	(1448, 'sandwich', 'ply-48', '{}', 24, 0, 100, 1609762405439);
/*!40000 ALTER TABLE `user_inventory2` ENABLE KEYS */;

-- Dumping structure for table gta.__ammo
CREATE TABLE IF NOT EXISTS `__ammo` (
  `id` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `newammo` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `ammoType` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `ammoTable` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__ammo: ~0 rows (approximately)
DELETE FROM `__ammo`;
/*!40000 ALTER TABLE `__ammo` DISABLE KEYS */;
INSERT INTO `__ammo` (`id`, `newammo`, `ammoType`, `ammoTable`) VALUES
	('48', '0', NULL, '{"1950175060":{"type":1950175060,"ammo":0}}');
/*!40000 ALTER TABLE `__ammo` ENABLE KEYS */;

-- Dumping structure for table gta.__business
CREATE TABLE IF NOT EXISTS `__business` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `bank` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__business: ~0 rows (approximately)
DELETE FROM `__business`;
/*!40000 ALTER TABLE `__business` DISABLE KEYS */;
/*!40000 ALTER TABLE `__business` ENABLE KEYS */;

-- Dumping structure for table gta.__characters
CREATE TABLE IF NOT EXISTS `__characters` (
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `dob` varchar(100) NOT NULL,
  `food` varchar(50) NOT NULL DEFAULT '100',
  `water` varchar(50) NOT NULL DEFAULT '100',
  `armor` varchar(50) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table gta.__characters: ~0 rows (approximately)
DELETE FROM `__characters`;
/*!40000 ALTER TABLE `__characters` DISABLE KEYS */;
INSERT INTO `__characters` (`first_name`, `last_name`, `dob`, `food`, `water`, `armor`, `gender`, `phone_number`, `cash`, `bank`, `story`, `job`, `rank`, `id`, `uid`, `stocks`) VALUES
	('Keiron', 'Bates', '1999-04-26', '79', '19', '0', 0, '4993961729', 96176, 354819, 'Character\'s background, this can be short and simple', 'Police', 1, 48, 20, NULL);
/*!40000 ALTER TABLE `__characters` ENABLE KEYS */;

-- Dumping structure for table gta.__emotes
CREATE TABLE IF NOT EXISTS `__emotes` (
  `cid` int(11) NOT NULL,
  `emote_data` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__emotes: ~0 rows (approximately)
DELETE FROM `__emotes`;
/*!40000 ALTER TABLE `__emotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `__emotes` ENABLE KEYS */;

-- Dumping structure for table gta.__employees
CREATE TABLE IF NOT EXISTS `__employees` (
  `cid` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `giver` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `rank` int(11) NOT NULL,
  `business_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__employees: ~34 rows (approximately)
DELETE FROM `__employees`;
/*!40000 ALTER TABLE `__employees` DISABLE KEYS */;
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 2, 9);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 2, 8);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 9);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 2, 7);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 7);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 6);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 13);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 8);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 5, 3);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 8);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 5);
INSERT INTO `__employees` (`cid`, `name`, `giver`, `rank`, `business_id`) VALUES
	(48, 'Keiron Bates', 'Government', 1, 3);
/*!40000 ALTER TABLE `__employees` ENABLE KEYS */;

-- Dumping structure for table gta.__housedata
CREATE TABLE IF NOT EXISTS `__housedata` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `upfront` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `storage` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `clothing` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `mortgaged` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `furniture` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__housedata: ~0 rows (approximately)
DELETE FROM `__housedata`;
/*!40000 ALTER TABLE `__housedata` DISABLE KEYS */;
INSERT INTO `__housedata` (`cid`, `house_id`, `house_model`, `upfront`, `housename`, `storage`, `clothing`, `garages`, `mortgaged`, `furniture`) VALUES
	(48, 92, 1, 1, ' Grove Street 20', '{"z":0.5709291100502014,"h":270.6363525390625,"x":-26.892892837524415,"y":-1843.41357421875}', '{"z":0.570929765701294,"h":88.82264709472656,"x":-32.07463836669922,"y":-1846.9281005859376}', '[{"z":25.743927001953126,"h":229.13453674316407,"x":-27.090627670288087,"y":-1849.31298828125}]', '0', NULL);
/*!40000 ALTER TABLE `__housedata` ENABLE KEYS */;

-- Dumping structure for table gta.__housekeys
CREATE TABLE IF NOT EXISTS `__housekeys` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `upfront` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `storage` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `clothing` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `mortgaged` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table gta.__housekeys: ~0 rows (approximately)
DELETE FROM `__housekeys`;
/*!40000 ALTER TABLE `__housekeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housekeys` ENABLE KEYS */;

-- Dumping structure for table gta.__housing
CREATE TABLE IF NOT EXISTS `__housing` (
  `cid` int(11) DEFAULT NULL,
  `roomType` int(11) DEFAULT NULL,
  `roomNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__housing: ~0 rows (approximately)
DELETE FROM `__housing`;
/*!40000 ALTER TABLE `__housing` DISABLE KEYS */;
/*!40000 ALTER TABLE `__housing` ENABLE KEYS */;

-- Dumping structure for table gta.__job_accounts
CREATE TABLE IF NOT EXISTS `__job_accounts` (
  `id` int(11) NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 15000,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__job_accounts: ~13 rows (approximately)
DELETE FROM `__job_accounts`;
/*!40000 ALTER TABLE `__job_accounts` DISABLE KEYS */;
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(1, 500, 'Barber');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(2, 500, 'Taxi');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(3, 500, 'Police');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(4, 500, 'Prostitute');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(5, 500, 'EMS');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(6, 500, 'PDM');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(7, 500, 'RealEstate');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(8, 500, 'Mechanic');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(9, 500, 'DriftSchool');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(10, 500, 'News');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(11, 500, 'tuner_carshop');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(12, 500, 'illegal_carshop');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(13, 500, 'OffPolice');
INSERT INTO `__job_accounts` (`id`, `bank`, `name`) VALUES
	(14, 500, 'OffEMS');
/*!40000 ALTER TABLE `__job_accounts` ENABLE KEYS */;

-- Dumping structure for table gta.__users
CREATE TABLE IF NOT EXISTS `__users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'user',
  `whitelist` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `steam` (`steam`),
  UNIQUE KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table gta.__users: ~2 rows (approximately)
DELETE FROM `__users`;
/*!40000 ALTER TABLE `__users` DISABLE KEYS */;
INSERT INTO `__users` (`uid`, `steam`, `license`, `rank`, `whitelist`) VALUES
	(20, 'steam:11000010df5cc6d', 'license:98a0f2af7c8c6278e0a27ef9fbe2d85251c6a399', 'superadmin', 0);
INSERT INTO `__users` (`uid`, `steam`, `license`, `rank`, `whitelist`) VALUES
	(21, 'steam:110000132034861', 'license:2230560fd18a49c1fcc216ec5c54c094b7091d3c', 'user', 0);
INSERT INTO `__users` (`uid`, `steam`, `license`, `rank`, `whitelist`) VALUES
	(22, 'steam:110000136b52d18', 'license:3462e584fa90afabc958921aef1d95e133b2bc89', 'user', 0);
INSERT INTO `__users` (`uid`, `steam`, `license`, `rank`, `whitelist`) VALUES
	(23, 'steam:11000011b6d7320', 'license:48fbf544e76ced35153ff9ea2694051fc305fddb', 'user', 0);
/*!40000 ALTER TABLE `__users` ENABLE KEYS */;

-- Dumping structure for table gta.__vehicles
CREATE TABLE IF NOT EXISTS `__vehicles` (
  `cid` int(11) NOT NULL,
  `plate` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `model` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `engine_damage` int(11) DEFAULT 1000,
  `body_damage` int(11) DEFAULT 1000,
  `degredation` varchar(100) COLLATE utf8mb4_bin DEFAULT '100,100,100,100,100,100,100,100',
  `fuel` int(11) DEFAULT 100,
  `price` int(11) DEFAULT NULL,
  `personalvehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `financed` int(11) DEFAULT NULL,
  `amount_due` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `garage` varchar(50) COLLATE utf8mb4_bin DEFAULT 'A',
  `harness` int(11) DEFAULT NULL,
  `durability` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table gta.__vehicles: ~0 rows (approximately)
DELETE FROM `__vehicles`;
/*!40000 ALTER TABLE `__vehicles` DISABLE KEYS */;
INSERT INTO `__vehicles` (`cid`, `plate`, `name`, `model`, `vehicle`, `engine_damage`, `body_damage`, `degredation`, `fuel`, `price`, `personalvehicle`, `financed`, `amount_due`, `last_payment`, `garage`, `harness`, `durability`) VALUES
	(48, '06XZH747', 'Bati 801RR', 'bati2', '{"modFrame":-1,"modEngine":-1,"modSpeakers":-1,"modoldLivery":1,"modVanityPlate":-1,"modTrunk":-1,"modXenonColour":255,"fuelLevel":65.0,"color1":147,"modRearBumper":-1,"modDashboardColour":0,"modTrimB":-1,"modSeats":-1,"modXenon":false,"modInteriorColour":0,"modLivery":-1,"modArmor":-1,"windowTint":-1,"tyreSmokeColor":[255,255,255],"dirtLevel":0.0,"modDoorSpeaker":-1,"modAirFilter":-1,"pearlescentColor":4,"modArchCover":-1,"modHood":-1,"modTrimA":-1,"modAerials":-1,"modSpoilers":-1,"modWindows":-1,"modDashboard":-1,"modTurbo":false,"modBackWheels":-1,"modRoof":-1,"modStruts":-1,"plate":"06XZH747","modExhaust":-1,"wheels":6,"modSuspension":-1,"modBrakes":-1,"extras":[],"modAPlate":-1,"modPlateHolder":-1,"color2":147,"modOrnaments":-1,"modRightFender":-1,"plateIndex":0,"modFender":-1,"modShifterLeavers":-1,"bodyHealth":1000.0,"modSideSkirt":-1,"modTank":-1,"engineHealth":1000.0,"wheelColor":4,"neonEnabled":[false,false,false,false],"modDial":-1,"modTransmission":-1,"modFrontBumper":-1,"modFrontWheels":-1,"neonColor":[255,0,255],"modHydrolic":-1,"modEngineBlock":-1,"model":-891462355,"modSteeringWheel":-1,"modSmokeEnabled":1,"modHorns":-1,"modGrille":-1}', 1000, 1000, '100,100,100,100,100,100,100,100', 100, 17250, '38402', 1, 0, 0, 'P', NULL, NULL);
/*!40000 ALTER TABLE `__vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
