import asyncio
import os
import re
import subprocess
import traceback
from pathlib import Path
from typing import Tuple

import discord
from discord import app_commands
from dotenv import load_dotenv

BASE = Path.home() / "openclaw_training"
MISSION = BASE / "mission_control"
ENV_FILE = MISSION / "discord_agent_router" / "config" / "discord_agent_router.env"
load_dotenv(ENV_FILE)

TOKEN = os.getenv("DISCORD_BOT_TOKEN", "").strip()
MAX_OUTPUT = int(os.getenv("ROUTER_MAX_OUTPUT_CHARS", "1800"))
TIMEOUT = int(os.getenv("ROUTER_TIMEOUT_SECONDS", "60"))

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
    cleaned = text or ""
    for pat in patterns:
        cleaned = re.sub(pat, r"\1=***REDACTED***", cleaned)
    return cleaned

def trim(text: str, limit: int = MAX_OUTPUT) -> str:
    text = sanitize((text or "").strip())
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

async def allowed(interaction: discord.Interaction) -> bool:
    user_id = interaction.user.id
    user_name = str(interaction.user)
    channel_id = interaction.channel_id

    if ALLOWED_USERS and user_id not in ALLOWED_USERS:
        await interaction.response.send_message(
            f"Nicht autorisiert.\nDeine echte Discord User ID ist: `{user_id}`\nUser: `{user_name}`\nChannel ID: `{channel_id}`",
            ephemeral=True,
        )
        print(f"UNAUTHORIZED_USER id={user_id} name={user_name} channel={channel_id}", flush=True)
        return False

    if ALLOWED_CHANNELS and channel_id not in ALLOWED_CHANNELS:
        await interaction.response.send_message(
            f"Channel nicht autorisiert.\nChannel ID: `{channel_id}`\nUser ID: `{user_id}`",
            ephemeral=True,
        )
        print(f"UNAUTHORIZED_CHANNEL user={user_id} channel={channel_id}", flush=True)
        return False

    return True

async def channel_send(channel, text: str):
    text = trim(text, 1900)
    try:
        await channel.send(text)
    except Exception as exc:
        print(f"CHANNEL_SEND_ERROR {type(exc).__name__}: {exc}", flush=True)

async def run_script(name: str) -> Tuple[int, str]:
    script = PATHS.get(name)
    if not script or not script.exists():
        return 127, f"Skript fehlt: {script}"
    if not os.access(script, os.X_OK):
        return 126, f"Skript nicht ausführbar: {script}"

    env = os.environ.copy()
    env["DISCORD_ROUTER_CHILD_RUN"] = "1"

    proc = await asyncio.create_subprocess_exec(
        str(script),
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT,
        cwd=str(Path.home()),
        env=env,
    )

    try:
        stdout, _ = await asyncio.wait_for(proc.communicate(), timeout=TIMEOUT)
        output = stdout.decode("utf-8", errors="ignore")
        return proc.returncode or 0, output
    except asyncio.TimeoutError:
        try:
            proc.kill()
        except Exception:
            pass
        return 124, f"Timeout nach {TIMEOUT}s: {name}"

def run_cmd(cmd: str, timeout: int = 12) -> str:
    try:
        return subprocess.run(
            ["bash", "-lc", cmd],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            timeout=timeout,
        ).stdout
    except Exception as exc:
        return f"CMD_ERROR {type(exc).__name__}: {exc}"

def status_text() -> str:
    failed = run_cmd("systemctl --user --failed --no-pager", 10)
    timers = run_cmd("systemctl --user list-timers --all --no-pager | grep -E 'openclaw|shadowmaker|security|shadowops|winky|mnemosyne|courier|NEXT|LEFT' || true", 10)
    webui = run_cmd("curl -I --max-time 5 http://127.0.0.1:4173 2>&1 | head -20 || true", 8)
    courier = run_cmd("source ~/.bashrc >/dev/null 2>&1 || true; courier-status 2>&1 | grep -E 'Status:|Read-only:|Gesamt:|P1:|P2:|P3:|Fehler:' -A1 || true", 12)

    return trim(
        "**Shadowmaker Status**\n\n"
        "**User Failed**\n"
        f"```text\n{failed}\n```\n"
        "**Timer**\n"
        f"```text\n{timers}\n```\n"
        "**WebUI**\n"
        f"```text\n{webui}\n```\n"
        "**Courier**\n"
        f"```text\n{courier}\n```",
        1800,
    )

def help_text() -> str:
    return (
        "**Shadowmaker Discord Agent Router**\n\n"
        "**Slash Commands:**\n"
        "`/hilfe` Hilfe\n"
        "`/status` Gesamtstatus\n"
        "`/latest agent:<name>` letzten Report lesen\n"
        "`/winky` Systemmonitor\n"
        "`/mnemosyne` Memory Curator\n"
        "`/courier` Mail-Briefing read-only\n"
        "`/mentor` IHK/MFP Drill\n"
        "`/strategist` Karriere/CV Template\n"
        "`/steward` Finance/Housing/Jobcenter read-only\n"
        "`/linky` Prompt-to-Code Modul\n\n"
        "**Grenzen:** keine freie Shell, kein sudo, keine Löschung, keine Timer-Aktivierung, keine Mail-Aktion."
    )

