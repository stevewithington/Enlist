CREATE SCHEMA IF NOT EXISTS enlist;

SET SCHEMA enlist;

CREATE TABLE IF NOT EXISTS `setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `defaultPointValue` int(11) DEFAULT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `orgDesc` text,
  `orgAddress` varchar(100) DEFAULT NULL,
  `sendEmail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `chapter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `location` varchar(100) DEFAULT NULL,
  `statusCode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `event` (
  `id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `location` VARCHAR(100) NULL ,
  `status` VARCHAR(50) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) DEFAULT NULL,
  `description` VARCHAR(1000) DEFAULT NULL,
  `numPeople` INT(11) DEFAULT NULL,
  `startDate` DATETIME DEFAULT NULL,
  `endDate` DATETIME DEFAULT NULL,
  `pointHours` NUMERIC(10,2) DEFAULT NULL,
  `location` VARCHAR(255) DEFAULT NULL,
  `eventId` INT(11) DEFAULT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(50) DEFAULT NULL,
  `role` VARCHAR(50) DEFAULT NULL,
  `chapterId` INT(11) DEFAULT NULL,
  `firstName` VARCHAR(50) DEFAULT NULL,
  `lastName` VARCHAR(50) DEFAULT NULL,
  `altEmail` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(50) DEFAULT NULL,
  `address1` VARCHAR(50) DEFAULT NULL,
  `address2` VARCHAR(50) DEFAULT NULL,
  `city` VARCHAR(50) DEFAULT NULL,
  `state` VARCHAR(50) DEFAULT NULL,
  `zip` VARCHAR(50) DEFAULT NULL,
  `importHashCode` VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
