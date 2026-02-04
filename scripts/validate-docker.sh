#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "=== Validating Docker Build ==="

docker compose build
docker compose up --abort-on-container-exit

if [[ ! -f reports/report.html ]]; then
  echo "❌ FAIL: Docker did not produce report"
  exit 1
fi

echo "✅ Docker validation passed"
