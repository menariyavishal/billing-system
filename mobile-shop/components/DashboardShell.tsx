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

  return (
    <div className="min-h-screen bg-gray-100 flex">
      {/* Mobile Sidebar Overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40 md:hidden"
          onClick={() => setSidebarOpen(false)}
          aria-hidden="true"
        />
      )}

      {/* Sidebar */}
      <Sidebar isOwner={isOwner} isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

      {/* Main Content */}
      <div className="flex-1 flex flex-col min-w-0">
        <header className="min-h-16 bg-white shadow-sm flex items-center justify-between gap-2 px-2 sm:px-6 py-2">
          <div className="flex min-w-0 items-center gap-1 sm:gap-3">
            {/* Mobile Menu Button */}
            <button
              className="md:hidden shrink-0 p-2 rounded-lg text-gray-600 hover:bg-gray-100 transition-colors"
              onClick={() => setSidebarOpen(true)}
              aria-label="Open navigation menu"
              aria-expanded={sidebarOpen}
            >
              {sidebarOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
            <div className="md:hidden min-w-0 flex items-center gap-2">
              <img src="/logovcd.png" alt="Logo" className="w-7 h-7 object-contain rounded" />
              <span className="truncate text-sm sm:text-base font-bold text-black">Vision Codex Demo</span>
            </div>
            <div className="hidden md:flex min-w-0 items-center gap-2">
              <img src="/logovcd.png" alt="Logo" className="w-8 h-8 object-contain rounded" />
              <span className="text-lg font-bold text-black">Vision Codex Demo</span>
            </div>
          </div>
          <div className="flex shrink-0 items-center space-x-1 sm:space-x-4">
            <span className="hidden sm:block text-sm text-gray-600 font-medium">
              {isOwner ? "Welcome Vision Codex" : `Welcome ${user.name || ""}`}
            </span>
            <span className="sm:hidden text-xs text-gray-600 font-medium">
              {isOwner ? "Owner" : user.name || ""}
            </span>
            <NotificationBell />
            <Link
              href="/api/auth/signout"
              className="text-sm font-medium text-red-600 hover:text-red-800 hidden sm:block"
            >
              Logout
            </Link>
            <Link
              href="/api/auth/signout"
              className="text-red-600 hover:text-red-800 p-2 sm:hidden"
              aria-label="Logout"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
              </svg>
            </Link>
          </div>
        </header>
        <main className="min-w-0 flex-1 overflow-x-hidden p-3 sm:p-6">{children}</main>
      </div>
    </div>
  );
}