class ShadowmakerClient(discord.Client):
    def __init__(self):
        intents = discord.Intents.default()
        super().__init__(intents=intents)
        self.tree = app_commands.CommandTree(self)

    async def setup_hook(self):
        await self.tree.sync()

client = ShadowmakerClient()

@client.event
async def on_ready():
    print(f"READY {client.user} guilds={len(client.guilds)} slash_commands_synced=yes immediate_ack=yes", flush=True)

@client.tree.error
async def on_app_command_error(interaction: discord.Interaction, error: app_commands.AppCommandError):
    print("APP_COMMAND_ERROR:", repr(error), flush=True)
    traceback.print_exception(type(error), error, error.__traceback__)
    try:
        if interaction.response.is_done():
            await interaction.followup.send(f"Routerfehler: `{type(error).__name__}`", ephemeral=True)
        else:
            await interaction.response.send_message(f"Routerfehler: `{type(error).__name__}`", ephemeral=True)
    except Exception:
        pass

@client.tree.command(name="hilfe", description="Shadowmaker Agent Router Hilfe")
async def slash_hilfe(interaction: discord.Interaction):
    if not await allowed(interaction):
        return
    await interaction.response.send_message(help_text(), ephemeral=True)

@client.tree.command(name="status", description="Shadowmaker Gesamtstatus lesen")
async def slash_status(interaction: discord.Interaction):
    if not await allowed(interaction):
        return
    await interaction.response.send_message("✅ `/status` angenommen. Ergebnis folgt im Channel.", ephemeral=True)
    async def job():
        text = await asyncio.to_thread(status_text)
        await channel_send(interaction.channel, text)
    asyncio.create_task(job())

async def run_agent_background(channel, name: str):
    try:
        await channel_send(channel, f"⚙️ `{name}` gestartet.")
        code, output = await run_script(name)
        latest = LATEST_FILES.get(name)
        latest_text = read_text(latest, 1200) if latest else ""
        body = latest_text or output
        response = (
            f"✅ **{name} fertig**\n"
            f"Exit: `{code}`\n"
            f"Latest: `{latest}`\n\n"
            f"```text\n{trim(body, 1400)}\n```"
        )
        await channel_send(channel, response)
    except Exception as exc:
        print(f"BACKGROUND_AGENT_ERROR {name}: {type(exc).__name__}: {exc}", flush=True)
        await channel_send(channel, f"❌ Agent `{name}` Fehler: `{type(exc).__name__}`")

async def run_agent_interaction(interaction: discord.Interaction, name: str):
    if not await allowed(interaction):
        return
    await interaction.response.send_message(f"✅ `/{name}` angenommen. Agent läuft im Hintergrund.", ephemeral=True)
    asyncio.create_task(run_agent_background(interaction.channel, name))

@client.tree.command(name="winky", description="Winky Systemmonitor ausführen")
async def slash_winky(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "winky")

@client.tree.command(name="mnemosyne", description="Mnemosyne Memory Curator ausführen")
async def slash_mnemosyne(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "mnemosyne")

@client.tree.command(name="courier", description="Courier Mail Briefing read-only ausführen")
async def slash_courier(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "courier")

@client.tree.command(name="mentor", description="Mentor IHK/MFP Drill erzeugen")
async def slash_mentor(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "mentor")

@client.tree.command(name="strategist", description="Strategist Career/CV Template erzeugen")
async def slash_strategist(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "strategist")

@client.tree.command(name="steward", description="Steward Finance/Housing read-only Lagebild erzeugen")
async def slash_steward(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "steward")

@client.tree.command(name="linky", description="Linky Prompt-to-Code Modul erzeugen")
async def slash_linky(interaction: discord.Interaction):
    await run_agent_interaction(interaction, "linky")

@app_commands.describe(agent="winky, mnemosyne, courier, mentor, strategist, steward oder linky")
@client.tree.command(name="latest", description="Letzten Agentenreport lesen")
async def slash_latest(interaction: discord.Interaction, agent: str):
    if not await allowed(interaction):
        return
    name = agent.strip().lower()
    if name not in LATEST_FILES:
        await interaction.response.send_message("Nicht erlaubt. Erlaubt: winky, mnemosyne, courier, mentor, strategist, steward, linky", ephemeral=True)
        return
    text = read_text(LATEST_FILES[name], 1600)
    await interaction.response.send_message(f"**Latest {name}**\n```text\n{trim(text, 1500)}\n```", ephemeral=False)

if not TOKEN:
    raise SystemExit("DISCORD_BOT_TOKEN fehlt.")

client.run(TOKEN)
