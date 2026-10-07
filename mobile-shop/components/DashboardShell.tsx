"use client";

import { useState } from "react";
import Link from "next/link";
import NotificationBell from "@/components/NotificationBell";
import Sidebar from "@/components/Sidebar";
import { Menu, X } from "lucide-react";

interface DashboardShellProps {
  children: React.ReactNode;
  user: {
    name?: string | null;
    role?: string | null;
  };
}

export default function DashboardShell({ children, user }: DashboardShellProps) {
  const isOwner = user.role === "owner";
  const [sidebarOpen, setSidebarOpen] = useState(false);

  // Generate initials for avatar
  const initials = user.name
    ? user.name.split(" ").map((n) => n[0]).join("").toUpperCase().slice(0, 2)
    : "U";

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Mobile Sidebar Overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-40 md:hidden"
          onClick={() => setSidebarOpen(false)}
          aria-hidden="true"
        />
      )}

      {/* Sidebar */}
      <Sidebar isOwner={isOwner} isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

      {/* Main Content */}
      <div className="flex-1 flex flex-col min-w-0">
        {/* Premium Header */}
        <header className="sticky top-0 z-30 bg-white border-b border-gray-200 shadow-sm">
          <div className="flex items-center justify-between gap-2 px-3 sm:px-6 py-0 h-14 sm:h-16">
            {/* Left: Hamburger + Brand */}
            <div className="flex min-w-0 items-center gap-2 sm:gap-3">
              <button
                className="md:hidden shrink-0 p-2 rounded-xl text-gray-600 hover:bg-gray-100 active:bg-gray-200 transition-all duration-150"
                onClick={() => setSidebarOpen(true)}
                aria-label="Open navigation menu"
                aria-expanded={sidebarOpen}
              >
                {sidebarOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
              </button>

              <div className="flex min-w-0 items-center gap-2">
                <img src="/logovcd.png" alt="Logo" className="w-7 h-7 sm:w-8 sm:h-8 object-contain rounded-lg shrink-0" />
                <div className="min-w-0">
                  <span className="block truncate text-sm sm:text-base font-extrabold text-gray-900 leading-tight">
                    Vision Codex
                  </span>
                  <span className="hidden sm:block text-[10px] text-gray-400 font-medium leading-tight tracking-wide uppercase">
                    {isOwner ? "Owner Dashboard" : "Staff Portal"}
                  </span>
                </div>
              </div>
            </div>

            {/* Right: Role badge, Notifications, User, Logout */}
            <div className="flex shrink-0 items-center gap-1.5 sm:gap-3">
              {/* Role Badge — desktop only */}
              <span className={`hidden sm:inline-flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider px-2.5 py-1 rounded-full border ${
                isOwner
                  ? "bg-violet-50 text-violet-700 border-violet-200"
                  : "bg-blue-50 text-blue-700 border-blue-200"
              }`}>
                {isOwner ? "👑 Owner" : "🧑‍💼 Staff"}
              </span>

              <NotificationBell />

              {/* User Avatar Pill */}
              <div className="flex items-center gap-1.5 pl-1.5 sm:pl-2">
                <div className={`w-7 h-7 sm:w-8 sm:h-8 rounded-full flex items-center justify-center text-[11px] font-extrabold text-white shrink-0 ${
                  isOwner ? "bg-violet-600" : "bg-blue-600"
                }`}>
                  {initials}
                </div>
                <span className="hidden sm:block text-sm font-semibold text-gray-700 max-w-[120px] truncate">
                  {isOwner ? "Owner" : user.name || ""}
                </span>
              </div>

              {/* Logout */}
              <Link
                href="/api/auth/signout"
                className="hidden sm:flex items-center gap-1.5 text-xs font-bold text-red-500 hover:text-red-700 hover:bg-red-50 border border-red-100 hover:border-red-300 px-2.5 py-1.5 rounded-lg transition-all duration-150"
              >
                <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
                Logout
              </Link>
              <Link
                href="/api/auth/signout"
                className="sm:hidden p-2 rounded-xl text-red-500 hover:bg-red-50 transition-colors"
                aria-label="Logout"
              >
                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
              </Link>
            </div>
          </div>
        </header>

        <main className="min-w-0 flex-1 overflow-x-hidden p-3 sm:p-6">{children}</main>
      </div>
    </div>
  );
}
