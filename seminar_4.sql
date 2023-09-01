
-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.


SELECT COUNT(*) AS "ОКЛ"
FROM likes l 
LEFT JOIN media m ON l.media_id = m.id
LEFT JOIN profiles p ON p.user_id = m.user_id
WHERE p.birthday >= '2010-07-30';


-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT p.gender AS 'пол', COUNT(l.media_id ) AS 'лайки'
FROM users u
LEFT JOIN likes l ON u.id = l.user_id
LEFT JOIN profiles p ON u.id = p.user_id
WHERE p.gender = 'm'
UNION
SELECT p.gender, COUNT(l.media_id ) AS 'лайки'
FROM users u
LEFT JOIN likes l ON u.id = l.user_id
LEFT JOIN profiles p ON u.id = p.user_id
WHERE p.gender = 'f';


-- Вывести всех пользователей, которые не отправляли сообщения.

SELECT u.id, u.firstname, u.lastname, m.from_user_id
FROM users u
LEFT JOIN messages m ON u.id = m.from_user_id
WHERE m.from_user_id IS NULL;

-- (по желанию)* Пусть задан некоторый пользователь. Из всех друзей
-- этого пользователя найдите человека, который больше всех написал ему 
-- сообщений.


SELECT COUNT(*), u. firstname, u.lastname, m.from_user_id 
FROM messages m
JOIN users u ON u.id = m.from_user_id
JOIN friend_requests fr ON (initiator_user_id = from_user_id AND target_user_id = to_user_id)
OR (initiator_user_id = to_user_id AND target_user_id = from_user_id)
WHERE fr.status = 'approved' AND m.to_user_id = 1
GROUP BY m.from_user_id
ORDER BY from_user_id DESC
LIMIT 1;

