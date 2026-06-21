-- Правило: возвращённая заявка должна иметь платёж со статусом refunded.
-- Возвращает refunded-заявки без возврата — ожидается 0 строк.
SELECT b.id
FROM bookings b
WHERE b.status = 'refunded'
  AND NOT EXISTS (
      SELECT 1 FROM payments p
      WHERE p.booking_id = b.id AND p.status = 'refunded'
  )
