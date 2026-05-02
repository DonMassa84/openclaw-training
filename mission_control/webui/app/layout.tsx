import "./globals.css";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Shadowmaker Mission Control",
  description: "Read-only local dashboard for Shadowmaker/OpenClaw"
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="de">
      <body>{children}</body>
    </html>
  );
}
