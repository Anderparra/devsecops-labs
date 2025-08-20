#!/usr/bin/env bash
# Simple secret scan helper (for demos). Prefer real tools in pipelines.
# This script tries to detect obvious patterns (AWS keys, private keys).
# It also integrates detect-secrets if available.
set -euo pipefail

# Run detect-secrets if installed
if command -v detect-secrets >/dev/null 2>&1; then
  echo "[*] Running detect-secrets..."
  detect-secrets scan
else
  echo "[*] detect-secrets not found; running basic grep heuristics..."
  grep -RIn --exclude-dir .git --exclude-dir node_modules --exclude-dir .venv     -E '(AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|-----BEGIN (RSA|DSA|EC) PRIVATE KEY-----)' . || true
fi
