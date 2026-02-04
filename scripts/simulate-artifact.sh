#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "=== Simulating Artifact Upload ==="

output_dir="${1:-/tmp/codeceptjs-artifact}"
rm -rf "$output_dir"
mkdir -p "$output_dir"

npm run test:report

cp -r reports/* "$output_dir/"

echo "✅ Artifact simulated at: $output_dir"
ls -la "$output_dir"
