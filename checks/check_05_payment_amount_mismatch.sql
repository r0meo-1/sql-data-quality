-- Правило: для оплаченной заявки сумма успешных платежей равна сумме заявки.
-- Возвращает расхождения сумм — ожидается 0 строк.
SELECT b.id, b.amount, COALESCE(SUM(p.amount), 0) AS paid_sum
FROM bookings b
LEFT JOIN payments p
    ON p.booking_id = b.id AND p.status = 'succeeded'
WHERE b.status = 'paid'
GROUP BY b.id, b.amount
HAVING COALESCE(SUM(p.amount), 0) <> b.amount
