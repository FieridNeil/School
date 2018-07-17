-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: jalapeno
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `addr_2` varchar(255) DEFAULT NULL,
  `addr_city` varchar(255) DEFAULT NULL,
  `addr_state` varchar(2) DEFAULT NULL,
  `addr_zipcode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'','','guest','','','','','','',''),(2,'fname','lname','test1','1234','test1@email.com','12345, 23456, 23456, 23456, 23456, 23456, 23456, 23456, 23456, 23456','23456','234567','CA','12345'),(3,'fname2','lname2','test2','1234','test2@gmail.com','2131239','840932','fjowiase','CA','82743'),(4,'fname3','lname3','test3','1234','test3@gmail.com','43929',NULL,'jifel','CA','83747');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `inventory_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `purchased` bit(1) DEFAULT b'0',
  `purchase_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'hcrmp9csqhdofrgalj0m0jn2os',4,2,'','2017-12-03 11:01:47'),(2,'hcrmp9csqhdofrgalj0m0jn2os',1,2,'','2017-12-03 11:03:32'),(3,'gihbv9bu8j9o8im5d86k5jlnm9',2,2,'','2017-12-03 11:03:49'),(4,'g5lnpjv0i73kuvloh5hf66mtvl',2,2,'','2017-12-03 11:03:59'),(5,'gb03mvca90fsvmjcvke8j4vt24',3,2,'','2017-12-03 11:05:56');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(10) unsigned NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `heat_id` int(10) unsigned NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `review` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,'Jalapeno','The jalapeno or jalapeno is a medium to large size chili pepper which is prized for the warm, burning sensation when eaten. Ripe, the jalapeno can be 2 to 3.5 inches long and is commonly sold when still green. It is a cultivar of the species Capsicum annuum. It is named after the town of Xalapa, Veracruz, where it was traditionally produced. 160 square kilometres are dedicated for the cultivation of jalapeno in Mexico alone; primarily in the Papaloapan river basin in the north of the state of Veracruz and in the Delicias, Chihuahua area. The jalapeno is known by different names throughout Mexico. Jalapenos are also known as cuaresmenos, huachinangos and chiles gordos. The jalapeno rates between 2,500 and 10,000 Scoville units in heat.',1.00,23,2,'images/jalapeno.png','Blank'),(2,1,'Chipotle','A chipotle is a smoke dried jalapeno chili used primarily in Mexican, Mexican American, Tex Mex, and Mexican inspired cuisine. There are many varieties of jalapenos which vary in size and heat. In Mexico, the jalapeno is also known as the cuaresmeno and gordo. Until recently, chipotles were almost exclusively found in the markets of central and southern Mexico. As Mexican food became more popular in the United States in the late 20th century, jalapeno production and processing began to move into Northern Mexico and the United States. Scoville Heat Units 10,000 to 50,000.',2.00,21,3,'images/chipotle.png','Blank'),(3,1,'Serrano','A serrano pepper is a type of chili pepper that originated in the mountainous regions of the Mexican states of Puebla and Hidalgo. Unripe serranos are green, but the color at maturity varies. Common colors are red, brown, orange, or yellow. Serranos are very meaty and thus they do not dry very well. They are generally between 1 and 4 inches long and around ½ inch wide. Most serranos rate between 10,000 and 20,000 Scoville units',2.00,23,3,'images/serrano.png','Blank'),(4,1,'Tabasco','The Tabasco pepper is a variety of chile pepper species Capsicum frutescens. Like all frutescens chilis, the tabasco plant has a typical bushy growth, which commercial cultivation makes stronger by trimming the plants. The tapered fruits, around 4 cm long, are initially pale yellowish-green and turn yellow and orange before ripening to bright red. Tabascos rate from 30,000 to 50,000 on the Scoville scale of heat levels. A large part of the tabasco pepper stock fell victim to the tobacco mosaic virus in the 1960s, and the first resistant variety was not able to be cultured until around 1970. The sauces featured in this category contain the specific pepper variety called tabasco among other pepper varieties and ingredients. ',2.00,23,3,'images/tabasco.png','Blank'),(5,1,'Cayenne','The Cayenne is a red, hot chili pepper used to flavor dishes, and for medicinal purposes. Named for the city of Cayenne in French Guiana, it is a cultivar of Capsicum annuum related to bell peppers, jalapenos, and others. The capsicum genus is in the nightshade family. The fruits are generally dried and ground, or pulped and baked into cakes, which are then ground and sifted to make the powder, Cayenne pepper. Cayenne is used in cooking spicy hot dishes, as a powder or in its whole form or in a thin, vinegar based sauce. It is generally rated at 30,000 to 50,000 Scoville Units. It is also used as a herbal supplement, and was mentioned by Nicholas Culpeper in his Complete Herbal. ',2.00,25,3,'images/cayenne.png','Blank'),(6,1,'Thai Pepper','Thai pepper in Thai refers to any of three cultivars of chili pepper, found commonly in Thailand, and also in neighbouring countries, such as Malaysia, Indonesia, the Philippines and Singapore. It is also found in India, mainly Kerala, and is used in traditional dishes of kerala cuisine. These tiny little fiery chilis point downward from the plant and their colors change directly from green to red. This type of chili can be found in Malaysia, Brunei, Indonesia, and the Philippines but most commonly in Thailand. Although small in size compared to other types of chili, the chili padi is relatively strong at 50,000 to 100,000 on the Scoville pungency scale. Malaysia consumes about 140 million worth of chilies each year.',1.00,25,4,'images/thai.png','Blank'),(7,1,'Datil','The Datil is an exceptionally hot pepper, a variety of the species Capsicum chinense. Datils are similar to habaneros but have a sweeter, fruitier flavor. Their level of spiciness may be anywhere from 100,000 to 300,000 scoville units. Datil peppers are cultivated throughout the United States and elsewhere, but the majority are produced in St. Augustine, Florida, where they have been traditionally cultivated for roughly two hundred thirty years.',3.00,25,4,'images/datil.png','Blank'),(8,1,'Fatalii','The Fatalii is a chili pepper of Capsicum chinense that originates in central and southern Africa. It is described to have a fruity, citrus flavor with a searing heat that is comparable to the standard habanero. The Scoville Food Institute lists the Fatalii as the sixth hottest pepper with Scoville units ranging from 125,000 to 325,000 units. The plants grow 20 to 25 inches in height, and plant distance should be about the same. The pendant pods get 2.5 to 3.5 inches long and about 0.75 to 1.5 inches wide. From a pale green, they mature to a bright yellow. The Fatalii is known for its extreme heat and citrus flavor. Because of such flavor and heat it makes for a unique hot sauce that usually compromises of other citrus flavors like lime and lemon. The walls of the peppers are very thin which makes it very easy to dry. After drying they can be used as powders.',3.00,25,4,'images/fatalii.png','Blank'),(9,1,'Carolina Reaper','The Carolina Reaper is a hybrid chili pepper of the Capsicum chinense species, originally called the HP22B, bred by cultivator Ed Currie, who runs PuckerButt Pepper Company in Fort Mill, South Carolina. The Carolina Reaper was rated as the worlds hottest chili pepper by Guinness World Records according to 2012 tests, averaging 1,569,300 SHU on the Scoville scale with peak levels of over 2,200,000 SHU. The previous record holder was the Trinidad Moruga Scorpion.',5.00,25,5,'images/carolinareaper.png','Blank');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,1,'Jalapeno Hummus','images/recipe/jalapenoHummus.jpg','http://allrecipes.com/recipe/46462/jalapeno-hummus/'),(2,1,'Japalpeno Popper Chicken','images/recipe/jalapenoPopperChicken.jpg','http://allrecipes.com/recipe/65671/jalapeno-popper-chicken/'),(3,1,'Stuffed Jalapeno','images/recipe/jalapenoStuffed.jpg','http://allrecipes.com/recipe/26975/stuffed-jalapenos-iii/'),(4,2,'Chipotle Hummus','images/recipe/chipotleHummus.jpg','http://allrecipes.com/recipe/254230/chipotle-hummus/'),(5,2,'Chipotle Mayo','images/recipe/chipotleMayo.jpg','http://allrecipes.com/recipe/87542/chipotle-mayo/'),(6,2,'Chipotle Shrimp Taco','images/recipe/chipotleShrimpTaco.jpg','http://allrecipes.com/recipe/109777/chipotle-shrimp-tacos/');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,2,1,'Review #1'),(2,3,1,'Review #2'),(3,4,1,'Review #3'),(4,2,1,'Review #4'),(5,2,2,'Review #1'),(6,2,2,'Review #2'),(7,2,3,'Review #1');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (121,'65rv22ju48ke4b9544cfrdv6am',2),(124,'gmdi5i10v5m5e9pinki127eb2c',3),(187,'tsrvjvtd1p97ltrrjb6bap71u5',4);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-03  3:43:50
