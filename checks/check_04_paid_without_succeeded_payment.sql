-- Правило: заявка в статусе paid должна иметь хотя бы один успешный платёж.
-- Возвращает оплаченные заявки без платежа — ожидается 0 строк.
SELECT b.id
FROM bookings b
WHERE b.status = 'paid'
  AND NOT EXISTS (
      SELECT 1 FROM payments p
      WHERE p.booking_id = b.id AND p.status = 'succeeded'
  )
