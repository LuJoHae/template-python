"""Entry point for running the package as a module.

Usage:
    python -m python_package
    uv run python -m python_package
"""

from __future__ import annotations

import sys


def main() -> int:
    """Run the main application logic.

    Returns:
        Exit code (0 for success, non-zero for failure).
    """
    return 0


if __name__ == "__main__":
    sys.exit(main())
