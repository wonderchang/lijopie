-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: lijopie
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+08:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(12) DEFAULT NULL,
  `police_code` varchar(256) NOT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,'東區','ou=01,ou=tncgb02,o=tncgb,c=tw'),(2,'北區','ou=05,ou=tncgb02,o=tncgb,c=tw'),(3,'南區','ou=06,ou=tncgb02,o=tncgb,c=tw'),(4,'中西區','ou=02,ou=tncgb02,o=tncgb,c=tw'),(5,'安南區','ou=03,ou=tncgb02,o=tncgb,c=tw'),(6,'安平區','ou=04,ou=tncgb02,o=tncgb,c=tw'),(7,'七股區','ou=11,ou=tncgb02,o=tncgb,c=tw'),(8,'下營區','ou=09,ou=tncgb02,o=tncgb,c=tw'),(9,'仁德區','ou=14,ou=tncgb02,o=tncgb,c=tw'),(10,'佳里區','ou=11,ou=tncgb02,o=tncgb,c=tw'),(11,'六甲區','ou=09,ou=tncgb02,o=tncgb,c=tw'),(12,'北門區','ou=12,ou=tncgb02,o=tncgb,c=tw'),(13,'南化區','ou=16,ou=tncgb02,o=tncgb,c=tw'),(14,'善化區','ou=10,ou=tncgb02,o=tncgb,c=tw'),(15,'大內區','ou=10,ou=tncgb02,o=tncgb,c=tw'),(16,'學甲區','ou=12,ou=tncgb02,o=tncgb,c=tw'),(17,'安定區','ou=10,ou=tncgb02,o=tncgb,c=tw'),(18,'官田區','ou=09,ou=tncgb02,o=tncgb,c=tw'),(19,'將軍區','ou=12,ou=tncgb02,o=tncgb,c=tw'),(20,'山上區','ou=13,ou=tncgb02,o=tncgb,c=tw'),(21,'左鎮區','ou=13,ou=tncgb02,o=tncgb,c=tw'),(22,'後壁區','ou=08,ou=tncgb02,o=tncgb,c=tw'),(23,'新化區','ou=13,ou=tncgb02,o=tncgb,c=tw'),(24,'新市區','ou=10,ou=tncgb02,o=tncgb,c=tw'),(25,'新營區','ou=07,ou=tncgb02,o=tncgb,c=tw'),(26,'東山區','ou=08,ou=tncgb02,o=tncgb,c=tw'),(27,'柳營區','ou=07,ou=tncgb02,o=tncgb,c=tw'),(28,'楠西區','ou=16,ou=tncgb02,o=tncgb,c=tw'),(29,'歸仁區','ou=14,ou=tncgb02,o=tncgb,c=tw'),(30,'永康區','ou=15,ou=tncgb02,o=tncgb,c=tw'),(31,'玉井區','ou=16,ou=tncgb02,o=tncgb,c=tw'),(32,'白河區','ou=08,ou=tncgb02,o=tncgb,c=tw'),(33,'西港區','ou=11,ou=tncgb02,o=tncgb,c=tw'),(34,'關廟區','ou=14,ou=tncgb02,o=tncgb,c=tw'),(35,'鹽水區','ou=07,ou=tncgb02,o=tncgb,c=tw'),(36,'麻豆區','ou=09,ou=tncgb02,o=tncgb,c=tw'),(37,'龍崎區','ou=14,ou=tncgb02,o=tncgb,c=tw');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `content` varchar(256) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `gps` varchar(256) DEFAULT NULL,
  `marker` varchar(256) DEFAULT NULL,
  `progress_id` int(11) DEFAULT NULL,
  `picture1` varchar(256) DEFAULT NULL,
  `picture2` varchar(256) DEFAULT NULL,
  `picture3` varchar(256) DEFAULT NULL,
  `anonymous` int(1) DEFAULT NULL,
  `report_time` timestamp NULL DEFAULT NULL,
  `apply_time` timestamp NULL DEFAULT NULL,
  `response_file` varchar(256) DEFAULT NULL,
  `result_time` timestamp NULL DEFAULT NULL,
  `active` int(1) DEFAULT '1',
  `case_id` varchar(256) DEFAULT NULL,
  `result_file` varchar(256) DEFAULT NULL,
  `result` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_file` varchar(256) DEFAULT NULL,
  `cookie_key` varchar(256) DEFAULT NULL,
  `cookie_value` varchar(256) DEFAULT NULL,
  `verify_code` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'紅線停車'),(2,'黃線停車'),(3,'公車站牌10公尺內停車'),(4,'交叉路口10公尺內停車'),(5,'行人穿越道10公尺內停車'),(6,'黃線併排'),(7,'紅線併排'),(8,'消防栓前停車'),(9,'彎道停車'),(10,'人行道停車'),(11,'停在殘障車位');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail`(
	`mail_id` int(11) NOT NULL AUTO_INCREMENT, 
	`subject` varchar(128) DEFAULT NULL,
	`email` varchar(128) DEFAULT NULL,
	`name` varchar(32) DEFAULT NULL,
	`content` varchar(512) DEFAULT NULL,
	`sendtime` datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for `mail`
--

LOCK TABLES `mail` WRITE;
/*!40000 ALTER TABLE `mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `salt` varchar(64) DEFAULT NULL,
  `cookie` varchar(64) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-29  2:25:43
