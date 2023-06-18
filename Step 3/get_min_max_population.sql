DELIMITER //
CREATE PROCEDURE `get_min_max_population` (IN iso_ CHAR(8))
BEGIN
	SELECT MIN(population) AS min_population, MAX(population) AS max_population
    FROM population
    WHERE iso = iso_;
END //
DELIMITER ;