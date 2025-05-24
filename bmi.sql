/*
SQLyog Community v12.4.0 (64 bit)
MySQL - 5.6.12-log : Database - bmi
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bmi` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bmi`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can add permission',2,'add_permission'),
(5,'Can change permission',2,'change_permission'),
(6,'Can delete permission',2,'delete_permission'),
(7,'Can add group',3,'add_group'),
(8,'Can change group',3,'change_group'),
(9,'Can delete group',3,'delete_group'),
(10,'Can add user',4,'add_user'),
(11,'Can change user',4,'change_user'),
(12,'Can delete user',4,'delete_user'),
(13,'Can add content type',5,'add_contenttype'),
(14,'Can change content type',5,'change_contenttype'),
(15,'Can delete content type',5,'delete_contenttype'),
(16,'Can add session',6,'add_session'),
(17,'Can change session',6,'change_session'),
(18,'Can delete session',6,'delete_session'),
(19,'Can add register',7,'add_register'),
(20,'Can change register',7,'change_register'),
(21,'Can delete register',7,'delete_register'),
(22,'Can add calculated data',8,'add_calculateddata'),
(23,'Can change calculated data',8,'change_calculateddata'),
(24,'Can delete calculated data',8,'delete_calculateddata'),
(25,'Can add dietitians',9,'add_dietitians'),
(26,'Can change dietitians',9,'change_dietitians'),
(27,'Can delete dietitians',9,'delete_dietitians'),
(28,'Can add dietitianlogin',10,'add_dietitianlogin'),
(29,'Can change dietitianlogin',10,'change_dietitianlogin'),
(30,'Can delete dietitianlogin',10,'delete_dietitianlogin'),
(31,'Can add membershipplans',11,'add_membershipplans'),
(32,'Can change membershipplans',11,'change_membershipplans'),
(33,'Can delete membershipplans',11,'delete_membershipplans'),
(34,'Can add bookappointment',12,'add_bookappointment'),
(35,'Can change bookappointment',12,'change_bookappointment'),
(36,'Can delete bookappointment',12,'delete_bookappointment'),
(37,'Can add beforeconfirmation',13,'add_beforeconfirmation'),
(38,'Can change beforeconfirmation',13,'change_beforeconfirmation'),
(39,'Can delete beforeconfirmation',13,'delete_beforeconfirmation'),
(40,'Can add beforeplanconfirmation',14,'add_beforeplanconfirmation'),
(41,'Can change beforeplanconfirmation',14,'change_beforeplanconfirmation'),
(42,'Can delete beforeplanconfirmation',14,'delete_beforeplanconfirmation');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$100000$a6YN2jnU8IPX$rtId/a/bBSToY8sxrMr+JChlFdxShqTzPCdXgB6SVWo=','2025-05-23 07:56:52.442334',0,'santeena.at@gmail.com','santeena','Thomas','santeena.at@gmail.com',0,1,'2025-05-09 05:47:26.589461'),
(2,'pbkdf2_sha256$100000$WYVZTWO0fYXE$qV6GguFOySfHu5Con+mln5Ghef5XKmsoZkGANEvjNmI=','2025-05-19 04:09:20.743958',1,'admin','','','',1,1,'2025-05-19 04:09:04.935646'),
(3,'pbkdf2_sha256$100000$0I5VCi1vpdHx$cqWXNdr0kvcC+HlrjXStS//4hrVZjgQdRN0jBOt8pW4=','2025-05-23 05:10:14.778893',1,'adminehealth','','','',1,1,'2025-05-23 05:10:02.516484'),
(4,'pbkdf2_sha256$100000$kNWjkhCg49l1$uZd1plLNsFQgAItYJhhQ37jgG3KF2N95UhAvskLYMTE=','2025-05-23 05:18:07.434832',0,'santeena.focus@gmail.com','gouri','ms','santeena.focus@gmail.com',0,1,'2025-05-23 05:18:01.387753'),
(5,'pbkdf2_sha256$100000$BZwqZdVMStHh$klp8PFgiaaxWFZFjwpCjLhTzIbonDhTU5qxskF7MpxE=','2025-05-23 06:30:36.932540',0,'jishnakp14@gmail.com','Jishna','K P','jishnakp14@gmail.com',0,1,'2025-05-23 06:30:25.107212');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `calc_beforeconfirmation` */

