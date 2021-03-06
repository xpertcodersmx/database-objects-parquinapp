-- MySQL Script generated by MySQL Workbench
-- Wed Jun 22 08:40:31 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema u551714784_appparkin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema u551714784_appparkin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `u551714784_appparkin` DEFAULT CHARACTER SET utf8 ;
USE `u551714784_appparkin` ;

-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PROFILES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PROFILES` (
  `profile` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`profile`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`USERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`USERS` (
  `uid` VARCHAR(45) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `profile` VARCHAR(10) NOT NULL,
  `recordDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  INDEX `fk_USERS_PROFILES_idx` (`profile` ASC),
  CONSTRAINT `fk_USERS_PROFILES`
    FOREIGN KEY (`profile`)
    REFERENCES `u551714784_appparkin`.`PROFILES` (`profile`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`STATUS` (
  `status` VARCHAR(4) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`TYPE_OF_PARKINGS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`TYPE_OF_PARKINGS` (
  `typeOfParking` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`typeOfParking`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PARKINGS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PARKINGS` (
  `idParking` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(4) NOT NULL,
  `dueDate` TIMESTAMP NOT NULL,
  `owner` VARCHAR(45) NOT NULL,
  `typeOfParking` VARCHAR(20) NOT NULL,
  `moreDetails` TINYINT(1) NOT NULL DEFAULT 0,
  `timeZone` INT NOT NULL DEFAULT -5,
  `recordDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idParking`),
  INDEX `fk_PARKINGS_STATUS1_idx` (`status` ASC),
  INDEX `fk_PARKINGS_USERS1_idx` (`owner` ASC),
  INDEX `fk_PARKINGS_TYPE_OF_PARKINGS1_idx` (`typeOfParking` ASC),
  CONSTRAINT `fk_PARKINGS_STATUS1`
    FOREIGN KEY (`status`)
    REFERENCES `u551714784_appparkin`.`STATUS` (`status`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PARKINGS_USERS1`
    FOREIGN KEY (`owner`)
    REFERENCES `u551714784_appparkin`.`USERS` (`uid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PARKINGS_TYPE_OF_PARKINGS1`
    FOREIGN KEY (`typeOfParking`)
    REFERENCES `u551714784_appparkin`.`TYPE_OF_PARKINGS` (`typeOfParking`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`IMAGES`
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`IMAGES` (
-- )
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`COORDINATES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`COORDINATES` (
  `idCoordinate` INT NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(18,15) NOT NULL,
  `longitude` DECIMAL(18,15) NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCoordinate`),
  CONSTRAINT `fk_COORDINATES_PARKINGS1`
    FOREIGN KEY (`idCoordinate`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`ADDRESSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`ADDRESSES` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `line1` VARCHAR(45) NOT NULL,
  `line2` VARCHAR(45) NULL,
  `neighborhood` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(6) NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAddress`),
  CONSTRAINT `fk_ADDRESSES_PARKINGS1`
    FOREIGN KEY (`idAddress`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PRICES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PRICES` (
  `idPrice` INT NOT NULL AUTO_INCREMENT,
  `isFixed` TINYINT(1) NOT NULL DEFAULT 0,
  `hasDifferentFees` TINYINT(1) NOT NULL DEFAULT 0,
  `price` DECIMAL NOT NULL DEFAULT 0,
  `periodDuration` INT NOT NULL DEFAULT 0,
  `minutesTolerance` INT NOT NULL DEFAULT 0,
  `minutesToleranceAfterPay` INT NOT NULL DEFAULT 0,
  `recordDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPrice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`TICKETS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`TICKETS` (
  `idTicket` INT NOT NULL AUTO_INCREMENT,
  `idParking` INT NOT NULL,
  `arrivalDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `departureDate` TIMESTAMP NULL,
  `plate` VARCHAR(10) NOT NULL,
  `color` VARCHAR(15) NULL,
  `brand` VARCHAR(15) NULL,
  `model` VARCHAR(20) NULL,
  `idPrice` INT NOT NULL,
  `total` DECIMAL NOT NULL DEFAULT 0,
  PRIMARY KEY (`idTicket`),
  INDEX `fk_TICKETS_PRICES1_idx` (`idPrice` ASC),
  INDEX `fk_TICKETS_PARKINGS1_idx` (`idParking` ASC),
  CONSTRAINT `fk_TICKETS_PRICES1`
    FOREIGN KEY (`idPrice`)
    REFERENCES `u551714784_appparkin`.`PRICES` (`idPrice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TICKETS_PARKINGS1`
    FOREIGN KEY (`idParking`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`DAYS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`DAYS` (
  `idDay` INT NOT NULL,
  `shorDay` VARCHAR(3) NOT NULL,
  `day` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idDay`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`SCHEDULES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`SCHEDULES` (
  `idSchedule` INT NOT NULL AUTO_INCREMENT,
  `openingTime` TIME NOT NULL,
  `closingTime` TIME NOT NULL,
  `idDay` INT NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSchedule`),
  INDEX `fk_SCHEDULES_DAYS1_idx` (`idDay` ASC),
  CONSTRAINT `fk_SCHEDULES_DAYS1`
    FOREIGN KEY (`idDay`)
    REFERENCES `u551714784_appparkin`.`DAYS` (`idDay`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PARKINGS_has_PRICES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PARKINGS_has_PRICES` (
  `idParking` INT NOT NULL,
  `idPrice` INT NOT NULL,
  PRIMARY KEY (`idParking`, `idPrice`),
  INDEX `fk_PARKINGS_has_PRICES_PRICES1_idx` (`idPrice` ASC),
  INDEX `fk_PARKINGS_has_PRICES_PARKINGS1_idx` (`idParking` ASC),
  CONSTRAINT `fk_PARKINGS_has_PRICES_PARKINGS1`
    FOREIGN KEY (`idParking`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PARKINGS_has_PRICES_PRICES1`
    FOREIGN KEY (`idPrice`)
    REFERENCES `u551714784_appparkin`.`PRICES` (`idPrice`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PARKINGS_has_SCHEDULES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PARKINGS_has_SCHEDULES` (
  `idParking` INT NOT NULL,
  `idSchedule` INT NOT NULL,
  PRIMARY KEY (`idParking`, `idSchedule`),
  INDEX `fk_PARKINGS_has_SCHEDULES_SCHEDULES1_idx` (`idSchedule` ASC),
  INDEX `fk_PARKINGS_has_SCHEDULES_PARKINGS1_idx` (`idParking` ASC),
  CONSTRAINT `fk_PARKINGS_has_SCHEDULES_PARKINGS1`
    FOREIGN KEY (`idParking`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PARKINGS_has_SCHEDULES_SCHEDULES1`
    FOREIGN KEY (`idSchedule`)
    REFERENCES `u551714784_appparkin`.`SCHEDULES` (`idSchedule`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`STAFF` (
  `idParking` INT NOT NULL,
  `uid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idParking`, `uid`),
  INDEX `fk_PARKINGS_has_USERS_USERS1_idx` (`uid` ASC),
  INDEX `fk_PARKINGS_has_USERS_PARKINGS1_idx` (`idParking` ASC),
  CONSTRAINT `fk_PARKINGS_has_USERS_PARKINGS1`
    FOREIGN KEY (`idParking`)
    REFERENCES `u551714784_appparkin`.`PARKINGS` (`idParking`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PARKINGS_has_USERS_USERS1`
    FOREIGN KEY (`uid`)
    REFERENCES `u551714784_appparkin`.`USERS` (`uid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PROVIDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PROVIDERS` (
  `idProvider` INT NOT NULL AUTO_INCREMENT,
  `provider` VARCHAR(15) NULL,
  PRIMARY KEY (`idProvider`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`USERS_has_PROVIDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`USERS_has_PROVIDERS` (
  `uid` VARCHAR(45) NOT NULL,
  `idProvider` INT NOT NULL,
  PRIMARY KEY (`uid`, `idProvider`),
  INDEX `fk_USERS_has_PROVIDERS_PROVIDERS1_idx` (`idProvider` ASC),
  INDEX `fk_USERS_has_PROVIDERS_USERS1_idx` (`uid` ASC),
  CONSTRAINT `fk_USERS_has_PROVIDERS_USERS1`
    FOREIGN KEY (`uid`)
    REFERENCES `u551714784_appparkin`.`USERS` (`uid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USERS_has_PROVIDERS_PROVIDERS1`
    FOREIGN KEY (`idProvider`)
    REFERENCES `u551714784_appparkin`.`PROVIDERS` (`idProvider`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`FEES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`FEES` (
  `idFee` INT NOT NULL AUTO_INCREMENT,
  `order` INT NOT NULL,
  `periodDuration` INT NOT NULL DEFAULT 0,
  `price` DECIMAL NOT NULL DEFAULT 0,
  PRIMARY KEY (`idFee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u551714784_appparkin`.`PRICES_has_FEES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `u551714784_appparkin`.`PRICES_has_FEES` (
  `idPrice` INT NOT NULL,
  `idFee` INT NOT NULL,
  PRIMARY KEY (`idPrice`, `idFee`),
  INDEX `fk_PRICES_has_FEES_FEES1_idx` (`idFee` ASC),
  INDEX `fk_PRICES_has_FEES_PRICES1_idx` (`idPrice` ASC),
  CONSTRAINT `fk_PRICES_has_FEES_PRICES1`
    FOREIGN KEY (`idPrice`)
    REFERENCES `u551714784_appparkin`.`PRICES` (`idPrice`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PRICES_has_FEES_FEES1`
    FOREIGN KEY (`idFee`)
    REFERENCES `u551714784_appparkin`.`FEES` (`idFee`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
