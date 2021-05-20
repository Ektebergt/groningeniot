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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumpen data van tabel fcgroningeniot.accounts: ~2 rows (ongeveer)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `username`, `password`, `email`, `dateofbirth`, `length`, `weight`, `classid`) VALUES
	(9, 'test', 'pbkdf2:sha256:150000$hyHD7ADB$0e230df8c4351b055363fa3cba0208749f0375b182a17dfd42ab0dbd71d4ba5c', 'test@test.nl', '2000-04-18', 200, 80, 1),
	(10, 'test123', 'test123', 'test@test.nl', '2000-06-29', 200, 80, 1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Structuur van  tabel fcgroningeniot.groups wordt geschreven
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) DEFAULT NULL,
  `naam` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel fcgroningeniot.groups: ~0 rows (ongeveer)
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;

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

-- Structuur van  tabel fcgroningeniot.users wordt geschreven
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel fcgroningeniot.users: ~3 rows (ongeveer)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
	(2, 'Admin', 'admin@admin.nl', 'pbkdf2:sha256:150000$IAg4vhYA$29f1d80b0faf29160e8c8c2d1db45869b10654e90c65ca4f281571efca87b192', 1),
	(3, 'admin2', 'admin2@admin.nl', 'pbkdf2:sha256:150000$ipacVV0k$21b206ed15a3e53346f638810befc944dbd0013b9bbf7558677df62e3557791f', 1),
	(4, 'admin3', 'admin3@admin.nl', 'pbkdf2:sha256:150000$OUayDuAg$44795d0f888040bc3f72910afe9237d3e53854f824c44819921be80b35bf6288', 3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
