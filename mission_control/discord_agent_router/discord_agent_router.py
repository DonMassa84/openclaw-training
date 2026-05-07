import asyncio
import os
import re
import shlex
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple

import discord
from dotenv import load_dotenv

BASE = Path.home() / "openclaw_training"
MISSION = BASE / "mission_control"
ENV_FILE = MISSION / "discord_agent_router" / "config" / "discord_agent_router.env"
load_dotenv(ENV_FILE)

TOKEN = os.getenv("DISCORD_BOT_TOKEN", "").strip()
PREFIX = os.getenv("DISCORD_COMMAND_PREFIX", "!").strip() or "!"
MAX_OUTPUT = int(os.getenv("ROUTER_MAX_OUTPUT_CHARS", "1800"))
TIMEOUT = int(os.getenv("ROUTER_TIMEOUT_SECONDS", "180"))

def parse_ids(value: str) -> set[int]:
    out = set()
    for part in (value or "").split(","):
        part = part.strip()
        if part.isdigit():
            out.add(int(part))
    return out

ALLOWED_USERS = parse_ids(os.getenv("DISCORD_ALLOWED_USER_IDS", ""))
ALLOWED_CHANNELS = parse_ids(os.getenv("DISCORD_ALLOWED_CHANNEL_IDS", ""))

PATHS = {
    "winky": Path.home() / "winky_system_monitor_agent.sh",
    "mnemosyne": Path.home() / "mnemosyne_memory_curator_agent.sh",
    "courier": Path.home() / "courier_mail_briefing_run.sh",
    "mentor": Path.home() / "mentor_ihk_mfp_agent.sh",
    "strategist": Path.home() / "strategist_career_agent.sh",
    "steward": Path.home() / "steward_finance_housing_agent.sh",
    "linky": Path.home() / "linky_builder_agent.sh",
}

LATEST_FILES = {
    "winky": MISSION / "agent_runtime" / "winky" / "latest_winky_report.md",
    "mnemosyne": MISSION / "agent_runtime" / "mnemosyne" / "latest_mnemosyne_report.md",
    "courier": MISSION / "mail_briefing" / "briefs" / "latest_courier_mail_brief.md",
    "mentor": MISSION / "ihk_mfp" / "latest_mentor_drill.md",
    "strategist": MISSION / "career_it" / "latest_strategist_career_template.md",
    "steward": MISSION / "finance_housing_readonly" / "latest_steward_finance_housing_readonly.md",
    "linky": MISSION / "prompt_to_code" / "latest_linky_module.md",
}

def sanitize(text: str) -> str:
    patterns = [
        r"(?i)(token|secret|password|pass|api[_-]?key)\s*[:=]\s*\S+",
        r"\b[A-Za-z0-9_\-]{24}\.[A-Za-z0-9_\-]{6}\.[A-Za-z0-9_\-]{20,}\b",
        r"xox[baprs]-[A-Za-z0-9\-]+",
        r"sk-[A-Za-z0-9_\-]{20,}",
    ]
    cleaned = text
    for pat in patterns:
        cleaned = re.sub(pat, r"\1=***REDACTED***", cleaned)
    return cleaned

def trim(text: str, limit: int = MAX_OUTPUT) -> str:
    text = sanitize(text.strip())
    if len(text) <= limit:
        return text
    return text[:limit] + "\n...[gekürzt]"

def read_text(path: Path, limit: int = MAX_OUTPUT) -> str:
    if not path.exists():
        return f"Datei nicht gefunden: {path}"
    try:
        return trim(path.read_text(encoding="utf-8", errors="ignore"), limit)
    except Exception as exc:
        return f"Lesefehler: {path}: {exc}"

async def run_script(name: str) -> Tuple[int, str]:
    script = PATHS.get(name)
    if not script or not script.exists():
        return 127, f"Skript fehlt: {script}"
    if not os.access(script, os.X_OK):
        return 126, f"Skript nicht ausführbar: {script}"
    proc = await asyncio.create_subprocess_exec(
        str(script),
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT,
        cwd=str(Path.home()),
        env=os.environ.copy(),
    )
    try:
        stdout, _ = await asyncio.wait_for(proc.communicate(), timeout=TIMEOUT)
        output = stdout.decode("utf-8", errors="ignore")
        return proc.returncode or 0, output
    except asyncio.TimeoutError:
        proc.kill()
        return 124, f"Timeout nach {TIMEOUT}s: {name}"

