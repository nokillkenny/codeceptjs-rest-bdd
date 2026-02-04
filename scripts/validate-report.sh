#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "=== Validating Report Generation ==="

rm -rf reports/
mkdir -p reports

npm run test:report

if [[ ! -f reports/report.html ]]; then
  echo "❌ FAIL: report.html not generated"
  exit 1
fi

size=$(wc -c < reports/report.html)
if [[ $size -lt 1000 ]]; then
  echo "❌ FAIL: report.html too small ($size bytes)"
  exit 1
fi

if ! grep -q "</html>" reports/report.html; then
  echo "❌ FAIL: Report HTML malformed"
  exit 1
fi

echo "✅ Report generated: reports/report.html ($size bytes)"
