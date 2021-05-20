-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server versie:                10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versie:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Databasestructuur van fcgroningeniot wordt geschreven
CREATE DATABASE IF NOT EXISTS `fcgroningeniot` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fcgroningeniot`;

-- Structuur van  tabel fcgroningeniot.accounts wordt geschreven
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dateofbirth` date DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `classid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumpen data van tabel fcgroningeniot.accounts: ~1 rows (ongeveer)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `username`, `password`, `email`, `dateofbirth`, `length`, `weight`, `classid`) VALUES
	(6, 'test123', 'test123', 'test123@test.nl', '2000-04-18', 187, 80, 5);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Structuur van  tabel fcgroningeniot.personal wordt geschreven
CREATE TABLE IF NOT EXISTS `personal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gast_id` int(11) DEFAULT NULL,
  `voornaam` varchar(50) DEFAULT NULL,
  `achternaam` varchar(50) DEFAULT NULL,
  `onderwijs` varchar(50) DEFAULT NULL,
  `klas` text DEFAULT NULL,
  `gewicht` int(11) DEFAULT NULL,
  `leeftijd` int(11) DEFAULT NULL,
  `lengte` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel fcgroningeniot.personal: ~0 rows (ongeveer)
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
