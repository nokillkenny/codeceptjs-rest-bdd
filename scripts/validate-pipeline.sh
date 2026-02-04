#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "=== Validating Pipeline Config ==="

workflow=".github/workflows/test.yml"

if [[ ! -f "$workflow" ]]; then
  echo "❌ FAIL: Workflow file missing"
  exit 1
fi

checks=(
  "codeceptjs-report"
  "upload-artifact"
  "repository-dispatch"
  "test-showcase"
)

for check in "${checks[@]}"; do
  if ! grep -q "$check" "$workflow"; then
    echo "❌ FAIL: Missing '$check' in workflow"
    exit 1
  fi
done

echo "✅ Pipeline config valid"
