-- Правило: суммы заявок и платежей строго положительны.
-- Возвращает нулевые/отрицательные суммы — ожидается 0 строк.
SELECT 'booking' AS entity, id, amount FROM bookings WHERE amount <= 0
UNION ALL
SELECT 'payment' AS entity, id, amount FROM payments WHERE amount <= 0
