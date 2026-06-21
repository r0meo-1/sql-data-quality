-- Правило: даты создания заявок и проведения платежей не в будущем.
-- Возвращает «будущие» записи — ожидается 0 строк.
SELECT 'booking' AS entity, id, created_at AS ts FROM bookings WHERE created_at > now()
UNION ALL
SELECT 'payment' AS entity, id, paid_at AS ts FROM payments WHERE paid_at > now()
