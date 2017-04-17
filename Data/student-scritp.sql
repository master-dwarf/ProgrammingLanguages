CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_adviser` (
    `student_email` VARCHAR(45) NOT NULL,
    `adviser_email` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`adviser_email`) REFERENCES `hilgeg46`.`adviser` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_emergency_contact` (
    `student_email` VARCHAR(45) NOT NULL,
    `email` VARCHAR(45) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `phone_number` varchar(45) not null,
    `relation_to_student` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`student_email`,`email`),
	FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_backup_email` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `backup_email` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_cellphone` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `cell_phone` VARCHAR(45) NOT NULL,
	FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_homephone` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `home_phone` VARCHAR(45) NOT NULL,
	FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_visited_country` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `visited_before` VARCHAR(45) NOT NULL,
    `purpose_for_visit` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`reference` (
    `name` VARCHAR(45) NOT NULL,
    `possition` VARCHAR(45) NOT NULL,
    `department` VARCHAR(45) NOT NULL,
    `institue_works_at` INT NOT NULL,
    `years_know_applicant` INT NOT NULL,
    `how_do_you_know` VARCHAR(45) NOT NULL,
    `accedemic_performance` VARCHAR(45) NOT NULL,
    `rank_among_students` INT NOT NULL,
    `quality_of_grades` VARCHAR(45) NOT NULL,
    `suitable_for_program` BINARY(1) NOT NULL,
    `student_email` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`institue_works_at`) REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_knowledge_of_language` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `years_in_hs` INT NOT NULL,
    `years_at_university` VARCHAR(45) NOT NULL,
    `higest_level_of_language` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_requests_courses` (
    `course_id_1` INT NOT NULL,
    `course_id_2` INT NOT NULL,
    `course_id_3` INT NOT NULL,
    `course_id_4` INT NOT NULL,
    `course_id_5` INT NOT NULL,
    `course_id_6` INT NOT NULL,
    `course_id_7` INT NOT NULL,
    `course_id_8` INT NOT NULL,
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_1`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_2`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_3`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_4`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_5`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_6`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_7`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`course_id_8`) REFERENCES `hilgeg46`.`course` (`course_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_choice_of_schools` (
    `students_email` VARCHAR(45) NOT NULL primary key,
    `institute_id_1` INT NOT NULL,
    `institute_id_2` INT NOT NULL,
    `institute_id_3` INT NOT NULL,
    `institute_id_4` INT NOT NULL,
    FOREIGN KEY (`students_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`institute_id_1`) REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`institute_id_2`) REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`institute_id_3`) REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`institute_id_4`) REFERENCES `hilgeg46`.`institutes` (`institute_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_semester_address` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `street_address` VARCHAR(45) NOT NULL,
    `city` VARCHAR(45) NOT NULL,
    `zip_code` INT NOT NULL,
    `country` VARCHAR(45) NOT NULL,
    `valid_until` VARCHAR(45) NOT NULL,
    FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
CREATE TABLE IF NOT EXISTS `hilgeg46`.`student_has_permanent_address` (
    `student_email` VARCHAR(45) NOT NULL PRIMARY KEY,
    `street_address` VARCHAR(45) NOT NULL,
    `city` VARCHAR(45) NOT NULL,
    `zip_code` INT NOT NULL,
    `country` VARCHAR(45) NOT NULL,
	FOREIGN KEY (`student_email`) REFERENCES `hilgeg46`.`student_names` (`email`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;