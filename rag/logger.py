import logging
from pathlib import Path

_LOG_FILE = Path(__file__).parent.parent / "logs" / "generation.log"
_LOG_FILE.parent.mkdir(exist_ok=True)

_logger = logging.getLogger("rag")
if not _logger.handlers:
    _logger.setLevel(logging.DEBUG)
    fh = logging.FileHandler(_LOG_FILE, encoding="utf-8")
    fh.setFormatter(logging.Formatter("%(asctime)s  %(levelname)-8s  %(message)s", datefmt="%Y-%m-%d %H:%M:%S"))
    _logger.addHandler(fh)


def log(level: str, msg: str) -> None:
    getattr(_logger, level.lower())(msg)


def log_typst_error(week_nr: int, attempt: int, error: str) -> None:
    _logger.error(
        f"[Week {week_nr:02d}] Typst error (attempt {attempt}):\n{error.strip()}"
    )


def log_truncated(week_nr: int) -> None:
    _logger.warning(f"[Week {week_nr:02d}] Output truncated (max_tokens reached) — requesting continuation")


def log_correction(week_nr: int, attempt: int, success: bool) -> None:
    if success:
        _logger.info(f"[Week {week_nr:02d}] Auto-correction attempt {attempt} succeeded")
    else:
        _logger.error(f"[Week {week_nr:02d}] Auto-correction attempt {attempt} FAILED — giving up")


def read_log(tail: int = 100) -> str:
    if not _LOG_FILE.exists():
        return ""
    lines = _LOG_FILE.read_text(encoding="utf-8").splitlines()
    return "\n".join(lines[-tail:])


def clear_log() -> None:
    _LOG_FILE.write_text("", encoding="utf-8")
