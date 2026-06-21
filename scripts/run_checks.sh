#!/usr/bin/env bash
# Прогон всех data-quality проверок против БД.
# Каждый чек — SELECT, возвращающий строки-нарушения. Чек считается пройденным,
# если строк нет. Любое нарушение завершает прогон с ненулевым кодом (для CI).

set -euo pipefail

DB="${DATABASE_URL:?DATABASE_URL is required (например, postgresql://qa:qa@localhost:5432/agency)}"
CHECKS_DIR="$(cd "$(dirname "$0")/../checks" && pwd)"

fail=0
total=0

echo "== Data Quality Checks =="
for f in "$CHECKS_DIR"/check_*.sql; do
    name="$(basename "$f")"
    query="$(cat "$f")"
    total=$((total + 1))

    count="$(psql "$DB" -t -A -c "SELECT count(*) FROM ( $query ) AS _violations;")"
    count="$(echo "$count" | tr -d '[:space:]')"

    if [ "$count" = "0" ]; then
        printf 'PASS  %-48s 0 нарушений\n' "$name"
    else
        printf 'FAIL  %-48s %s нарушений\n' "$name" "$count"
        psql "$DB" -c "$query"
        fail=1
    fi
done

echo "========================="
echo "Проверок выполнено: $total"

if [ "$fail" -ne 0 ]; then
    echo "Результат: найдены нарушения целостности данных."
    exit 1
fi

echo "Результат: все проверки пройдены."
