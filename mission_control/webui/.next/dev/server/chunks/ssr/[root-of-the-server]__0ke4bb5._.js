module.exports = [
"[externals]/next/dist/shared/lib/no-fallback-error.external.js [external] (next/dist/shared/lib/no-fallback-error.external.js, cjs)", ((__turbopack_context__, module, exports) => {

const mod = __turbopack_context__.x("next/dist/shared/lib/no-fallback-error.external.js", () => require("next/dist/shared/lib/no-fallback-error.external.js"));

module.exports = mod;
}),
"[externals]/fs [external] (fs, cjs)", ((__turbopack_context__, module, exports) => {

const mod = __turbopack_context__.x("fs", () => require("fs"));

module.exports = mod;
}),
"[project]/openclaw_training/mission_control/webui/lib/data.ts [app-rsc] (ecmascript)", ((__turbopack_context__) => {
"use strict";

__turbopack_context__.s([
    "getMissionData",
    ()=>getMissionData
]);
var __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__ = __turbopack_context__.i("[externals]/fs [external] (fs, cjs)");
var __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__ = __turbopack_context__.i("[externals]/path [external] (path, cjs)");
;
;
const HOME = process.env.HOME || "";
const BASE = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(HOME, "openclaw_training");
const MISSION = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(BASE, "mission_control");
const STATUS = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(BASE, "docs/status");
const REPORTS = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(BASE, "reports");
const OPENCLAW_WS = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(HOME, ".openclaw/workspace");
function exists(p) {
    try {
        return __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__["default"].existsSync(p);
    } catch  {
        return false;
    }
}
function readTextSafe(p, max = 12000) {
    try {
        if (!exists(p)) return "";
        const name = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].basename(p).toLowerCase();
        if (name.includes(".env") || name.includes("token") || name.includes("secret") || name.includes("key") || name.includes("credential")) {
            return "[redacted: sensitive file name]";
        }
        const buf = __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__["default"].readFileSync(p, "utf8");
        return buf.slice(0, max);
    } catch (e) {
        return `[read error: ${e?.message || "unknown"}]`;
    }
}
function listFiles(dir, limit = 80) {
    try {
        if (!exists(dir)) return [];
        const out = [];
        const walk = (d, depth)=>{
            if (depth > 3 || out.length >= limit) return;
            for (const ent of __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__["default"].readdirSync(d, {
                withFileTypes: true
            })){
                const p = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(d, ent.name);
                if (ent.name === "node_modules" || ent.name === ".git") continue;
                if (ent.isDirectory()) walk(p, depth + 1);
                if (ent.isFile()) {
                    const lower = ent.name.toLowerCase();
                    if (!(lower.endsWith(".md") || lower.endsWith(".txt") || lower.endsWith(".json"))) continue;
                    if (lower.includes(".env") || lower.includes("token") || lower.includes("secret") || lower.includes("key")) continue;
                    const st = __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__["default"].statSync(p);
                    out.push({
                        name: ent.name,
                        path: p,
                        mtime: st.mtime.toISOString(),
                        size: st.size
                    });
                }
            }
        };
        walk(dir, 0);
        return out.sort((a, b)=>b.mtime.localeCompare(a.mtime)).slice(0, limit);
    } catch  {
        return [];
    }
}
function readLatest(dir, filename) {
    return readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(dir, filename));
}
function countFiles(dir) {
    try {
        if (!exists(dir)) return 0;
        let n = 0;
        const walk = (d, depth)=>{
            if (depth > 4) return;
            for (const ent of __TURBOPACK__imported__module__$5b$externals$5d2f$fs__$5b$external$5d$__$28$fs$2c$__cjs$29$__["default"].readdirSync(d, {
                withFileTypes: true
            })){
                const p = __TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(d, ent.name);
                if (ent.name === "node_modules" || ent.name === ".git") continue;
                if (ent.isDirectory()) walk(p, depth + 1);
                if (ent.isFile()) n++;
            }
        };
        walk(dir, 0);
        return n;
    } catch  {
        return 0;
    }
}
function getMissionData() {
    const tasks = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "tasks/latest_tasks_master.md"));
    const today = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "tasks/latest_tasks_today.md"));
    const agents = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "agents/latest_agent_roles.md"));
    const dailyDelight = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "daily_delight/latest_daily_delight.md"));
    const memoryIndex = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "memory_wiki/00_index.md"));
    const decisions = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "memory_wiki/decisions.md"));
    const projects = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "memory_wiki/projects.md"));
    const phase3 = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(STATUS, "latest_phase3_modules_status.md"));
    const phase2 = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(STATUS, "latest_mission_control_phase2_status.md"));
    const freeze = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(STATUS, "latest_shadowmaker_freeze_report.md"));
    const workspaceAudit = readTextSafe(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION, "workspace_audit/latest_workspace_audit.md"));
    const docs = [
        ...listFiles(__TURBOPACK__imported__module__$5b$externals$5d2f$path__$5b$external$5d$__$28$path$2c$__cjs$29$__["default"].join(MISSION), 60),
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
}),
"[project]/openclaw_training/mission_control/webui/app/page.tsx [app-rsc] (ecmascript)", ((__turbopack_context__) => {
"use strict";

__turbopack_context__.s([
    "default",
    ()=>Page
]);
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/next/dist/server/route-modules/app-page/vendored/rsc/react-jsx-dev-runtime.js [app-rsc] (ecmascript)");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$lib$2f$data$2e$ts__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/lib/data.ts [app-rsc] (ecmascript)");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$shield$2d$check$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__ShieldCheck$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/shield-check.mjs [app-rsc] (ecmascript) <export default as ShieldCheck>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$terminal$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Terminal$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/terminal.mjs [app-rsc] (ecmascript) <export default as Terminal>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$brain$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Brain$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/brain.mjs [app-rsc] (ecmascript) <export default as Brain>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$clipboard$2d$list$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__ClipboardList$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/clipboard-list.mjs [app-rsc] (ecmascript) <export default as ClipboardList>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$bot$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Bot$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/bot.mjs [app-rsc] (ecmascript) <export default as Bot>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$folder$2d$kanban$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__FolderKanban$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/folder-kanban.mjs [app-rsc] (ecmascript) <export default as FolderKanban>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$file$2d$text$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__FileText$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/file-text.mjs [app-rsc] (ecmascript) <export default as FileText>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$sparkles$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Sparkles$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/sparkles.mjs [app-rsc] (ecmascript) <export default as Sparkles>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$activity$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Activity$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/activity.mjs [app-rsc] (ecmascript) <export default as Activity>");
var __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$database$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Database$3e$__ = __turbopack_context__.i("[project]/openclaw_training/mission_control/webui/node_modules/lucide-react/dist/esm/icons/database.mjs [app-rsc] (ecmascript) <export default as Database>");
;
;
;
function Card({ title, icon, children }) {
    return /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("section", {
        className: "rounded-2xl border border-slate-800 bg-slate-950/70 p-5 shadow-xl",
        children: [
            /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                className: "mb-3 flex items-center gap-2",
                children: [
                    /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                        className: "rounded-xl bg-slate-800 p-2",
                        children: icon
                    }, void 0, false, {
                        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                        lineNumber: 27,
                        columnNumber: 9
                    }, this),
                    /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("h2", {
                        className: "text-lg font-semibold tracking-tight",
                        children: title
                    }, void 0, false, {
                        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                        lineNumber: 28,
                        columnNumber: 9
                    }, this)
                ]
            }, void 0, true, {
                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                lineNumber: 26,
                columnNumber: 7
            }, this),
            children
        ]
    }, void 0, true, {
        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
        lineNumber: 25,
        columnNumber: 5
    }, this);
}
function Pre({ text, maxHeight = "max-h-96" }) {
    return /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("pre", {
        className: `${maxHeight} overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs leading-relaxed text-slate-300`,
        children: text || "Keine Daten gefunden."
    }, void 0, false, {
        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
        lineNumber: 37,
        columnNumber: 5
    }, this);
}
function Badge({ ok, label }) {
    return /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("span", {
        className: `rounded-full px-3 py-1 text-xs font-medium ${ok ? "bg-emerald-950 text-emerald-300 border border-emerald-800" : "bg-amber-950 text-amber-300 border border-amber-800"}`,
        children: [
            label,
            ": ",
            ok ? "OK" : "fehlt"
        ]
    }, void 0, true, {
        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
        lineNumber: 45,
        columnNumber: 5
    }, this);
}
function Page() {
    const data = (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$lib$2f$data$2e$ts__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["getMissionData"])();
    return /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("main", {
        className: "min-h-screen bg-[radial-gradient(circle_at_top_left,#172554,transparent_35%),radial-gradient(circle_at_bottom_right,#3b0764,transparent_30%),#05070a] p-6",
        children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
            className: "mx-auto max-w-7xl",
            children: [
                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("header", {
                    className: "mb-6 rounded-3xl border border-slate-800 bg-slate-950/80 p-6 shadow-2xl",
                    children: [
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "flex flex-col justify-between gap-4 md:flex-row md:items-end",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    children: [
                                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("p", {
                                            className: "mb-2 text-sm font-medium text-cyan-300",
                                            children: "Shadowmaker / OpenClaw"
                                        }, void 0, false, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 60,
                                            columnNumber: 15
                                        }, this),
                                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("h1", {
                                            className: "text-3xl font-bold tracking-tight md:text-5xl",
                                            children: "Mission Control"
                                        }, void 0, false, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 61,
                                            columnNumber: 15
                                        }, this),
                                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("p", {
                                            className: "mt-3 max-w-3xl text-slate-300",
                                            children: "Read-only Dashboard mit echten lokalen Daten aus Mission Control, Statusdokumenten und OpenClaw-Workspace-Kandidaten. Keine Mockdaten, keine Secrets, keine Schreibaktionen."
                                        }, void 0, false, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 62,
                                            columnNumber: 15
                                        }, this)
                                    ]
                                }, void 0, true, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 59,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "text-right text-xs text-slate-400",
                                    children: [
                                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                            children: [
                                                "Generated: ",
                                                data.generatedAt
                                            ]
                                        }, void 0, true, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 67,
                                            columnNumber: 15
                                        }, this),
                                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                            children: "Localhost only: 127.0.0.1:4173"
                                        }, void 0, false, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 68,
                                            columnNumber: 15
                                        }, this)
                                    ]
                                }, void 0, true, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 66,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 58,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "mt-5 flex flex-wrap gap-2",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Badge, {
                                    ok: data.exists.mission,
                                    label: "Mission"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 72,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Badge, {
                                    ok: data.exists.openclawWorkspace,
                                    label: "OpenClaw Workspace"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 73,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Badge, {
                                    ok: data.exists.base,
                                    label: "openclaw_training"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 74,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 71,
                            columnNumber: 11
                        }, this)
                    ]
                }, void 0, true, {
                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                    lineNumber: 57,
                    columnNumber: 9
                }, this),
                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("section", {
                    className: "mb-6 grid gap-4 md:grid-cols-4",
                    children: [
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "rounded-2xl border border-slate-800 bg-slate-950/70 p-4",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "text-sm text-slate-400",
                                    children: "Mission Files"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 80,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "mt-2 text-3xl font-bold",
                                    children: data.counts.missionFiles
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 81,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 79,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "rounded-2xl border border-slate-800 bg-slate-950/70 p-4",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "text-sm text-slate-400",
                                    children: "Status Files"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 84,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "mt-2 text-3xl font-bold",
                                    children: data.counts.statusFiles
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 85,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 83,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "rounded-2xl border border-slate-800 bg-slate-950/70 p-4",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "text-sm text-slate-400",
                                    children: "OpenClaw Workspace Files"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 88,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "mt-2 text-3xl font-bold",
                                    children: data.counts.openclawWorkspaceFiles
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 89,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 87,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                            className: "rounded-2xl border border-slate-800 bg-slate-950/70 p-4",
                            children: [
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "text-sm text-slate-400",
                                    children: "Mode"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 92,
                                    columnNumber: 13
                                }, this),
                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                    className: "mt-2 text-3xl font-bold text-emerald-300",
                                    children: "Read-only"
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 93,
                                    columnNumber: 13
                                }, this)
                            ]
                        }, void 0, true, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 91,
                            columnNumber: 11
                        }, this)
                    ]
                }, void 0, true, {
                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                    lineNumber: 78,
                    columnNumber: 9
                }, this),
                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                    className: "grid gap-5 lg:grid-cols-2",
                    children: [
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Tasks",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$clipboard$2d$list$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__ClipboardList$3e$__["ClipboardList"], {
                                className: "h-5 w-5 text-cyan-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 98,
                                columnNumber: 37
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.tasks
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 99,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 98,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Agent Crew",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$bot$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Bot$3e$__["Bot"], {
                                className: "h-5 w-5 text-purple-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 102,
                                columnNumber: 42
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.agents
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 103,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 102,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Daily Delight",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$sparkles$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Sparkles$3e$__["Sparkles"], {
                                className: "h-5 w-5 text-yellow-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 106,
                                columnNumber: 45
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.dailyDelight
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 107,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 106,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Memory Wiki",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$brain$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Brain$3e$__["Brain"], {
                                className: "h-5 w-5 text-pink-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 110,
                                columnNumber: 43
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: `${data.content.memoryIndex}\n\n--- decisions ---\n${data.content.decisions}`
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 111,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 110,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Projects",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$folder$2d$kanban$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__FolderKanban$3e$__["FolderKanban"], {
                                className: "h-5 w-5 text-blue-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 114,
                                columnNumber: 40
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.projects
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 115,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 114,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Security / Freeze Status",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$shield$2d$check$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__ShieldCheck$3e$__["ShieldCheck"], {
                                className: "h-5 w-5 text-emerald-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 118,
                                columnNumber: 56
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: `${data.content.phase3}\n\n--- latest freeze ---\n${data.content.freeze}`
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 119,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 118,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Workspace Audit",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$database$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Database$3e$__["Database"], {
                                className: "h-5 w-5 text-orange-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 122,
                                columnNumber: 47
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.workspaceAudit
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 123,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 122,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Docs Index",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$file$2d$text$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__FileText$3e$__["FileText"], {
                                className: "h-5 w-5 text-slate-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 126,
                                columnNumber: 42
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                className: "max-h-96 overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs",
                                children: data.docs.length === 0 ? /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("p", {
                                    children: "Keine Dokumente gefunden."
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 129,
                                    columnNumber: 17
                                }, this) : /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("ul", {
                                    className: "space-y-2",
                                    children: data.docs.map((d, i)=>/*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("li", {
                                            className: "border-b border-slate-900 pb-2",
                                            children: [
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "font-medium text-slate-200",
                                                    children: d.name
                                                }, void 0, false, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 134,
                                                    columnNumber: 23
                                                }, this),
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "text-slate-500",
                                                    children: d.path
                                                }, void 0, false, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 135,
                                                    columnNumber: 23
                                                }, this),
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "text-slate-600",
                                                    children: [
                                                        d.mtime,
                                                        " · ",
                                                        d.size,
                                                        " bytes"
                                                    ]
                                                }, void 0, true, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 136,
                                                    columnNumber: 23
                                                }, this)
                                            ]
                                        }, `${d.path}-${i}`, true, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 133,
                                            columnNumber: 21
                                        }, this))
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 131,
                                    columnNumber: 17
                                }, this)
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 127,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 126,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "OpenClaw Workspace Files",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$terminal$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Terminal$3e$__["Terminal"], {
                                className: "h-5 w-5 text-green-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 144,
                                columnNumber: 56
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                className: "max-h-96 overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs",
                                children: data.openclawFiles.length === 0 ? /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("p", {
                                    children: "Kein ~/.openclaw/workspace oder keine lesbaren Markdown/Text/JSON-Dateien gefunden."
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 147,
                                    columnNumber: 17
                                }, this) : /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("ul", {
                                    className: "space-y-2",
                                    children: data.openclawFiles.map((d, i)=>/*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("li", {
                                            className: "border-b border-slate-900 pb-2",
                                            children: [
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "font-medium text-slate-200",
                                                    children: d.name
                                                }, void 0, false, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 152,
                                                    columnNumber: 23
                                                }, this),
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "text-slate-500",
                                                    children: d.path
                                                }, void 0, false, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 153,
                                                    columnNumber: 23
                                                }, this),
                                                /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])("div", {
                                                    className: "text-slate-600",
                                                    children: [
                                                        d.mtime,
                                                        " · ",
                                                        d.size,
                                                        " bytes"
                                                    ]
                                                }, void 0, true, {
                                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                                    lineNumber: 154,
                                                    columnNumber: 23
                                                }, this)
                                            ]
                                        }, `${d.path}-${i}`, true, {
                                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                            lineNumber: 151,
                                            columnNumber: 21
                                        }, this))
                                }, void 0, false, {
                                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                    lineNumber: 149,
                                    columnNumber: 17
                                }, this)
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 145,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 144,
                            columnNumber: 11
                        }, this),
                        /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Card, {
                            title: "Today / Operating Loop",
                            icon: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(__TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$lucide$2d$react$2f$dist$2f$esm$2f$icons$2f$activity$2e$mjs__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__$3c$export__default__as__Activity$3e$__["Activity"], {
                                className: "h-5 w-5 text-red-300"
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 162,
                                columnNumber: 54
                            }, this),
                            children: /*#__PURE__*/ (0, __TURBOPACK__imported__module__$5b$project$5d2f$openclaw_training$2f$mission_control$2f$webui$2f$node_modules$2f$next$2f$dist$2f$server$2f$route$2d$modules$2f$app$2d$page$2f$vendored$2f$rsc$2f$react$2d$jsx$2d$dev$2d$runtime$2e$js__$5b$app$2d$rsc$5d$__$28$ecmascript$29$__["jsxDEV"])(Pre, {
                                text: data.content.today
                            }, void 0, false, {
                                fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                                lineNumber: 163,
                                columnNumber: 13
                            }, this)
                        }, void 0, false, {
                            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                            lineNumber: 162,
                            columnNumber: 11
                        }, this)
                    ]
                }, void 0, true, {
                    fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
                    lineNumber: 97,
                    columnNumber: 9
                }, this)
            ]
        }, void 0, true, {
            fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
            lineNumber: 56,
            columnNumber: 7
        }, this)
    }, void 0, false, {
        fileName: "[project]/openclaw_training/mission_control/webui/app/page.tsx",
        lineNumber: 55,
        columnNumber: 5
    }, this);
}
}),
"[project]/openclaw_training/mission_control/webui/app/page.tsx [app-rsc] (ecmascript, Next.js Server Component)", ((__turbopack_context__) => {

__turbopack_context__.n(__turbopack_context__.i("[project]/openclaw_training/mission_control/webui/app/page.tsx [app-rsc] (ecmascript)"));
}),
];

//# sourceMappingURL=%5Broot-of-the-server%5D__0ke4bb5._.js.map