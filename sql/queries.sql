-- Find the 5 oldest users
SELECT 
    *
FROM
    users
ORDER BY created_at ASC
LIMIT 5;

-- Day of the week most users register on
SELECT 
    DAYNAME(created_at) AS day_of_most_users, Count(*) as days
FROM
    users
GROUP BY DAYNAME(created_at)
HAVING COUNT(*) = (SELECT 
        COUNT(*)
    FROM
        users
    GROUP BY DAYNAME(created_at)
    ORDER BY COUNT(*) DESC
    LIMIT 1);

-- Users who have never posted a photo
SELECT 
    u.username
FROM
    users u
        LEFT JOIN
    photos p ON u.id = p.user_id
WHERE
    p.user_id IS NULL;

-- Identify most popular photo      
SELECT 
    username, COUNT(*) AS total_likes
FROM
    photos
        INNER JOIN
    users ON users.id = photos.user_id
        INNER JOIN
    likes ON likes.photo_id = photos.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

-- How many times does the average user post
SELECT 
    COUNT(p.id) / COUNT(DISTINCT u.id) AS avg_user_post
FROM
    users u
        LEFT JOIN
    photos p ON u.id = p.user_id; 
    
-- Top 5 most commonly used hashtags
SELECT 
    id, name, COUNT(*)
FROM
    tags t
        JOIN
    photo_tags pt ON t.id = pt.tag_id
GROUP BY tag_id
HAVING COUNT(*) >= (SELECT 
        COUNT(*)
    FROM
        tags t
            JOIN
        photo_tags pt ON t.id = pt.tag_id
    GROUP BY tag_id
    ORDER BY COUNT(*) DESC
    LIMIT 4 , 1)
ORDER BY COUNT(*) DESC
;

-- Find users who have liked every single photo on the site
SELECT 
    u.id, u.username
FROM
    users u
        JOIN
    likes l ON u.id = l.user_id
GROUP BY u.id
HAVING COUNT(*) = (SELECT 
        COUNT(id)
    FROM
        photos);
      
-- Top 3 most-liked photos per user (keeping ties with DENSE_RANK())   
WITH likes_per_photo AS( 
SELECT 
    p.id AS photo_id, p.user_id, COUNT(l.user_id) AS number_of_likes
FROM
    photos p
        LEFT JOIN
    likes l ON l.photo_id = p.id
GROUP BY p.id , p.user_id
)
SELECT ranking_table.username,ranking_table.photo_id,ranking_table.number_of_likes,ranking_table.ranking FROM (
SELECT * , DENSE_RANK() OVER(PARTITION BY user_id ORDER BY number_of_likes DESC) as ranking
FROM likes_per_photo lpp JOIN users u on lpp.user_id=u.id ) AS ranking_table
WHERE ranking<=3
ORDER BY ranking_table.username,ranking_table.ranking








