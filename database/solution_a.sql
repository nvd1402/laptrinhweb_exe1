---a Truy vấn người dùng
---1. Lấy ra ds người dùng theo thứ tự tên theo Alphabet(A->Z)
SELECT * FROM users
ORDER BY user_name ASC;
---2
SELECT * FROM users
ORDER BY user_name ASC
LIMIT 7;
---3
SELECT * FROM users
WHERE user_name LIKE '%a%'
ORDER BY user_name ASC;
---4
SELECT * FROM users
WHERE user_name LIKE 'm%'
ORDER BY user_name ASC;
---5
SELECT * FROM users
WHERE user_name LIKE '%i'
ORDER BY user_name ASC;
---6
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com';
---7
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE 'm%';
---8
SELECT * FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE '%i%'
AND LENGTH(user_name) > 5;
---9
SELECT * FROM users
WHERE user_name LIKE '%i%'
AND LENGTH(user_name) < 9
AND user_email LIKE '%@gmail.com'
AND user_email NOT LIKE '%@yahoo.com';
---10
SELECT * FROM users
WHERE (user_name LIKE '%i%' AND LENGTH(user_name) < 9)
OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');
