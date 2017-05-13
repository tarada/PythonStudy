-- 创建数据库university
CREATE SCHEMA `university` DEFAULT CHARACTER SET utf8 ;

-- 在university数据库里建department表
CREATE TABLE `university`.`department` (
  `dept_name` VARCHAR(45) NOT NULL,
  `building` VARCHAR(45) NULL,
  `budget` INT NULL,
  PRIMARY KEY (`dept_name`));

-- 在university数据库里建立student表  
CREATE TABLE `university`.`student` (
  `ID` INT(10) NOT NULL,
  `name` VARCHAR(45) NULL,
  `sex` CHAR(1) NULL,
  `age` INT(3) NULL,
  `emotion_state` VARCHAR(45) NULL,
  `dept_name` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`));

-- 在university数据表里建立exam表  
  CREATE TABLE `university`.`exam` (
  `student_ID` INT(10) NOT NULL,
  `exam_name` VARCHAR(45) NULL,
  `grade` INT(3) UNSIGNED NULL,
  PRIMARY KEY (`student_ID`));
ALTER TABLE `university`.`exam` 
CHANGE COLUMN `exam_name` `exam_name` VARCHAR(45) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`student_ID`, `exam_name`);

-- 以department为参考对象，给student建立外键dept_name
ALTER TABLE `university`.`student` 
ADD INDEX `fk_student_1_idx` (`dept_name` ASC);
ALTER TABLE `university`.`student` 
ADD CONSTRAINT `fk_student_1`
  FOREIGN KEY (`dept_name`)
  REFERENCES `university`.`department` (`dept_name`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
-- 以student为参考对象，给exam建立外键ID
ALTER TABLE `university`.`exam` 
ADD CONSTRAINT `fk_exam_1`
  FOREIGN KEY (`student_ID`)
  REFERENCES `university`.`student` (`ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


