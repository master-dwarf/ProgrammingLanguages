CREATE TABLE IF NOT EXISTS `hilgeg46`.`application` (
    `application_number` INT NOT NULL,
    `date_received` VARCHAR(45) NOT NULL,
    `completed` VARCHAR(45) NOT NULL,
    `fee_received_date` VARCHAR(45) NULL,
    PRIMARY KEY (`application_number`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`major` (
    `major_ID` INT NOT NULL,
    `major_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`major_ID`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`minor` (
    `minor_ID` INT NOT NULL,
    `minor_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`minor_ID`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`institutes` (
    `institute_ID` INT NOT NULL,
    `institue_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`institute_ID`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`term` (
    `term_ID` INT NOT NULL,
    `term_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`term_ID`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`adviser` (
    `email` VARCHAR(45) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `street_address` VARCHAR(45) NOT NULL,
    `city` VARCHAR(45) NOT NULL,
    `zip_code` VARCHAR(45) NOT NULL,
    `state` VARCHAR(45) NOT NULL,
    `position` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`email`)
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`course` (
    `course_ID` INT NOT NULL,
    `Institute_ID` INT NOT NULL,
    `course_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`course_ID`),
    INDEX `institue_ID_idx` (`Institute_ID` ASC),
    CONSTRAINT `institue_ID` FOREIGN KEY (`Institute_ID`)
        REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_names` (
    `email` VARCHAR(45) NOT NULL,
    `application_number` INT NOT NULL,
    `first_name` VARCHAR(45) NOT NULL,
    `middle_name` VARCHAR(45) NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `gender` VARCHAR(45) NOT NULL,
    `date_of_birth` VARCHAR(45) NOT NULL,
    `major_id` INT NOT NULL,
    `minor_id` INT NOT NULL,
    `citizenship` VARCHAR(45) NOT NULL,
    `sending_institute_id` INT NOT NULL,
    `receiving_institute_id` INT NOT NULL,
    `term_id` INT NOT NULL,
    `year` VARCHAR(45) NOT NULL,
    `student_namescol` VARCHAR(45) NOT NULL,
    `birth_city` VARCHAR(45) NOT NULL,
    `birth_country` VARCHAR(45) NOT NULL,
    `undergrad_or_grad` VARCHAR(45) NOT NULL,
    `year_in_school` VARCHAR(45) NOT NULL,
    `semesters_completed` INT NOT NULL,
    `major_coursework` VARCHAR(45) NOT NULL,
    `minor_coursework` VARCHAR(45) NOT NULL,
    `level_cousework` VARCHAR(45) NOT NULL,
    `undergrad_FTE` VARCHAR(45) NOT NULL,
    `UG_FTE_withdrawl` VARCHAR(45) NOT NULL,
    `G_FTE_withdrawl` VARCHAR(45) NOT NULL,
    `notes` BLOB NULL,
    PRIMARY KEY (`email`),
    FOREIGN KEY (`major_id`)
        REFERENCES `hilgeg46`.`major` (`major_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (`minor_id`)
        REFERENCES `hilgeg46`.`minor` (`minor_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`term_id`)
        REFERENCES `hilgeg46`.`term` (`term_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`application_number`)
        REFERENCES `hilgeg46`.`application` (`application_number`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`sending_institute_id`)
        REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (`receiving_institute_id`)
        REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;