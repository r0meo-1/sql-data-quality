-- Правило: число туристов в заявке > 0 и не превышает вместимость тура.
-- Возвращает некорректные значения pax — ожидается 0 строк.
SELECT b.id, b.pax, t.seats_total
FROM bookings b
JOIN tours t ON t.id = b.tour_id
WHERE b.pax <= 0 OR b.pax > t.seats_total
