#!/usr/bin/env python3
"""Best-effort EPUB check for local pre-commit runs."""

from __future__ import annotations

import subprocess
import sys


NETWORK_ERROR_MARKERS = (
    "httpx.proxyerror",
    "httpx.networkerror",
    "httpx.timeoutexception",
    "proxyerror",
    "timed out",
    "timeout",
    "503 service unavailable",
    "temporary failure in name resolution",
    "kroki.io",
    "network error for diagram",
    "failed to establish a new connection",
)


def is_network_failure(output: str) -> bool:
    lowered = output.lower()
    return any(marker in lowered for marker in NETWORK_ERROR_MARKERS)


def main() -> int:
    result = subprocess.run(
        [sys.executable, "scripts/build_epub.py", "--root", "en"],
        capture_output=True,
        text=True,
    )

    combined_output = "\n".join(
        part for part in (result.stdout, result.stderr) if part.strip()
    )

    if result.returncode == 0:
        if combined_output:
            print(combined_output.rstrip())
        return 0

    if is_network_failure(combined_output):
        print("⚠ EPUB pre-commit check skipped due to a network-dependent build failure.")
        if combined_output:
            print(combined_output.rstrip())
        return 0

    if combined_output:
        print(combined_output.rstrip())
    return result.returncode


if __name__ == "__main__":
    raise SystemExit(main())
