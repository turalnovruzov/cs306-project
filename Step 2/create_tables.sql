CREATE TABLE `cs306_project`.`country` (
    `iso` CHAR(8) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`iso`));

CREATE TABLE `cs306_project`.`population` (
	`year` INT NOT NULL,
	`population` INT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);

CREATE TABLE `cs306_project`.`inequality_in_life` (
	`year` INT NOT NULL,
	`inequality` FLOAT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);

CREATE TABLE `cs306_project`.`health_expenditure` (
	`year` INT NOT NULL,
	`expenditure` FLOAT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);

CREATE TABLE `cs306_project`.`life_expectancy_all` (
	`year` INT NOT NULL,
	`le` FLOAT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);

CREATE TABLE `cs306_project`.`life_expectancy_gender` (
	`year` INT NOT NULL,
	`le_male` FLOAT NOT NULL,
	`le_female` FLOAT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);

CREATE TABLE `cs306_project`.`survival_to_65` (
	`year` INT NOT NULL,
	`survival_male` FLOAT NOT NULL,
	`survival_female` FLOAT NOT NULL,
	`iso` CHAR(8) NOT NULL,
	PRIMARY KEY (`year`, `iso`),
	FOREIGN KEY (`iso`)
	REFERENCES `cs306_project`.`country` (`iso`)
	ON DELETE CASCADE);
