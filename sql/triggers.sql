-- Activate trigger when a new record with age less than 18 is inserted
DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END$$

DELIMITER ;

-- Activate a trigger when a user tries to follow himself
DELIMITER $$

CREATE TRIGGER prevent_self_follows
     BEFORE INSERT ON follows FOR EACH ROW
     BEGIN
          IF NEW.follower_id = NEW.followee_id
          THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Cannot follow yourself';
          END IF;
     END$$

DELIMITER ;

-- Activate a trigger in order to keep track users who unfollow other users
DELIMITER $$

CREATE TRIGGER create_unfollow
    AFTER DELETE ON follows FOR EACH ROW 
BEGIN
    INSERT INTO unfollows(follower_id,followee_id)
    VALUES(OLD.follower_id,OLD.followee_id);
END$$

DELIMITER ;