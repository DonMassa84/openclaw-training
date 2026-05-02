import fs from "fs";
import path from "path";

const HOME = process.env.HOME || "";
const BASE = path.join(HOME, "openclaw_training");
const MISSION = path.join(BASE, "mission_control");
const STATUS = path.join(BASE, "docs/status");
const REPORTS = path.join(BASE, "reports");
const OPENCLAW_WS = path.join(HOME, ".openclaw/workspace");

function exists(p: string): boolean {
  try {
    return fs.existsSync(p);
  } catch {
    return false;
  }
}

function readTextSafe(p: string, max = 12000): string {
  try {
    if (!exists(p)) return "";
    const name = path.basename(p).toLowerCase();
    if (
      name.includes(".env") ||
      name.includes("token") ||
      name.includes("secret") ||
      name.includes("key") ||
      name.includes("credential")
    ) {
      return "[redacted: sensitive file name]";
    }
    const buf = fs.readFileSync(p, "utf8");
    return buf.slice(0, max);
  } catch (e: any) {
    return `[read error: ${e?.message || "unknown"}]`;
  }
}

function listFiles(dir: string, limit = 80): Array<{ name: string; path: string; mtime: string; size: number }> {
  try {
    if (!exists(dir)) return [];
    const out: Array<{ name: string; path: string; mtime: string; size: number }> = [];
    const walk = (d: string, depth: number) => {
      if (depth > 3 || out.length >= limit) return;
      for (const ent of fs.readdirSync(d, { withFileTypes: true })) {
        const p = path.join(d, ent.name);
        if (ent.name === "node_modules" || ent.name === ".git") continue;
        if (ent.isDirectory()) walk(p, depth + 1);
        if (ent.isFile()) {
          const lower = ent.name.toLowerCase();
          if (!(lower.endsWith(".md") || lower.endsWith(".txt") || lower.endsWith(".json"))) continue;
          if (lower.includes(".env") || lower.includes("token") || lower.includes("secret") || lower.includes("key")) continue;
          const st = fs.statSync(p);
          out.push({ name: ent.name, path: p, mtime: st.mtime.toISOString(), size: st.size });
        }
      }
    };
    walk(dir, 0);
    return out.sort((a, b) => b.mtime.localeCompare(a.mtime)).slice(0, limit);
  } catch {
    return [];
  }
}

function readLatest(dir: string, filename: string): string {
  return readTextSafe(path.join(dir, filename));
}

function countFiles(dir: string): number {
  try {
    if (!exists(dir)) return 0;
    let n = 0;
    const walk = (d: string, depth: number) => {
      if (depth > 4) return;
      for (const ent of fs.readdirSync(d, { withFileTypes: true })) {
        const p = path.join(d, ent.name);
        if (ent.name === "node_modules" || ent.name === ".git") continue;
        if (ent.isDirectory()) walk(p, depth + 1);
        if (ent.isFile()) n++;
      }
    };
    walk(dir, 0);
    return n;
  } catch {
    return 0;
  }
}

export function getMissionData() {
  const tasks = readTextSafe(path.join(MISSION, "tasks/latest_tasks_master.md"));
  const today = readTextSafe(path.join(MISSION, "tasks/latest_tasks_today.md"));
  const agents = readTextSafe(path.join(MISSION, "agents/latest_agent_roles.md"));
  const dailyDelight = readTextSafe(path.join(MISSION, "daily_delight/latest_daily_delight.md"));
  const memoryIndex = readTextSafe(path.join(MISSION, "memory_wiki/00_index.md"));
  const decisions = readTextSafe(path.join(MISSION, "memory_wiki/decisions.md"));
  const projects = readTextSafe(path.join(MISSION, "memory_wiki/projects.md"));
  const phase3 = readTextSafe(path.join(STATUS, "latest_phase3_modules_status.md"));
  const phase2 = readTextSafe(path.join(STATUS, "latest_mission_control_phase2_status.md"));
  const freeze = readTextSafe(path.join(STATUS, "latest_shadowmaker_freeze_report.md"));
  const workspaceAudit = readTextSafe(path.join(MISSION, "workspace_audit/latest_workspace_audit.md"));

  const docs = [
    ...listFiles(path.join(MISSION), 60),
    ...listFiles(STATUS, 40)
  ].slice(0, 100);

  const openclawFiles = listFiles(OPENCLAW_WS, 80);

  return {
    generatedAt: new Date().toISOString(),
    paths: {
      base: BASE,
      mission: MISSION,
      status: STATUS,
      reports: REPORTS,
      openclawWorkspace: OPENCLAW_WS
    },
    exists: {
      base: exists(BASE),
      mission: exists(MISSION),
      openclawWorkspace: exists(OPENCLAW_WS)
    },
    counts: {
      missionFiles: countFiles(MISSION),
      statusFiles: countFiles(STATUS),
      openclawWorkspaceFiles: countFiles(OPENCLAW_WS)
    },
    content: {
      tasks,
      today,
      agents,
      dailyDelight,
      memoryIndex,
      decisions,
      projects,
      phase2,
      phase3,
      freeze,
      workspaceAudit
    },
    docs,
    openclawFiles
  };
}
