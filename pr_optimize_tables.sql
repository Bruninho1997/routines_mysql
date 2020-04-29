DROP PROCEDURE IF EXISTS pr_optimize_tables;
DELIMITER $

CREATE PROCEDURE pr_optimize_tables()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE NomeTabela VARCHAR(80);
  DECLARE cur1 CURSOR FOR SELECT DISTINCT TABLE_NAME FROM
    information_schema.tables
    WHERE TABLE_SCHEMA = 'nome_database'
    AND TABLE_TYPE = 'BASE TABLE';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

    read_loop: LOOP

      IF done THEN
    			LEAVE read_loop;
  		ELSE

          IF (NomeTabela IS NOT NULL) THEN

            SET @Script = CONCAT('OPTIMIZE TABLE ', NomeTabela, ';');

            PREPARE otimizador FROM @Script;
          	EXECUTE otimizador;

          END IF;
      END IF;
      FETCH cur1 INTO NomeTabela;

    END LOOP;

  CLOSE cur1;

END $
