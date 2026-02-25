from __future__ import annotations

from python_package.__main__ import main


def test_main_returns_zero() -> None:
    assert main() == 0
