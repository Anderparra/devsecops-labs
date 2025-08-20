#!/usr/bin/env bash
# Basic Linux baseline checks (demo only). Run with sudo for full effect.
set -euo pipefail

echo "[*] Checking SSH root login setting (PermitRootLogin)..."
if [ -f /etc/ssh/sshd_config ]; then
  grep -E '^#?PermitRootLogin' /etc/ssh/sshd_config || echo "PermitRootLogin not set explicitly"
fi

echo "[*] World-writable files (may be noisy):"
find / -xdev -type f -perm -0002 -print 2>/dev/null | head -n 50 || true

echo "[*] Listening ports:"
ss -tulpen || true
