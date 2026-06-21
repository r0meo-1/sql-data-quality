-- Правило: каждый платёж привязан к существующей заявке.
-- Возвращает платежи без заявки — ожидается 0 строк.
SELECT p.id, p.booking_id
FROM payments p
LEFT JOIN bookings b ON b.id = p.booking_id
WHERE b.id IS NULL
