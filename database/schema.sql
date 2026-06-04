-- schema.sql - Структура базы данных Guide Advisor
-- Создание базы данных и всех таблиц

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Создание базы данных (если не существует)
-- --------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `guideadvisor`;
USE `guideadvisor`;

-- --------------------------------------------------------
-- Таблица пользователей
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `role` enum('ADM','GUI','TUR') DEFAULT 'TUR',
  `status` enum('ACT','BLK','PEN') DEFAULT 'ACT',
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `photo_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица гидов
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `guides` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `experience_years` int DEFAULT '0',
  `description` text,
  `rating` decimal(2,1) DEFAULT '0.0',
  `photo_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица экскурсий
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `excursions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guide_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `category` varchar(50) DEFAULT NULL,
  `max_participants` int DEFAULT '10',
  `duration_hours` int DEFAULT '2',
  `status` enum('PUB','HID','ARC') DEFAULT 'PUB',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `photo_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`guide_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица расписаний
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `excursion_id` int NOT NULL,
  `start_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`excursion_id`) REFERENCES `excursions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица бронирований
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tourist_id` int NOT NULL,
  `schedule_id` int NOT NULL,
  `participants_count` int DEFAULT '1',
  `status` enum('PEND','CONF','CANC','COM') DEFAULT 'PEND',
  `booked_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`tourist_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица отзывов
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `excursion_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int DEFAULT '5',
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`excursion_id`) REFERENCES `excursions` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица уведомлений
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` enum('INFO','BOOKING','REMINDER','PROMO') DEFAULT 'INFO',
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица активности пользователей
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `excursion_id` int DEFAULT NULL,
  `action_type` enum('VIEW','BOOK','REVIEW','CANCEL') DEFAULT 'VIEW',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- Таблица предпочтений пользователей
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `favorite_categories` text,
  `notification_enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

COMMIT;

-- --------------------------------------------------------
-- Сообщение об успешном создании
-- --------------------------------------------------------

SELECT 'База данных guideadvisor и все таблицы успешно созданы!' AS 'Status';