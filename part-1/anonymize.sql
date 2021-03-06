
DROP FUNCTION IF EXISTS `shuffle`;

DELIMITER $$
CREATE FUNCTION shuffle(
    v_chars TEXT
)
RETURNS TEXT
NOT DETERMINISTIC
NO SQL
SQL SECURITY INVOKER
COMMENT 'Shuffle an input string'
BEGIN
    DECLARE v_retval TEXT DEFAULT '';
    DECLARE u_pos    INT UNSIGNED;
    DECLARE u        INT UNSIGNED;

    SET u = LENGTH(v_chars);
    WHILE u > 0
    DO
      SET u_pos = 1 + FLOOR(RAND() * u);
      SET v_retval = CONCAT(v_retval, MID(v_chars, u_pos, 1));
      SET v_chars = CONCAT(LEFT(v_chars, u_pos - 1), MID(v_chars, u_pos + 1, u));
      SET u = u - 1;
    END WHILE;

    RETURN v_retval;
END $$
DELIMITER ;


UPDATE `users` SET 
`firstname`=shuffle(`firstname`),
`lastname`=shuffle(`lastname`),
`login`= shuffle(`login`) + FLOOR(RAND() * 401) + 100,
`email`='benjamin.balet@gmail.com'
WHERE `login` != 'bbalet';

-- Uppercase the first letter of lastname, while other characters are in lower case
UPDATE `users` SET `firstname` = CONCAT(UCASE(LEFT(`firstname`, 1)), 
                             LCASE(SUBSTRING(`firstname`, 2)));


UPDATE `users` 
SET `password`='$2a$08$LeUbaGFqJjLSAN7to9URsuHB41zcmsMBgBhpZuFp2y2OTxtVcMQ.C';