DROP TABLE IF EXISTS `calc_beforeconfirmation`;

CREATE TABLE `calc_beforeconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bdate` date NOT NULL,
  `btime` time(6) NOT NULL,
  `fee` double NOT NULL,
  `status` varchar(50) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_beforeconfirmat_appointment_id_f6f0b9a8_fk_calc_book` (`appointment_id`),
  CONSTRAINT `calc_beforeconfirmat_appointment_id_f6f0b9a8_fk_calc_book` FOREIGN KEY (`appointment_id`) REFERENCES `calc_bookappointment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `calc_beforeconfirmation` */

insert  into `calc_beforeconfirmation`(`id`,`bdate`,`btime`,`fee`,`status`,`appointment_id`) values 
(1,'2025-06-07','18:06:00.000000',1000,'Paid',4);

/*Table structure for table `calc_beforeplanconfirmation` */

DROP TABLE IF EXISTS `calc_beforeplanconfirmation`;

CREATE TABLE `calc_beforeplanconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bdate` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_beforeplanconfi_plan_id_bf00af02_fk_calc_memb` (`plan_id`),
  KEY `calc_beforeplanconfirmation_user_id_6eca23a6_fk_calc_register_id` (`user_id`),
  CONSTRAINT `calc_beforeplanconfirmation_user_id_6eca23a6_fk_calc_register_id` FOREIGN KEY (`user_id`) REFERENCES `calc_register` (`id`),
  CONSTRAINT `calc_beforeplanconfi_plan_id_bf00af02_fk_calc_memb` FOREIGN KEY (`plan_id`) REFERENCES `calc_membershipplans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `calc_beforeplanconfirmation` */

insert  into `calc_beforeplanconfirmation`(`id`,`bdate`,`status`,`plan_id`,`user_id`) values 
(1,'2025-05-23','Paid',1,1);

/*Table structure for table `calc_bookappointment` */

DROP TABLE IF EXISTS `calc_bookappointment`;

CREATE TABLE `calc_bookappointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `mobile` varchar(12) DEFAULT NULL,
  `height` varchar(4) DEFAULT NULL,
  `weight` varchar(3) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `bmi_category` varchar(100) DEFAULT NULL,
  `bmr` double DEFAULT NULL,
  `pal` varchar(3) DEFAULT NULL,
  `tmr` double DEFAULT NULL,
  `date` date NOT NULL,
  `dname_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_bookappointment_dname_id_3b887ca5_fk_calc_dietitians_id` (`dname_id`),
  CONSTRAINT `calc_bookappointment_dname_id_3b887ca5_fk_calc_dietitians_id` FOREIGN KEY (`dname_id`) REFERENCES `calc_dietitians` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `calc_bookappointment` */

insert  into `calc_bookappointment`(`id`,`fname`,`lname`,`email`,`mobile`,`height`,`weight`,`gender`,`bmi`,`bmi_category`,`bmr`,`pal`,`tmr`,`date`,`dname_id`) values 
(4,'santeena','Thomas','santeena.at@gmail.com','9400537541','158','66','male',42.97,'morbidly obese',1394,'1.4',1937.6,'2025-05-23',2);

/*Table structure for table `calc_calculateddata` */

DROP TABLE IF EXISTS `calc_calculateddata`;

CREATE TABLE `calc_calculateddata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(8) DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `bmi_category` varchar(100) DEFAULT NULL,
  `pal` varchar(3) DEFAULT NULL,
  `bmr` double DEFAULT NULL,
  `tmr` double DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_calculateddata_person_id_77890dbe_fk_calc_register_id` (`person_id`),
  CONSTRAINT `calc_calculateddata_person_id_77890dbe_fk_calc_register_id` FOREIGN KEY (`person_id`) REFERENCES `calc_register` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `calc_calculateddata` */

insert  into `calc_calculateddata`(`id`,`gender`,`bmi`,`bmi_category`,`pal`,`bmr`,`tmr`,`person_id`) values 
(1,'male',42.97,'morbidly obese','1.4',1394,1937.6,1),
(2,'female',26.04,'overweight','1.4',1321.5,1780.1,2),
(3,'female',18.83,'normal weight','1.2',NULL,NULL,3);

/*Table structure for table `calc_dietitianlogin` */

DROP TABLE IF EXISTS `calc_dietitianlogin`;

CREATE TABLE `calc_dietitianlogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(254) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_dietitianlogin_name_id_c4b84a19_fk_calc_dietitians_id` (`name_id`),
  CONSTRAINT `calc_dietitianlogin_name_id_c4b84a19_fk_calc_dietitians_id` FOREIGN KEY (`name_id`) REFERENCES `calc_dietitians` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `calc_dietitianlogin` */

insert  into `calc_dietitianlogin`(`id`,`username`,`password`,`name_id`) values 
(1,'santeenathomasarakkal@gmail.com','123',1),
(2,'rainytours@gmail.com','123',2);

/*Table structure for table `calc_dietitians` */

DROP TABLE IF EXISTS `calc_dietitians`;

CREATE TABLE `calc_dietitians` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `Qualification` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `calc_dietitians` */

insert  into `calc_dietitians`(`id`,`name`,`Qualification`,`email`,`phone`,`password`,`profile`) values 
(1,'teena','md','santeenathomasarakkal@gmail.com','9400537541','123','profile/download_2.jpg'),
(2,'siya','Physician','rainytours@gmail.com','9876543210','123','profile/download_1.jpg');

/*Table structure for table `calc_membershipplans` */

DROP TABLE IF EXISTS `calc_membershipplans`;

CREATE TABLE `calc_membershipplans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(100) DEFAULT NULL,
  `price_per_month` double DEFAULT NULL,
  `duration_in_months` double DEFAULT NULL,
  `personal_trainer` tinyint(1) NOT NULL,
  `Amount_of_people` double DEFAULT NULL,
  `number_of_visits` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `calc_membershipplans` */

