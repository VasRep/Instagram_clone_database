-- Setting constraint for users table
ALTER TABLE users
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE users
MODIFY COLUMN username VARCHAR(255) UNIQUE NOT NULL;

ALTER TABLE users
MODIFY COLUMN created_at TIMESTAMP DEFAULT NOW();

ALTER TABLE users
MODIFY COLUMN age INT NOT NULL;

-- Setting constraints for photos table
ALTER TABLE photos
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE photos
MODIFY COLUMN image_url VARCHAR(255) NOT NULL;

ALTER TABLE photos
MODIFY COLUMN user_id INT NOT NULL;

ALTER TABLE photos
MODIFY COLUMN created_at TIMESTAMP DEFAULT NOW();

ALTER TABLE photos 
ADD FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

-- Setting constraints for tags table
ALTER TABLE tags
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE tags
MODIFY COLUMN name VARCHAR(255) UNIQUE;

-- Setting constraints for photo_tags table
ALTER TABLE photo_tags
ADD CONSTRAINT pk_photo_tags PRIMARY KEY (photo_id , tag_id);

ALTER TABLE photo_tags
ADD FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;

ALTER TABLE photo_tags
ADD FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE;

-- Setting constraints for likes table

ALTER TABLE likes 
MODIFY column user_id INT NOT NULL;

ALTER TABLE likes 
MODIFY column photo_id INT NOT NULL;

ALTER TABLE likes
MODIFY COLUMN created_at TIMESTAMP DEFAULT NOW();

ALTER TABLE likes
ADD CONSTRAINT pk_likes PRIMARY KEY (user_id , photo_id);

ALTER TABLE likes
ADD FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE likes
ADD FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;

-- Setting constraints for comments table
ALTER TABLE comments
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE comments
MODIFY COLUMN comment_text VARCHAR(255) NOT NULL;

ALTER TABLE comments
MODIFY column user_id INT NOT NULL;

ALTER TABLE comments 
MODIFY column photo_id INT NOT NULL;

ALTER TABLE comments
MODIFY COLUMN created_at TIMESTAMP DEFAULT NOW();

ALTER TABLE comments
ADD FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE comments
ADD FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;

-- Creating this table for keep tracking unfollowing
CREATE TABLE unfollows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id)
        REFERENCES users (id),
    FOREIGN KEY (followee_id)
        REFERENCES users (id),
    PRIMARY KEY (follower_id , followee_id)
);