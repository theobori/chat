DROP DATABASE IF EXISTS `chatdb`;

CREATE DATABASE `chatdb`;
USE `chatdb`;

DROP TABLE IF EXISTS `user`;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME ON UPDATE CURRENT_TIMESTAMP DEFAULT NOW() NOT NULL,

  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) AUTO_INCREMENT=1, CHARACTER SET ascii COLLATE ascii_general_ci;

CREATE TABLE IF NOT EXISTS `channel` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL UNIQUE,
	`description` TEXT NOT NULL,
	`created_at` DATETIME ON UPDATE CURRENT_TIMESTAMP DEFAULT NOW() NOT NULL,
	`protected` INT UNSIGNED DEFAULT 0,
  `password` VARCHAR(100),
  `owner` INT UNSIGNED NOT NULL,

  PRIMARY KEY (`id`),
	FOREIGN KEY (`owner`) REFERENCES `user`(`id`) ON DELETE CASCADE
) AUTO_INCREMENT=2, CHARACTER SET ascii COLLATE ascii_general_ci;