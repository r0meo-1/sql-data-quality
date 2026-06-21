-- Правило: email клиента должен быть уникальным (без учёта регистра и пробелов).
-- Возвращает дубли — ожидается 0 строк.
SELECT lower(trim(email)) AS email, count(*) AS cnt
FROM customers
GROUP BY lower(trim(email))
HAVING count(*) > 1
