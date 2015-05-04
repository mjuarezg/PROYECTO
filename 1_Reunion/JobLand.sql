CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidato` (
  `oferta_id` int(11) NOT NULL,
  `fechaInscripcion` varchar(45) NOT NULL,
  `uduario_id` varchar(45) NOT NULL,
  PRIMARY KEY (`oferta_id`,`uduario_id`),
  KEY `fk_Usuario basico_has_Oferta_Oferta1_idx` (`oferta_id`),
  KEY `fk_Candidato_Usuariobasico1_idx` (`uduario_id`),
  CONSTRAINT `fk_Candidato_Usuariobasico1` FOREIGN KEY (`uduario_id`) REFERENCES `usuariobasico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario basico_has_Oferta_Oferta1` FOREIGN KEY (`oferta_id`) REFERENCES `oferta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato`
--

LOCK TABLES `candidato` WRITE;
/*!40000 ALTER TABLE `candidato` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum`
--

DROP TABLE IF EXISTS `curriculum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum` (
  `nombre` varchar(45) DEFAULT NULL,
  `fechaSubida` date NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ubicacion_UNIQUE` (`ubicacion`),
  CONSTRAINT `fk_Curriculum_Usuariobasico1` FOREIGN KEY (`id`) REFERENCES `usuariobasico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum`
--

LOCK TABLES `curriculum` WRITE;
/*!40000 ALTER TABLE `curriculum` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `clave` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `provincia` varchar(20) NOT NULL,
  `id` varchar(45) NOT NULL,
  `sector` varchar(10) NOT NULL,
  PRIMARY KEY (`id`,`sector`),
  KEY `fk_Empresa_Provincia1_idx` (`provincia`),
  KEY `fk_Empresa_Sector1_idx` (`sector`),
  CONSTRAINT `fk_Empresa_Provincia1` FOREIGN KEY (`provincia`) REFERENCES `provincia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Sector1` FOREIGN KEY (`sector`) REFERENCES `sector` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Usuario1` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensaje` (
  `titulo` varchar(45) NOT NULL,
  `contenido` varchar(45) NOT NULL,
  `fechaEnvio` date NOT NULL,
  `privado` tinyint(1) NOT NULL,
  `leido` tinyint(1) NOT NULL,
  `id` int(11) NOT NULL,
  `emisor` varchar(45) NOT NULL,
  `receptor` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`emisor`,`receptor`),
  KEY `fk_Mensaje_Usuario1_idx` (`emisor`),
  KEY `fk_Mensaje_Usuario2_idx` (`receptor`),
  CONSTRAINT `fk_Mensaje_Usuario1` FOREIGN KEY (`emisor`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensaje_Usuario2` FOREIGN KEY (`receptor`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje`
--

LOCK TABLES `mensaje` WRITE;
/*!40000 ALTER TABLE `mensaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oferta` (
  `id` int(11) NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechaPublicacion` date NOT NULL,
  `abierta` tinyint(1) NOT NULL,
  `salario` int(11) DEFAULT NULL,
  `jornada` varchar(45) DEFAULT NULL,
  `contrato` varchar(45) DEFAULT NULL,
  `Empresa_id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`Empresa_id`),
  KEY `fk_Oferta_Empresa1_idx` (`Empresa_id`),
  CONSTRAINT `fk_Oferta_Empresa1` FOREIGN KEY (`Empresa_id`) REFERENCES `empresa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferta`
--

LOCK TABLES `oferta` WRITE;
/*!40000 ALTER TABLE `oferta` DISABLE KEYS */;
/*!40000 ALTER TABLE `oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `id` varchar(20) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES ('0','null'),('A Coruña','A Coruña'),('Álava','Álava'),('Albacete','Albacete'),('Alicante','Alicante'),('Almería','Almería'),('Asturias','Asturias'),('Ávila','Ávila'),('Badajoz','Badajoz'),('Barcelona','Barcelona'),('Burgos','Burgos'),('Cáceres','Cáceres'),('Cádiz','Cádiz'),('Cantabria','Cantabria'),('Castellón','Castellón'),('Ceuta','Ceuta'),('Ciudad Real','Ciudad Real'),('Córdoba','Córdoba'),('Cuenca','Cuenca'),('Girona','Girona'),('Granada','Granada'),('Guadalajara','Guadalajara'),('Guipúzcoa','Guipúzcoa'),('Huelva','Huelva'),('Huesca','Huesca'),('Illes Balears','Illes Balears'),('Jaén','Jaén'),('La Rioja','La Rioja'),('Las Palmas','Las Palmas'),('León','León'),('Lleida','Lleida'),('Lugo','Lugo'),('Madrid','Madrid'),('Málaga','Málaga'),('Melilla','Melilla'),('Murcia','Murcia'),('Navarra','Navarra'),('Ourense','Ourense'),('Palencia','Palencia'),('Pontevedra','Pontevedra'),('Salamanca','Salamanca'),('Santa Cruz de Teneri','Santa Cruz de Tenerife'),('Segovia','Segovia'),('Sevilla','Sevilla'),('Soria','Soria'),('Tarragona','Tarragona'),('Teruel','Teruel'),('Toledo','Toledo'),('Valencia','Valencia'),('Valladolid','Valladolid'),('Vizcaya','Vizcaya'),('Zamora','Zamora'),('Zaragoza','Zaragoza');
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sector`
--

DROP TABLE IF EXISTS `sector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sector` (
  `nombre` varchar(300) NOT NULL,
  `id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sector`
--

LOCK TABLES `sector` WRITE;
/*!40000 ALTER TABLE `sector` DISABLE KEYS */;
INSERT INTO `sector` VALUES ('Arte y Cultura','AC'),('Aeronáutica - Aeroespacial y Defensa','AERO'),('Artes Gráficas, Papel y Cartón, Envases y Embalajes, Maquinaria, Productos y Suministros','AGRAF'),('Agroalimentario - Agricultura - Agroforestal - Ganadería - Pesca y Jardinería','AGRO'),('Alimentación y Bebidas - Gourmet - Productos y Servicios','ALIM'),('Profesionales Colegiados y Autónomos','AUT'),('Automoción - Automóviles - Autocaravanas y Motos','AUTO'),('Automoción - Vehículos Industriales','AUTOIND'),('Comercio y Servicios- Artículos, Productos, Reparación y Servicios','COM'),('Construcción y Actividades Diversas','CONS'),('Deportes, Ocio, Espectáculos, Eventos, Náutica, Servicios Culturales y Plataformas Online','DEP'),('Energético - Energía e Industrias de Energía de Electricidad, Gas, Agua y Productos del Petróleo','E'),('Educación - Enseñanza - Guarderías y ludotecas','ED'),('Electricidad - Electrónica y alta Tecnología','ELEC'),('Estética y Cuidado Personal - Equipamiento, Productos y Servicios','EST'),('Hostelería y Turismo - Hoteles - Restaurantes - Viajes','HOS'),('Informática - Internet - Multimedia - Fotografía - Imagen y Sonido','INF'),('Ingeniería','ING'),('Inmobiliarias - Inmobiliarios','INMO'),('Medio Ambiente - Maquinaria y Servicios','MA'),('Madera y Mueble - Productos y Servicios','MAD'),('Maquinaria. Herramientas y Utillaje, Motores, Componentes, Equipamiento e Industrias Automotriz','MAQ'),('Metal - Metalurgia y Siderometalúrgia','MET'),('Minería e Industrias Extractivas','MIN'),('Minerales Metálicos y no Metálicos','MINERAL'),('Naval - Construcción, Productos y Servicios Portuarios','NAV'),('null','null'),('Obras Públicas - Maquinaria, Productos, Servicios y Suministros','OP'),('Organismos Oficiales, Administraciones Púbicas y Ayuntamientos','PUB'),('Química, Petroquímica, Caucho y Plástico','QUI'),('Sanidad, Especialidades Médicas, Clínicas, Servicios Sociales y Equipamientos','SAN'),('Servicios Empresariales','SEMP'),('Suministros Industriales','SI'),('Seguridad y Mantenimiento','SM'),('Servicios Técnicos de Reparación y Mantenimiento','STEC'),('Stock de Maquinaria, Herramientas y Productos','STOCK'),('Telecomunicaciones','TELE'),('Transporte y Logística','TL'),('Textil y Piel - Calzado, Guarnicionería y Marroquinería - Productos - Fabricación y Confección','TP'),('Tecnología de Procesos y Sistemas','TPS');
/*!40000 ALTER TABLE `sector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seleccionado`
--

DROP TABLE IF EXISTS `seleccionado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seleccionado` (
  `usuariobasico_id` varchar(45) NOT NULL,
  `oferta_id` int(11) NOT NULL,
  `fechaSeleccion` date NOT NULL,
  `puntuacion` int(11) DEFAULT NULL,
  `comentario` varchar(45) DEFAULT NULL,
  `Empresa_id` varchar(45) NOT NULL,
  PRIMARY KEY (`usuariobasico_id`,`oferta_id`,`Empresa_id`),
  KEY `fk_Candidatos_has_Empresa_Candidatos1_idx` (`usuariobasico_id`,`oferta_id`),
  KEY `fk_Seleccionado_Empresa1_idx` (`Empresa_id`),
  KEY `fk_Candidatos_has_Empresa_Candidatos1` (`oferta_id`),
  CONSTRAINT `fk_Candidatos_has_Empresa_Candidatos1` FOREIGN KEY (`oferta_id`) REFERENCES `candidato` (`oferta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seleccionado_Empresa1` FOREIGN KEY (`Empresa_id`) REFERENCES `empresa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seleccionado`
--

LOCK TABLES `seleccionado` WRITE;
/*!40000 ALTER TABLE `seleccionado` DISABLE KEYS */;
/*!40000 ALTER TABLE `seleccionado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariobasico`
--

DROP TABLE IF EXISTS `usuariobasico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariobasico` (
  `clave` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `fechaNacimiento` date NOT NULL,
  `email` varchar(45) NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `administrador` tinyint(1) NOT NULL,
  `provincia` varchar(20) NOT NULL,
  `id` varchar(45) NOT NULL,
  `sector` varchar(10) NOT NULL,
  PRIMARY KEY (`id`,`sector`),
  KEY `fk_Usuario basico_Provincia_idx` (`provincia`),
  KEY `fk_Usuariobasico_Sector1_idx` (`sector`),
  CONSTRAINT `fk_Usuario basico_Provincia` FOREIGN KEY (`provincia`) REFERENCES `provincia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuariobasico_Sector1` FOREIGN KEY (`sector`) REFERENCES `sector` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuariobasico_Usuario1` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariobasico`
--

LOCK TABLES `usuariobasico` WRITE;
/*!40000 ALTER TABLE `usuariobasico` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariobasico` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-02 13:59:41
