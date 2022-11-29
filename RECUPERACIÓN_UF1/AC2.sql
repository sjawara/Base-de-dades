-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: gestio_botigues
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1

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
-- Table structure for table `botiga`
--

DROP TABLE IF EXISTS `botiga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `botiga` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ciutat` varchar(50) DEFAULT NULL,
  `CARRER` varchar(50) DEFAULT NULL,
  `num_pis` varchar(10) DEFAULT NULL,
  `num_planta_porta` varchar(10) DEFAULT NULL,
  `descompte` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `botiga`
--

LOCK TABLES `botiga` WRITE;
/*!40000 ALTER TABLE `botiga` DISABLE KEYS */;
/*!40000 ALTER TABLE `botiga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `botiga_producte`
--

DROP TABLE IF EXISTS `botiga_producte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `botiga_producte` (
  `id_botiga` int NOT NULL,
  `codi_producte` int NOT NULL,
  `preu_venda` float NOT NULL,
  PRIMARY KEY (`id_botiga`,`codi_producte`),
  KEY `codi_producte` (`codi_producte`),
  CONSTRAINT `botiga_producte_ibfk_1` FOREIGN KEY (`id_botiga`) REFERENCES `botiga` (`id`),
  CONSTRAINT `botiga_producte_ibfk_2` FOREIGN KEY (`codi_producte`) REFERENCES `producte` (`codi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `botiga_producte`
--

LOCK TABLES `botiga_producte` WRITE;
/*!40000 ALTER TABLE `botiga_producte` DISABLE KEYS */;
/*!40000 ALTER TABLE `botiga_producte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `codi` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(15) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `data_naixement` date NOT NULL,
  `ciutat` varchar(50) DEFAULT NULL,
  `nom_targeta` varchar(50) DEFAULT NULL,
  `num_targeta` int DEFAULT NULL,
  `cod_seguretat` int DEFAULT NULL,
  `data_venciment` date DEFAULT NULL,
  `id_botiga` int NOT NULL,
  PRIMARY KEY (`codi`),
  KEY `id_botiga` (`id_botiga`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`id_botiga`) REFERENCES `botiga` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleat`
--

DROP TABLE IF EXISTS `empleat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleat` (
  `dni` varchar(15) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `lloc_treball` varchar(25) NOT NULL,
  `carrer` varchar(50) DEFAULT NULL,
  `num_pis` varchar(10) DEFAULT NULL,
  `num_planta_porta` varchar(10) DEFAULT NULL,
  `telèfon` int NOT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleat`
--

LOCK TABLES `empleat` WRITE;
/*!40000 ALTER TABLE `empleat` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fàbrica`
--

DROP TABLE IF EXISTS `fàbrica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fàbrica` (
  `codi` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `quantitat_empleats` int NOT NULL,
  `nom_gerent` varchar(50) NOT NULL,
  PRIMARY KEY (`codi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fàbrica`
--

LOCK TABLES `fàbrica` WRITE;
/*!40000 ALTER TABLE `fàbrica` DISABLE KEYS */;
/*!40000 ALTER TABLE `fàbrica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producte`
--

DROP TABLE IF EXISTS `producte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producte` (
  `codi` int NOT NULL AUTO_INCREMENT,
  `descripció` varchar(75) DEFAULT NULL,
  `color` varchar(50) NOT NULL,
  `preu_fabricació` float NOT NULL,
  `codi_fabrica` int NOT NULL,
  PRIMARY KEY (`codi`),
  KEY `codi_fabrica` (`codi_fabrica`),
  CONSTRAINT `producte_ibfk_1` FOREIGN KEY (`codi_fabrica`) REFERENCES `fàbrica` (`codi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producte`
--

LOCK TABLES `producte` WRITE;
/*!40000 ALTER TABLE `producte` DISABLE KEYS */;
/*!40000 ALTER TABLE `producte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treballa`
--

DROP TABLE IF EXISTS `treballa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treballa` (
  `id_botiga` int NOT NULL,
  `dni_empleat` varchar(15) NOT NULL,
  `dia` date DEFAULT NULL,
  `entrada` time DEFAULT NULL,
  `sortida` time DEFAULT NULL,
  PRIMARY KEY (`id_botiga`,`dni_empleat`),
  KEY `dni_empleat` (`dni_empleat`),
  CONSTRAINT `treballa_ibfk_1` FOREIGN KEY (`id_botiga`) REFERENCES `botiga` (`id`),
  CONSTRAINT `treballa_ibfk_2` FOREIGN KEY (`dni_empleat`) REFERENCES `empleat` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treballa`
--

LOCK TABLES `treballa` WRITE;
/*!40000 ALTER TABLE `treballa` DISABLE KEYS */;
/*!40000 ALTER TABLE `treballa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-29  1:32:13
