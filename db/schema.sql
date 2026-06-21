-- Схема демонстрационной CRM туристического агентства.
-- FK намеренно не навешаны: контроль целостности выполняется data-quality проверками
-- (реалистичный сценарий для выгрузок/импортов из внешних систем).

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS tours;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id          INTEGER PRIMARY KEY,
    full_name   TEXT        NOT NULL,
    email       TEXT        NOT NULL,
    phone       TEXT,
    created_at  TIMESTAMP   NOT NULL DEFAULT now()
);

CREATE TABLE tours (
    id           INTEGER PRIMARY KEY,
    title        TEXT      NOT NULL,
    country      TEXT      NOT NULL,
    price        NUMERIC(10,2) NOT NULL,
    seats_total  INTEGER   NOT NULL
);

CREATE TABLE bookings (
    id           INTEGER PRIMARY KEY,
    customer_id  INTEGER   NOT NULL,
    tour_id      INTEGER   NOT NULL,
    status       TEXT      NOT NULL,            -- new | paid | cancelled | refunded
    pax          INTEGER   NOT NULL,
    amount       NUMERIC(10,2) NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE payments (
    id          INTEGER PRIMARY KEY,
    booking_id  INTEGER   NOT NULL,
    amount      NUMERIC(10,2) NOT NULL,
    status      TEXT      NOT NULL,             -- succeeded | failed | refunded
    paid_at     TIMESTAMP NOT NULL DEFAULT now()
);