insert  into `calc_membershipplans`(`id`,`plan_name`,`price_per_month`,`duration_in_months`,`personal_trainer`,`Amount_of_people`,`number_of_visits`) values 
(1,'Basic',1700,12,0,1,'unlimited'),
(2,'Standard',5700,12,1,1,'unlimited'),
(3,'Premium',9800,12,1,1,'unlimited');

/*Table structure for table `calc_register` */

DROP TABLE IF EXISTS `calc_register`;

CREATE TABLE `calc_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `username` varchar(254) DEFAULT NULL,
  `mail` varchar(254) DEFAULT NULL,
  `mobile` varchar(12) DEFAULT NULL,
  `height` varchar(4) DEFAULT NULL,
  `weight` varchar(3) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calc_register_user_id_b2dd6a0b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `calc_register_user_id_b2dd6a0b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `calc_register` */

insert  into `calc_register`(`id`,`fname`,`lname`,`username`,`mail`,`mobile`,`height`,`weight`,`password`,`user_id`) values 
(1,'santeena','Thomas','santeena.at@gmail.com','santeena.at@gmail.com','9400537541','158','66','123',1),
(2,'gouri','ms','focus.santeena@gmail.com','santeena.focus@gmail.com','9400537541','158','60','123',4),
(3,'Jishna','K P','jishnakp14@gmail.com','jishnakp14@gmail.com','7356230406','158','47','123',5);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values 
(1,'2025-05-19 04:10:52.582248','1','Basic',1,'[{\"added\": {}}]',11,2),
(2,'2025-05-19 04:11:33.186204','2','Standard',1,'[{\"added\": {}}]',11,2),
(3,'2025-05-19 04:12:05.796509','3','Premium',1,'[{\"added\": {}}]',11,2),
(4,'2025-05-23 05:10:30.197013','1','teena',2,'[{\"changed\": {\"fields\": [\"name\"]}}]',9,3),
(5,'2025-05-23 05:11:53.762355','2','siya',1,'[{\"added\": {}}]',9,3),
(6,'2025-05-23 05:13:28.889128','2','siya',1,'[{\"added\": {}}]',10,3),
(7,'2025-05-23 05:28:38.079666','2','gouri',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',7,3),
(8,'2025-05-23 05:36:50.004481','1','teena',2,'[{\"changed\": {\"fields\": [\"profile\"]}}]',9,3);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(13,'calc','beforeconfirmation'),
(14,'calc','beforeplanconfirmation'),
(12,'calc','bookappointment'),
(8,'calc','calculateddata'),
(10,'calc','dietitianlogin'),
(9,'calc','dietitians'),
(11,'calc','membershipplans'),
(7,'calc','register'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2025-05-09 05:25:05.526751'),
(2,'auth','0001_initial','2025-05-09 05:25:06.895134'),
(3,'admin','0001_initial','2025-05-09 05:25:07.195796'),
(4,'admin','0002_logentry_remove_auto_add','2025-05-09 05:25:07.211817'),
(5,'contenttypes','0002_remove_content_type_name','2025-05-09 05:25:07.362455'),
(6,'auth','0002_alter_permission_name_max_length','2025-05-09 05:25:07.479080'),
(7,'auth','0003_alter_user_email_max_length','2025-05-09 05:25:07.562269'),
(8,'auth','0004_alter_user_username_opts','2025-05-09 05:25:07.578933'),
(9,'auth','0005_alter_user_last_login_null','2025-05-09 05:25:07.662375'),
(10,'auth','0006_require_contenttypes_0002','2025-05-09 05:25:07.662375'),
(11,'auth','0007_alter_validators_add_error_messages','2025-05-09 05:25:07.677997'),
(12,'auth','0008_alter_user_username_max_length','2025-05-09 05:25:07.762521'),
(13,'auth','0009_alter_user_last_name_max_length','2025-05-09 05:25:07.862728'),
(14,'calc','0001_initial','2025-05-09 05:25:08.062745'),
(15,'sessions','0001_initial','2025-05-09 05:25:08.179507'),
(16,'calc','0002_calculateddata','2025-05-09 07:39:42.700440'),
(17,'calc','0003_dietitians','2025-05-13 07:25:26.037639'),
(18,'calc','0004_dietitianlogin','2025-05-19 03:56:18.332799'),
(19,'calc','0005_membershipplans','2025-05-19 04:09:46.631380'),
(20,'calc','0006_bookappointment','2025-05-22 07:27:52.286814'),
(21,'calc','0007_beforeconfirmation','2025-05-23 04:38:29.831149'),
(22,'calc','0008_beforeplanconfirmation','2025-05-23 05:51:13.923435');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('0w65t0g5twitgrfwh2eijz4rzv3tbw9a','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-06-06 07:56:52.442334'),
('2ctnkfwfdlx4xj6tigoxr58zhcojk30r','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-06-05 06:53:35.150208'),
('7mmho8xz6jn768g5d6rfkwmao69ags6s','Yzk0NjMyZDY1ODNmNDc4NTQxOTkyODEyZmVhZGI5Y2U0ODY3NTU0MDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYTkwODc5ODRlOGZjYTExNzk1MDViMDE3N2ZiODJiZTJiZDExN2U5In0=','2025-06-06 05:10:14.802548'),
('auwwjrsumf0vr17okeevoa04ngrahmfp','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-05-23 07:07:26.021684'),
('bklk0f8egxv9v2vcufx7ol4sgdkqo9c7','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-05-26 11:20:49.893992'),
('sm730068aq2nnoim1bbgcnn0lsyvzbb8','NTY2NTQ2Y2QwNTU4YTM2Njc5YmEwMjRjZTJmMjgwNDMwOGJmMmM1Njp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MjIzOTQxZDllOGM0MTFhODc4Nzk1ZjQzOTgzYjIxNmFlZjcxMjI2In0=','2025-06-02 04:09:20.748946'),
('strbnxeinoj8j8nz9it1d33vs87tdfml','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-05-26 07:26:42.082341'),
('xc3415ldug89cml2l2fp6pnfj97452xn','NGEwNjhjNWQ1OWIyYzI1YWU2MDRjM2Q4MjZlY2ZiNTVjY2FiN2RmYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzI3YWJmMmMwNDEzMWI0ZjI1OGI0MzFhOWJjMGJjYTQxNzlmZDA2In0=','2025-05-23 06:06:15.525514');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
