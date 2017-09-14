-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 14, 2017 at 03:47 PM
-- Server version: 5.5.52-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `viwiki`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `name`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Kiểm thử hộp đen', 7, '2017-06-27 00:09:44', '2017-06-27 00:09:44'),
(2, 'Kiểm thử hộp trắng', 7, '2017-06-27 00:09:44', '2017-06-27 00:09:44'),
(3, 'Alloy', 8, '2017-06-27 00:09:44', '2017-06-27 00:09:44'),
(4, 'SMT Solver', 8, '2017-06-27 00:09:44', '2017-06-27 00:09:44'),
(5, 'Mô hình OSI', 6, '2017-06-27 00:09:44', '2017-06-27 00:09:44'),
(6, 'TCP/IP', 6, '2017-06-27 00:09:44', '2017-06-27 00:09:44');

-- --------------------------------------------------------

--
-- Table structure for table `ar_internal_metadata`
--

CREATE TABLE IF NOT EXISTS `ar_internal_metadata` (
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ar_internal_metadata`
--

INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`) VALUES
('environment', 'development', '2017-06-26 17:01:25', '2017-06-26 17:07:50');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `depth` int(11) NOT NULL DEFAULT '0',
  `children_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent_id`, `lft`, `rgt`, `depth`, `children_count`, `created_at`, `updated_at`) VALUES
(1, 'Công nghệ thông tin', NULL, 1, 14, 0, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(2, 'Toán học', NULL, 15, 16, 0, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(3, 'Vật lý', NULL, 17, 18, 0, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(4, 'Công nghệ phần mềm', 1, 2, 9, 1, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(5, 'Khoa học máy tính', 1, 10, 11, 1, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(6, 'Mạng máy tính', 1, 12, 13, 1, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(7, 'Kiểm thử', 4, 3, 6, 2, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(8, 'Phương pháp hình thức', 4, 7, 8, 2, 0, '2017-06-26 17:09:44', '2017-06-29 10:09:48'),
(9, 'Tên chuyên mục', 7, 4, 5, 3, 0, '2017-06-29 10:09:48', '2017-06-29 10:09:48');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `resource_type`, `resource_id`, `created_at`, `updated_at`) VALUES
(1, 'admin', NULL, NULL, '2016-11-26 04:10:33', '2016-11-26 04:10:33'),
(2, 'editor', 'Category', 4, '2016-11-28 04:26:32', '2016-11-28 04:26:32'),
(3, 'editor', 'Category', 7, '2016-11-28 07:24:01', '2016-11-28 07:24:01');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20161122041421'),
('20161122042317'),
('20161124043509'),
('20161125185537');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
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
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `created_at`, `updated_at`) VALUES
(2, 'baongoc124@gmail.com', '$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W', NULL, NULL, '2017-06-26 23:46:52', 15, '2017-07-02 03:49:18', '2017-06-29 10:08:53', '113.189.80.230', '113.190.112.143', 'WpEbbK968CLHZwDedLTr', '2016-11-25 03:29:38', '2016-11-25 03:29:30', NULL, '2016-11-25 03:29:30', '2017-07-02 03:49:18'),
(3, 'test1@t.com', '$2a$11$jUUUhfxvh0oM3SyCZpZ.w.uOQe6PAAYsvDir4/UUcowJj07GAfJdm', NULL, NULL, NULL, 1, '2016-11-25 10:41:23', '2016-11-25 10:41:23', '::1', '::1', '7t4m-euH7DUt7GWQJVZF', '2016-11-25 10:41:01', '2016-11-25 10:40:55', NULL, '2016-11-25 10:40:55', '2016-11-25 10:41:51'),
(4, 'jazmyn@muellermcdermott.co', '$2a$11$V2wplnoFzCLjruHhLVVjeewiAXMwRXoYePlJ7V0hv6BZ0mTLB8P9a', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 'J6HLabsJGnqDiLWs_KBd', NULL, '2016-11-28 04:44:24', NULL, '2016-11-28 04:44:24', '2016-11-28 04:44:24'),
(5, 'hilbert@ziemannsauer.com', '$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W', NULL, NULL, NULL, 2, '2016-11-28 08:17:19', '2016-11-28 07:25:19', '::1', '::1', 'MHcWNZxpzUy37ammDCAu', '2016-11-28 07:22:56', '2016-11-28 07:22:47', NULL, '2016-11-28 07:22:47', '2016-11-28 08:17:19'),
(6, 'test1@gmail.com', '$2a$11$uTnQ03kmvnpF5sA.W2idXuBaYOW1YMuf3qtP1QFVV1DNC5mn8fpYm', NULL, NULL, NULL, 1, '2016-11-28 10:51:56', '2016-11-28 10:51:56', '::1', '::1', '51LDpzXsAZuCBNyjvUvZ', '2016-11-28 10:51:44', '2016-11-28 10:51:41', NULL, '2016-11-28 10:51:41', '2016-11-28 10:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE IF NOT EXISTS `users_roles` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(2, 1),
(2, 2),
(5, 2),
(5, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_articles_on_category_id` (`category_id`);

--
-- Indexes for table `ar_internal_metadata`
--
ALTER TABLE `ar_internal_metadata`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_categories_on_parent_id` (`parent_id`),
  ADD KEY `index_categories_on_lft` (`lft`),
  ADD KEY `index_categories_on_rgt` (`rgt`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_roles_on_name` (`name`),
  ADD KEY `index_roles_on_name_and_resource_type_and_resource_id` (`name`,`resource_type`,`resource_id`);

--
-- Indexes for table `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_users_on_email` (`email`),
  ADD UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  ADD UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `index_users_roles_on_user_id_and_role_id` (`user_id`,`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
