-- Правило: статусы заявок и платежей принадлежат допустимому множеству.
-- Возвращает недопустимые статусы — ожидается 0 строк.
SELECT 'booking' AS entity, id, status FROM bookings
WHERE status NOT IN ('new', 'paid', 'cancelled', 'refunded')
UNION ALL
SELECT 'payment' AS entity, id, status FROM payments
WHERE status NOT IN ('succeeded', 'failed', 'refunded')
