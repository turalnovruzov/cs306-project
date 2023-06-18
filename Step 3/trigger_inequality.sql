DELIMITER //
CREATE TRIGGER inequality_in_life_before_insert 
BEFORE INSERT ON cs306_project.inequality_in_life 
FOR EACH ROW
BEGIN
    IF NEW.inequality < 0 THEN
        SET NEW.inequality = 0;
    ELSEIF NEW.inequality > 100 THEN
        SET NEW.inequality = 100;
    END IF;
END //

CREATE TRIGGER inequality_in_life_before_UPDATE 
BEFORE UPDATE ON cs306_project.inequality_in_life 
FOR EACH ROW
BEGIN
    IF NEW.inequality < 0 THEN
        SET NEW.inequality = 0;
    ELSEIF NEW.inequality > 100 THEN
        SET NEW.inequality = 100;
    END IF;
END //
DELIMITER ;