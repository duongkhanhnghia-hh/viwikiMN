-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: viwiki
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2017-11-03 10:29:29','2017-11-03 10:29:29');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_articles_on_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Kiểm thử hộp đen',7,'2017-06-27 00:09:44','2017-06-27 00:09:44'),(2,'Kiểm thử hộp trắng',7,'2017-06-27 00:09:44','2017-06-27 00:09:44'),(3,'Alloy',8,'2017-06-27 00:09:44','2017-06-27 00:09:44'),(4,'SMT Solver',8,'2017-06-27 00:09:44','2017-06-27 00:09:44'),(5,'Mô hình OSI',6,'2017-06-27 00:09:44','2017-06-27 00:09:44'),(6,'TCP/IP',6,'2017-06-27 00:09:44','2017-06-27 00:09:44');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `depth` int(11) NOT NULL DEFAULT '0',
  `children_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_categories_on_parent_id` (`parent_id`),
  KEY `index_categories_on_lft` (`lft`),
  KEY `index_categories_on_rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Công nghệ thông tin',NULL,1,14,0,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(2,'Toán học',NULL,17,18,0,0,'2017-06-26 17:09:44','2017-09-04 01:34:17'),(3,'Vật lý',NULL,17,18,0,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(4,'Công nghệ phần mềm',1,2,9,1,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(5,'Khoa học máy tính',1,10,11,1,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(6,'Mạng máy tính',1,12,13,1,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(7,'Kiểm thử',4,3,6,2,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(8,'Phương pháp hình thức',4,7,8,2,0,'2017-06-26 17:09:44','2017-06-29 10:09:48'),(9,'Tên chuyên mục',7,4,5,3,0,'2017-06-29 10:09:48','2017-06-29 10:09:48');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_user_id` (`user_id`),
  KEY `index_comments_on_post_id` (`post_id`),
  CONSTRAINT `fk_rails_03de2dc08c` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_posts_on_user_id` (`user_id`),
  KEY `index_posts_on_category_id` (`category_id`),
  CONSTRAINT `fk_rails_5b5ddfd518` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'adda','adad',5,2,'2017-11-03 16:30:44','2017-11-03 16:30:44');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_roles_on_name` (`name`),
  KEY `index_roles_on_name_and_resource_type_and_resource_id` (`name`,`resource_type`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin',NULL,NULL,'2016-11-26 04:10:33','2016-11-26 04:10:33'),(2,'editor','Category',4,'2016-11-28 04:26:32','2016-11-28 04:26:32'),(3,'editor','Category',7,'2016-11-28 07:24:01','2016-11-28 07:24:01'),(4,'editor','Category',1,'2016-11-26 04:10:33','2016-11-26 04:10:33'),(5,'editor','Category',2,'2016-11-26 04:10:33','2016-11-26 04:10:33'),(6,'editor','Category',3,'2016-11-26 04:10:33','2016-11-26 04:10:33');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20161122041421'),('20161122042317'),('20161124043509'),('20161125185537'),('20170918162025'),('20170918162228');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `phanquyen` tinyint(1) NOT NULL DEFAULT '0',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'baongoc124@gmail.com','$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W',1,NULL,NULL,NULL,22,'2017-11-11 10:59:16','2017-11-11 10:43:34','127.0.0.1','127.0.0.1','WpEbbK968CLHZwDedLTr','2016-11-25 03:29:38','2016-11-25 03:29:30',NULL,'2016-11-25 03:29:30','2017-11-11 10:59:16'),(3,'test1@t.com','$2a$11$jUUUhfxvh0oM3SyCZpZ.w.uOQe6PAAYsvDir4/UUcowJj07GAfJdm',1,NULL,NULL,NULL,1,'2016-11-25 10:41:23','2016-11-25 10:41:23','::1','::1','7t4m-euH7DUt7GWQJVZF','2016-11-25 10:41:01','2016-11-25 10:40:55',NULL,'2016-11-25 10:40:55','2017-11-08 18:55:41'),(4,'jazmyn@muellermcdermott.co','$2a$11$V2wplnoFzCLjruHhLVVjeewiAXMwRXoYePlJ7V0hv6BZ0mTLB8P9a',1,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'J6HLabsJGnqDiLWs_KBd',NULL,'2016-11-28 04:44:24',NULL,'2016-11-28 04:44:24','2017-11-08 18:51:20'),(5,'hilbert@ziemannsauer.com','$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W',1,NULL,NULL,NULL,2,'2016-11-28 08:17:19','2016-11-28 07:25:19','::1','::1','MHcWNZxpzUy37ammDCAu','2016-11-28 07:22:56','2016-11-28 07:22:47',NULL,'2016-11-28 07:22:47','2016-11-28 08:17:19'),(6,'test1@gmail.com','$2a$11$uTnQ03kmvnpF5sA.W2idXuBaYOW1YMuf3qtP1QFVV1DNC5mn8fpYm',1,NULL,NULL,NULL,1,'2016-11-28 10:51:56','2016-11-28 10:51:56','::1','::1','51LDpzXsAZuCBNyjvUvZ','2016-11-28 10:51:44','2016-11-28 10:51:41',NULL,'2016-11-28 10:51:41','2017-11-08 18:55:29'),(7,'baongoc123@gmail.com','$2a$11$2CSmSknmCM8K51g4b4pvg.ZyXnqj4EZXVkYim0.kZ7n7B3hQVmoY.',0,NULL,NULL,NULL,3,'2017-11-11 10:58:38','2017-11-11 10:40:21','127.0.0.1','127.0.0.1','iqB57CfXrZgzK76_erqm','2017-11-08 10:23:20','2017-11-08 10:23:16',NULL,'2017-11-08 10:23:16','2017-11-11 10:58:38'),(8,'baongoc1241@gmail.com','$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W',1,NULL,NULL,NULL,19,'2017-11-07 09:02:57','2017-11-05 17:59:35','127.0.0.1','127.0.0.1','W1pEbbK968C1LHZwDedLTr','2016-11-25 03:29:38','2016-11-25 03:29:30',NULL,'2016-11-25 03:29:30','2017-11-07 09:02:57'),(9,'test1@t1.com','$2a$11$jUUUhfxvh0oM3SyCZpZ.w.uOQe6PAAYsvDir4/UUcowJj07GAfJdm',0,NULL,NULL,NULL,1,'2016-11-25 10:41:23','2016-11-25 10:41:23','::1','::1','17t4m-eqH7qDUt7GWQJVZF','2016-11-25 10:41:01','2016-11-25 10:40:55',NULL,'2016-11-25 10:40:55','2016-11-25 10:41:51'),(10,'1jazmyn@muellermcdermott.co','$2a$11$V2wplnoFzCLjruHhLVVjeewiAXMwRXoYePlJ7V0hv6BZ0mTLB8P9a',0,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'1J6HLabsJGnqDiLWs_KBd',NULL,'2016-11-28 04:44:24',NULL,'2016-11-28 04:44:24','2016-11-28 04:44:24'),(11,'1hilbert@ziemannsauer.com','$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W',1,NULL,NULL,NULL,2,'2016-11-28 08:17:19','2016-11-28 07:25:19','::1','::1','MHcWNZxp1Uy37ammDCAu','2016-11-28 07:22:56','2016-11-28 07:22:47',NULL,'2016-11-28 07:22:47','2016-11-28 08:17:19'),(12,'tes1t1@gmail.com','$2a$11$uTnQ03kmvnpF5sA.W2idXuBaYOW1YMuf3qtP1QFVV1DNC5mn8fpYm',1,NULL,NULL,NULL,1,'2016-11-28 10:51:56','2016-11-28 10:51:56','::1','::1','51LDp1zXsAZuCBNyjvUvZ','2016-11-28 10:51:44','2016-11-28 10:51:41',NULL,'2016-11-28 10:51:41','2017-11-09 12:02:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `index_users_roles_on_user_id_and_role_id` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (2,1),(3,3),(4,1),(4,6),(5,1),(5,3),(6,3),(12,1);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-11 18:05:32
