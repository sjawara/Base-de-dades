-- phpMyAdmin SQL Dump
-- version 5.1.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql-sjawara.alwaysdata.net
-- Generation Time: Jan 19, 2023 at 02:27 AM
-- Server version: 10.6.7-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sjawara_gestio_practicas`
--

-- --------------------------------------------------------

--
-- Table structure for table `alumne`
--

CREATE TABLE `alumne` (
  `ralc` char(10) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `cognom` varchar(30) DEFAULT NULL,
  `data_naixement` date NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefon` char(9) DEFAULT NULL,
  `cicle_formatiu` int(11) DEFAULT NULL,
  `curs` enum('1','2') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `empresa`
--

CREATE TABLE `empresa` (
  `cif` char(9) NOT NULL,
  `nom` varchar(25) DEFAULT NULL,
  `address` varchar(25) DEFAULT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `grau`
--

CREATE TABLE `grau` (
  `id` int(11) NOT NULL,
  `nom` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `homologacio`
--

CREATE TABLE `homologacio` (
  `empresa` char(9) NOT NULL,
  `grau` int(11) NOT NULL,
  `fct` tinyint(1) NOT NULL,
  `tipus_dual` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `practica`
--

CREATE TABLE `practica` (
  `id` int(11) NOT NULL,
  `alumne` char(10) DEFAULT NULL,
  `empresa` char(9) DEFAULT NULL,
  `tipus` enum('FCT','DUAL') DEFAULT NULL,
  `data_inici` date NOT NULL,
  `data_fi` date DEFAULT NULL,
  `hores` int(11) DEFAULT NULL,
  `exempcio` tinyint(1) DEFAULT NULL,
  `tipus_exempcio` int(11) DEFAULT NULL,
  `qualificacio` decimal(2,2) DEFAULT NULL,
  `tutor_empresa` char(9) DEFAULT NULL,
  `tutor_centre` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Triggers `practica`
--
DELIMITER $$
CREATE TRIGGER `data_practica_bi` BEFORE INSERT ON `practica` FOR EACH ROW IF NEW.data_inici < NOW() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es poden inserir pràctiques amb data de inici anteriors a la data actual.'; END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `data_practica_bu` BEFORE UPDATE ON `practica` FOR EACH ROW IF NEW.data_fi<NEW.data_inici THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es poden actualitzar pràctiques amb data de finalització anteriors a la data de inici.';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tipus_exempcio`
--

CREATE TABLE `tipus_exempcio` (
  `id` int(11) NOT NULL,
  `tipus` enum('25%','50%','100%') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `tutor_centre`
--

CREATE TABLE `tutor_centre` (
  `dni` char(9) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `telefon` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `tutor_empresa`
--

CREATE TABLE `tutor_empresa` (
  `dni` char(9) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `empresa` char(9) DEFAULT NULL,
  `telefon` char(9) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alumne`
--
ALTER TABLE `alumne`
  ADD PRIMARY KEY (`ralc`),
  ADD KEY `cicle_formatiu` (`cicle_formatiu`);

--
-- Indexes for table `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`cif`);

--
-- Indexes for table `grau`
--
ALTER TABLE `grau`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `homologacio`
--
ALTER TABLE `homologacio`
  ADD PRIMARY KEY (`empresa`,`grau`),
  ADD KEY `grau` (`grau`);

--
-- Indexes for table `practica`
--
ALTER TABLE `practica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alumne` (`alumne`),
  ADD KEY `empresa` (`empresa`),
  ADD KEY `tipus_exempcio` (`tipus_exempcio`),
  ADD KEY `tutor_empresa` (`tutor_empresa`),
  ADD KEY `tutor_centre` (`tutor_centre`);

--
-- Indexes for table `tipus_exempcio`
--
ALTER TABLE `tipus_exempcio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tutor_centre`
--
ALTER TABLE `tutor_centre`
  ADD PRIMARY KEY (`dni`);

--
-- Indexes for table `tutor_empresa`
--
ALTER TABLE `tutor_empresa`
  ADD PRIMARY KEY (`dni`),
  ADD KEY `empresa` (`empresa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `practica`
--
ALTER TABLE `practica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipus_exempcio`
--
ALTER TABLE `tipus_exempcio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alumne`
--
ALTER TABLE `alumne`
  ADD CONSTRAINT `alumne_ibfk_1` FOREIGN KEY (`cicle_formatiu`) REFERENCES `grau` (`id`);

--
-- Constraints for table `homologacio`
--
ALTER TABLE `homologacio`
  ADD CONSTRAINT `homologacio_ibfk_1` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`cif`),
  ADD CONSTRAINT `homologacio_ibfk_2` FOREIGN KEY (`grau`) REFERENCES `grau` (`id`);

--
-- Constraints for table `practica`
--
ALTER TABLE `practica`
  ADD CONSTRAINT `practica_ibfk_1` FOREIGN KEY (`alumne`) REFERENCES `alumne` (`ralc`),
  ADD CONSTRAINT `practica_ibfk_2` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`cif`),
  ADD CONSTRAINT `practica_ibfk_3` FOREIGN KEY (`tipus_exempcio`) REFERENCES `tipus_exempcio` (`id`),
  ADD CONSTRAINT `practica_ibfk_4` FOREIGN KEY (`tutor_empresa`) REFERENCES `tutor_empresa` (`dni`),
  ADD CONSTRAINT `practica_ibfk_5` FOREIGN KEY (`tutor_centre`) REFERENCES `tutor_centre` (`dni`);

--
-- Constraints for table `tutor_empresa`
--
ALTER TABLE `tutor_empresa`
  ADD CONSTRAINT `tutor_empresa_ibfk_1` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`cif`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
