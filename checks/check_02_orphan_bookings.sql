-- Правило: каждая заявка ссылается на существующего клиента и тур.
-- Возвращает «сиротские» заявки — ожидается 0 строк.
SELECT b.id, b.customer_id, b.tour_id
FROM bookings b
LEFT JOIN customers c ON c.id = b.customer_id
LEFT JOIN tours t ON t.id = b.tour_id
WHERE c.id IS NULL OR t.id IS NULL
