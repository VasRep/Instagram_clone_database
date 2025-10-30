-- View to collect the stats of tags stored in the database 
CREATE OR REPLACE VIEW tag_stats AS
    SELECT 
        t.id AS tag_id,
        t.name AS tag_name,
        COUNT(DISTINCT photo_id) AS photos_using_tag,
        COUNT(pt.photo_id) AS number_of_uses
    FROM
        tags t
            LEFT JOIN
        photo_tags pt ON t.id = pt.tag_id
    GROUP BY t.id;