def status_text() -> str:
    failed = subprocess.run(
        ["systemctl", "--user", "--failed", "--no-pager"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        timeout=15,
    ).stdout
    timers = subprocess.run(
        ["bash", "-lc", "systemctl --user list-timers --all --no-pager | grep -E 'winky|mnemosyne|courier|openclaw|shadowmaker|security|shadowops|NEXT|LEFT' || true"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        timeout=15,
    ).stdout
    webui = subprocess.run(
        ["bash", "-lc", "curl -I --max-time 5 http://127.0.0.1:4173 2>&1 | head -20 || true"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        timeout=10,
    ).stdout
    courier_status = subprocess.run(
        ["bash", "-lc", "source ~/.bashrc >/dev/null 2>&1 || true; courier-status 2>&1 | grep -E 'Status:|Read-only:|Gesamt:|P1:|P2:|P3:|Fehler:' -A1 || true"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        timeout=20,
    ).stdout
    return trim(
        "# Shadowmaker Status\n\n"
        "## User Failed\n"
        f"```text\n{failed}\n```\n"
        "## Timer\n"
        f"```text\n{timers}\n```\n"
        "## WebUI\n"
        f"```text\n{webui}\n```\n"
        "## Courier\n"
        f"```text\n{courier_status}\n```",
        1900,
    )

def help_text() -> str:
    return (
        "**Shadowmaker Discord Agent Router**\n\n"
        f"Prefix: `{PREFIX}`\n\n"
        "**Status:**\n"
        f"`{PREFIX}status` Gesamtstatus\n"
        f"`{PREFIX}help` Hilfe\n\n"
        "**Agenten ausführen:**\n"
        f"`{PREFIX}winky` Systemmonitor\n"
        f"`{PREFIX}mnemosyne` Memory Curator\n"
        f"`{PREFIX}courier` Mail-Briefing read-only\n"
        f"`{PREFIX}mentor` IHK/MFP Drill\n"
        f"`{PREFIX}strategist` Karriere/CV Template\n"
        f"`{PREFIX}steward` Finance/Housing/Jobcenter read-only\n"
        f"`{PREFIX}linky` Prompt-to-Code Modul\n\n"
        "**Latest lesen ohne Ausführung:**\n"
        f"`{PREFIX}latest winky|mnemosyne|courier|mentor|strategist|steward|linky`\n\n"
        "**Grenzen:** keine freie Shell, kein sudo, keine Löschung, keine Timer-Aktivierung, keine Mail-Aktion."
    )

async def send_chunked(channel: discord.abc.Messageable, text: str):
    text = trim(text, 3500)
    chunks: List[str] = []
    while text:
        chunks.append(text[:1900])
        text = text[1900:]
    for chunk in chunks:
        await channel.send(chunk)

intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)

@client.event
async def on_ready():
    print(f"READY {client.user} guilds={len(client.guilds)}")

@client.event
async def on_message(message: discord.Message):
    if message.author.bot:
        return

    if ALLOWED_USERS and message.author.id not in ALLOWED_USERS:
        return

    if ALLOWED_CHANNELS and message.channel.id not in ALLOWED_CHANNELS:
        return

    content = message.content.strip()
    if not content.startswith(PREFIX):
        return

    raw = content[len(PREFIX):].strip()
    if not raw:
        return

    parts = shlex.split(raw)
    if not parts:
        return

    cmd = parts[0].lower()

    if cmd in {"help", "hilfe"}:
        await send_chunked(message.channel, help_text())
        return

    if cmd == "status":
        await message.channel.send("Status wird gelesen...")
        await send_chunked(message.channel, status_text())
        return

    if cmd == "latest":
        if len(parts) < 2:
            await message.channel.send(f"Nutzung: `{PREFIX}latest winky|mnemosyne|courier|mentor|strategist|steward|linky`")
            return
        name = parts[1].lower()
        if name not in LATEST_FILES:
            await message.channel.send("Nicht erlaubt.")
            return
        await send_chunked(message.channel, f"**Latest {name}**\n```text\n{read_text(LATEST_FILES[name], 1600)}\n```")
        return

    if cmd in PATHS:
        await message.channel.send(f"`{cmd}` wird read-only/kontrolliert ausgeführt...")
        code, output = await run_script(cmd)
        latest = LATEST_FILES.get(cmd)
        latest_text = read_text(latest, 1200) if latest else ""
        response = (
            f"**{cmd} fertig**\n"
            f"Exit: `{code}`\n"
            f"Latest: `{latest}`\n\n"
            f"```text\n{trim(latest_text or output, 1500)}\n```"
        )
        await send_chunked(message.channel, response)
        return

    await message.channel.send("Befehl nicht erlaubt. Nutze `!help`.")

if not TOKEN:
    raise SystemExit("DISCORD_BOT_TOKEN fehlt.")

client.run(TOKEN)
