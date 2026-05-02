import { getMissionData } from "../lib/data";
import {
  ShieldCheck,
  Terminal,
  Brain,
  ClipboardList,
  Bot,
  FolderKanban,
  FileText,
  Sparkles,
  Activity,
  Database
} from "lucide-react";

function Card({
  title,
  icon,
  children
}: {
  title: string;
  icon: React.ReactNode;
  children: React.ReactNode;
}) {
  return (
    <section className="rounded-2xl border border-slate-800 bg-slate-950/70 p-5 shadow-xl">
      <div className="mb-3 flex items-center gap-2">
        <div className="rounded-xl bg-slate-800 p-2">{icon}</div>
        <h2 className="text-lg font-semibold tracking-tight">{title}</h2>
      </div>
      {children}
    </section>
  );
}

function Pre({ text, maxHeight = "max-h-96" }: { text: string; maxHeight?: string }) {
  return (
    <pre className={`${maxHeight} overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs leading-relaxed text-slate-300`}>
      {text || "Keine Daten gefunden."}
    </pre>
  );
}

function Badge({ ok, label }: { ok: boolean; label: string }) {
  return (
    <span className={`rounded-full px-3 py-1 text-xs font-medium ${ok ? "bg-emerald-950 text-emerald-300 border border-emerald-800" : "bg-amber-950 text-amber-300 border border-amber-800"}`}>
      {label}: {ok ? "OK" : "fehlt"}
    </span>
  );
}

export default function Page() {
  const data = getMissionData();

  return (
    <main className="min-h-screen bg-[radial-gradient(circle_at_top_left,#172554,transparent_35%),radial-gradient(circle_at_bottom_right,#3b0764,transparent_30%),#05070a] p-6">
      <div className="mx-auto max-w-7xl">
        <header className="mb-6 rounded-3xl border border-slate-800 bg-slate-950/80 p-6 shadow-2xl">
          <div className="flex flex-col justify-between gap-4 md:flex-row md:items-end">
            <div>
              <p className="mb-2 text-sm font-medium text-cyan-300">Shadowmaker / OpenClaw</p>
              <h1 className="text-3xl font-bold tracking-tight md:text-5xl">Mission Control</h1>
              <p className="mt-3 max-w-3xl text-slate-300">
                Read-only Dashboard mit echten lokalen Daten aus Mission Control, Statusdokumenten und OpenClaw-Workspace-Kandidaten. Keine Mockdaten, keine Secrets, keine Schreibaktionen.
              </p>
            </div>
            <div className="text-right text-xs text-slate-400">
              <div>Generated: {data.generatedAt}</div>
              <div>Localhost only: 127.0.0.1:4173</div>
            </div>
          </div>
          <div className="mt-5 flex flex-wrap gap-2">
            <Badge ok={data.exists.mission} label="Mission" />
            <Badge ok={data.exists.openclawWorkspace} label="OpenClaw Workspace" />
            <Badge ok={data.exists.base} label="openclaw_training" />
          </div>
        </header>

        <section className="mb-6 grid gap-4 md:grid-cols-4">
          <div className="rounded-2xl border border-slate-800 bg-slate-950/70 p-4">
            <div className="text-sm text-slate-400">Mission Files</div>
            <div className="mt-2 text-3xl font-bold">{data.counts.missionFiles}</div>
          </div>
          <div className="rounded-2xl border border-slate-800 bg-slate-950/70 p-4">
            <div className="text-sm text-slate-400">Status Files</div>
            <div className="mt-2 text-3xl font-bold">{data.counts.statusFiles}</div>
          </div>
          <div className="rounded-2xl border border-slate-800 bg-slate-950/70 p-4">
            <div className="text-sm text-slate-400">OpenClaw Workspace Files</div>
            <div className="mt-2 text-3xl font-bold">{data.counts.openclawWorkspaceFiles}</div>
          </div>
          <div className="rounded-2xl border border-slate-800 bg-slate-950/70 p-4">
            <div className="text-sm text-slate-400">Mode</div>
            <div className="mt-2 text-3xl font-bold text-emerald-300">Read-only</div>
          </div>
        </section>

        <div className="grid gap-5 lg:grid-cols-2">
          <Card title="Tasks" icon={<ClipboardList className="h-5 w-5 text-cyan-300" />}>
            <Pre text={data.content.tasks} />
          </Card>

          <Card title="Agent Crew" icon={<Bot className="h-5 w-5 text-purple-300" />}>
            <Pre text={data.content.agents} />
          </Card>

          <Card title="Daily Delight" icon={<Sparkles className="h-5 w-5 text-yellow-300" />}>
            <Pre text={data.content.dailyDelight} />
          </Card>

          <Card title="Memory Wiki" icon={<Brain className="h-5 w-5 text-pink-300" />}>
            <Pre text={`${data.content.memoryIndex}\n\n--- decisions ---\n${data.content.decisions}`} />
          </Card>

          <Card title="Projects" icon={<FolderKanban className="h-5 w-5 text-blue-300" />}>
            <Pre text={data.content.projects} />
          </Card>

          <Card title="Security / Freeze Status" icon={<ShieldCheck className="h-5 w-5 text-emerald-300" />}>
            <Pre text={`${data.content.phase3}\n\n--- latest freeze ---\n${data.content.freeze}`} />
          </Card>

          <Card title="Workspace Audit" icon={<Database className="h-5 w-5 text-orange-300" />}>
            <Pre text={data.content.workspaceAudit} />
          </Card>

          <Card title="Docs Index" icon={<FileText className="h-5 w-5 text-slate-300" />}>
            <div className="max-h-96 overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs">
              {data.docs.length === 0 ? (
                <p>Keine Dokumente gefunden.</p>
              ) : (
                <ul className="space-y-2">
                  {data.docs.map((d, i) => (
                    <li key={`${d.path}-${i}`} className="border-b border-slate-900 pb-2">
                      <div className="font-medium text-slate-200">{d.name}</div>
                      <div className="text-slate-500">{d.path}</div>
                      <div className="text-slate-600">{d.mtime} · {d.size} bytes</div>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </Card>

          <Card title="OpenClaw Workspace Files" icon={<Terminal className="h-5 w-5 text-green-300" />}>
            <div className="max-h-96 overflow-auto rounded-xl border border-slate-800 bg-black/40 p-4 text-xs">
              {data.openclawFiles.length === 0 ? (
                <p>Kein ~/.openclaw/workspace oder keine lesbaren Markdown/Text/JSON-Dateien gefunden.</p>
              ) : (
                <ul className="space-y-2">
                  {data.openclawFiles.map((d, i) => (
                    <li key={`${d.path}-${i}`} className="border-b border-slate-900 pb-2">
                      <div className="font-medium text-slate-200">{d.name}</div>
                      <div className="text-slate-500">{d.path}</div>
                      <div className="text-slate-600">{d.mtime} · {d.size} bytes</div>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </Card>

          <Card title="Today / Operating Loop" icon={<Activity className="h-5 w-5 text-red-300" />}>
            <Pre text={data.content.today} />
          </Card>
        </div>
      </div>
    </main>
  );
}
