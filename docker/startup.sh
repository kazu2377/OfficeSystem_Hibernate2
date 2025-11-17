#!/bin/bash
set -euo pipefail

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-csharp}

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

mysqld_safe --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock --user=mysql &
MYSQL_SUP=$!

cleanup_run=false
cleanup() {
  if [ "$cleanup_run" = true ]; then
    return
  fi
  cleanup_run=true
  if [ -n "${CATALINA_PID:-}" ] && kill -0 "$CATALINA_PID" 2>/dev/null; then
    catalina.sh stop 30 -force || true
    wait "$CATALINA_PID" || true
  fi
  mysqladmin --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown || true
  wait "$MYSQL_SUP" || true
}
trap cleanup SIGTERM SIGINT

for i in $(seq 1 60); do
  if mysqladmin --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" ping >/dev/null 2>&1; then
    break
  fi
  if [ "$i" -eq 60 ]; then
    echo "MySQL failed to start" >&2
    exit 1
  fi
  sleep 1
done

catalina.sh run &
CATALINA_PID=$!

wait "$CATALINA_PID"
EXIT_CODE=$?
cleanup
exit "$EXIT_CODE"
