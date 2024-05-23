/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - assessment
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`assessment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `assessment`;

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),
(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),
(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),
(6,'2016_06_01_000004_create_oauth_clients_table',1),
(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),
(8,'2019_08_19_000000_create_failed_jobs_table',1),
(9,'2019_12_14_000001_create_personal_access_tokens_table',1),
(10,'2024_05_18_035302_create_products_table',1);

/*Table structure for table `oauth_access_tokens` */

DROP TABLE IF EXISTS `oauth_access_tokens`;

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `oauth_access_tokens` */

/*Table structure for table `oauth_auth_codes` */

DROP TABLE IF EXISTS `oauth_auth_codes`;

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `oauth_auth_codes` */

/*Table structure for table `oauth_clients` */

DROP TABLE IF EXISTS `oauth_clients`;

CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `oauth_clients` */

/*Table structure for table `oauth_personal_access_clients` */

DROP TABLE IF EXISTS `oauth_personal_access_clients`;

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `oauth_personal_access_clients` */

/*Table structure for table `oauth_refresh_tokens` */

DROP TABLE IF EXISTS `oauth_refresh_tokens`;

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `oauth_refresh_tokens` */

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',1,'MyApp','0129e27d3ec0da09b52021ed3f495a758c3fb949932c6cb6aaebe02a92454cf0','[\"*\"]',NULL,NULL,'2024-05-22 14:18:54','2024-05-22 14:18:54'),
(2,'App\\Models\\User',1,'MyApp','3d7afdc4f43bc7fa9025ccc85d37712da3271845ae4b517723cb93c0e56d09c9','[\"*\"]',NULL,NULL,'2024-05-22 14:19:17','2024-05-22 14:19:17'),
(3,'App\\Models\\User',1,'MyApp','78f1e6e9eeca4e573a2b346352cef31b2f2f16f2fa46312a4f756ce125659dca','[\"*\"]',NULL,NULL,'2024-05-22 14:19:38','2024-05-22 14:19:38'),
(4,'App\\Models\\User',1,'MyApp','ea305d685481b17bc9ecaa4dcd660f505ae7a7737b4a80bb22ecd67305e9f977','[\"*\"]',NULL,NULL,'2024-05-22 14:21:28','2024-05-22 14:21:28'),
(5,'App\\Models\\User',1,'MyApp','02cb192cd7bbb294b59ceae3ace5440f5ab6c8c87fde390617495d9ef7a57317','[\"*\"]',NULL,NULL,'2024-05-22 14:22:51','2024-05-22 14:22:51'),
(6,'App\\Models\\User',1,'MyApp','e7e70eb1988e3a2974d06dc12ef9ffe69d78b23f9bcccd6908c56c2f118f3418','[\"*\"]',NULL,NULL,'2024-05-22 14:27:22','2024-05-22 14:27:22'),
(7,'App\\Models\\User',1,'MyApp','ebc7b0de0a94611cc2cb3d1432912eb2c7af16425b8c6741f9e99d705d95df05','[\"*\"]',NULL,NULL,'2024-05-22 14:28:37','2024-05-22 14:28:37'),
(8,'App\\Models\\User',1,'MyApp','96bb17ea3f97e35cfa768b998b961fc2306507cfb789451b836c677d5a4e71ff','[\"*\"]',NULL,NULL,'2024-05-22 14:56:05','2024-05-22 14:56:05'),
(9,'App\\Models\\User',1,'MyApp','09af0a92507ad657eecd59d456f0ca4b5ce76ee4f28567906e40392ee7bb0042','[\"*\"]',NULL,NULL,'2024-05-22 19:09:02','2024-05-22 19:09:02'),
(10,'App\\Models\\User',1,'MyApp','7950f08fad62877e82ce5162e65416c6113c69f84920194f2f748397885ff59c','[\"*\"]',NULL,NULL,'2024-05-22 20:16:43','2024-05-22 20:16:43'),
(11,'App\\Models\\User',1,'MyApp','7c790730af52ae8bee43318b8b29bab6a968d245f66b2efda6a2054d7aea6425','[\"*\"]',NULL,NULL,'2024-05-22 20:17:36','2024-05-22 20:17:36'),
(12,'App\\Models\\User',1,'api_token','5928125d259701b519786b8433068aabe4190bd94076add0c8ea8fb117b69860','[\"*\"]',NULL,NULL,'2024-05-23 09:19:14','2024-05-23 09:19:14'),
(13,'App\\Models\\User',1,'api_token','d29aba4b2cb2f93896577ef27973b468ba737994112404fe650bf08023a1e56f','[\"*\"]',NULL,NULL,'2024-05-23 11:02:42','2024-05-23 11:02:42'),
(14,'App\\Models\\User',2,'api_token','77960149878416ddc68a9988e00f5433af7980111b486b4e6deef24e28ad97a4','[\"*\"]',NULL,NULL,'2024-05-23 11:16:46','2024-05-23 11:16:46'),
(15,'App\\Models\\User',1,'api_token','771e10943806c92407da38b24b3b65e878523ee47705913750e30ab2aedc13c4','[\"*\"]',NULL,NULL,'2024-05-23 11:20:34','2024-05-23 11:20:34'),
(16,'App\\Models\\User',2,'api_token','126c0f36bd1bbe3d3b49eeef2c5c004b7f7dc2864016549e0c6d78886b460621','[\"*\"]',NULL,NULL,'2024-05-23 11:23:20','2024-05-23 11:23:20'),
(17,'App\\Models\\User',1,'api_token','b39052fd47ac21abc717b1b13e965abe887e88c884d15d17ba367158116c9b3d','[\"*\"]',NULL,NULL,'2024-05-23 11:29:59','2024-05-23 11:29:59'),
(18,'App\\Models\\User',1,'api_token','945d3d725ceed6d2aaffd4edbdca35a6b667af449898a59a4894daf6e0b2d035','[\"*\"]',NULL,NULL,'2024-05-23 11:32:15','2024-05-23 11:32:15'),
(19,'App\\Models\\User',2,'api_token','967beb8ffe0bc577ab7435ae6be4fb0f2b7f786d3f772c1ee66aec6a72753559','[\"*\"]',NULL,NULL,'2024-05-23 11:32:59','2024-05-23 11:32:59'),
(20,'App\\Models\\User',1,'api_token','b6265720e10dd920153a9761e477b7fb3afebf82825642c25ee9d7bbe1333ecf','[\"*\"]',NULL,NULL,'2024-05-23 11:33:46','2024-05-23 11:33:46'),
(21,'App\\Models\\User',2,'api_token','de14e355136892642c3a1c7754eb4604bfa5aff8085b219e23e6df5615cac3a9','[\"*\"]',NULL,NULL,'2024-05-23 11:33:59','2024-05-23 11:33:59'),
(22,'App\\Models\\User',1,'api_token','53d2649d1d6f98f958ebc9636639dfecce031b99d5da155acc37f7029ca36a99','[\"*\"]',NULL,NULL,'2024-05-23 12:20:06','2024-05-23 12:20:06'),
(23,'App\\Models\\User',1,'api_token','668a7d909853098396829c47886bec8bfbfe4061aec2938cb78a8963d3f83e43','[\"*\"]',NULL,NULL,'2024-05-23 12:23:24','2024-05-23 12:23:24'),
(24,'App\\Models\\User',1,'api_token','98456d577deb0d9541fee2ed128f7a4c32f3438c7af295b0979adf04a7c3aa8d','[\"*\"]',NULL,NULL,'2024-05-23 12:42:36','2024-05-23 12:42:36'),
(25,'App\\Models\\User',2,'api_token','4b4e0109ed01e7fcaaaf564cd5b342b256d405a0dfaf6a01e4782d5b74c77b90','[\"*\"]',NULL,NULL,'2024-05-23 12:43:22','2024-05-23 12:43:22'),
(26,'App\\Models\\User',1,'api_token','4ea9122933cdac137e7bd3b4dec1966c500ebfa8682b45245f6cfe3337afc088','[\"*\"]',NULL,NULL,'2024-05-23 14:49:24','2024-05-23 14:49:24'),
(27,'App\\Models\\User',2,'api_token','2c4cf9a194fd4a9d0e7416a839117cccd3e76e1843d0c7d34ae5dd7347072f5f','[\"*\"]',NULL,NULL,'2024-05-23 14:52:47','2024-05-23 14:52:47'),
(28,'App\\Models\\User',1,'api_token','4c36f718e2bc1d494e0e720d3715f0d09d07a5a6f6f532abb9c9f04c35ac180a','[\"*\"]',NULL,NULL,'2024-05-23 14:57:54','2024-05-23 14:57:54'),
(29,'App\\Models\\User',2,'api_token','92807838987fd6918b5827174640682412b7e8453a2aaad2801a88d6c60edaa8','[\"*\"]',NULL,NULL,'2024-05-23 15:00:32','2024-05-23 15:00:32');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `due_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`title`,`description`,`due_date`,`status`,`created_at`,`updated_at`) values 
(14,'Fuga Mollitia ut qu','Maiores esse possimu','2002-01-15',1,'2024-05-23 14:58:13','2024-05-23 14:59:22'),
(15,'Quam reprehenderit v','Occaecat optio moll','2022-12-06',1,'2024-05-23 14:58:19','2024-05-23 14:59:25');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `roles` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`roles`,`remember_token`,`created_at`,`updated_at`) values 
(1,'Admin User','admin@example.com',NULL,'$2y$12$yFeG.MJjUgQdwgay2EOlwOgeXUQzkgi7brzl.UOQG/ltKdZnvti5i','admin','WG4igLZkV4',NULL,NULL),
(2,'Regular User','user@example.com',NULL,'$2y$12$2xQwT8jIdFW0O5F5/wVx8eSyVHn.xU8HdJ4Q0Uis77sYdB7lH2/am','user','ewaUvko9P8',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
