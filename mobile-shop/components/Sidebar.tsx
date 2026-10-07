"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { X } from "lucide-react";

interface SidebarProps {
  isOwner: boolean;
  isOpen?: boolean;
  onClose?: () => void;
}

export default function Sidebar({ isOwner, isOpen = false, onClose }: SidebarProps) {
  const pathname = usePathname();

  const navLinks = [
    { name: "Dashboard", href: "/dashboard" },
    { name: "Billing", href: "/billing" },
    { name: "Billing History", href: "/billing/history" },
    { name: "Due Payments", href: "/due-payments" },
    { name: "Finance", href: "/finance" },
    { name: "Inventory", href: "/inventory" },
  ];

  const ownerLinks = [
    { name: "Analytics", href: "/analytics" },
    { name: "Staff Management", href: "/staff-management" },
  ];

  const renderLink = (link: { name: string; href: string }) => {
    const isActive = 
      link.href === "/billing" 
        ? pathname === "/billing"
        : pathname.startsWith(link.href);

    return (
      <Link
        key={link.href}
        href={link.href}
        onClick={onClose}
        className={`block px-4 py-2 rounded-md font-medium transition-colors ${
          isActive 
            ? "bg-blue-100 text-blue-700" 
            : "text-gray-700 hover:bg-gray-50 hover:text-blue-600"
        }`}
      >
        {link.name}
      </Link>
    );
  };

  return (
    <>
      {/* Mobile Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-50 w-64 bg-white shadow-xl transform transition-transform duration-300 ease-in-out md:hidden ${
          isOpen ? "translate-x-0" : "-translate-x-full"
        }`}
        aria-label="Sidebar navigation"
      >
        <div className="h-16 flex items-center justify-between px-4 border-b border-gray-200">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-lg overflow-hidden flex-shrink-0 bg-white border border-gray-100 flex items-center justify-center shadow-sm">
              <img src="/logovcd.png" alt="Logo" className="w-full h-full object-contain" />
            </div>
            <div>
              <h1 className="text-lg font-bold text-black leading-tight">Vision Codex Demo</h1>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-lg text-gray-600 hover:bg-gray-100 transition-colors"
            aria-label="Close sidebar"
          >
            <X className="w-6 h-6" />
          </button>
        </div>
        <nav className="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
          {navLinks.map(renderLink)}
          {isOwner && ownerLinks.map(renderLink)}
        </nav>
      </aside>

      {/* Desktop Sidebar */}
      <aside className="w-64 bg-white shadow-md flex-shrink-0 hidden md:flex flex-col z-10">
        <div className="h-20 flex items-center gap-3 px-5 border-b border-gray-200">
          <div className="w-10 h-10 rounded-lg overflow-hidden flex-shrink-0 bg-white border border-gray-100 flex items-center justify-center shadow-sm">
            <img src="/logovcd.png" alt="Logo" className="w-full h-full object-contain" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-black leading-tight">Vision Codex Demo</h1>
            <p className="text-xs text-gray-500 font-semibold mt-0.5">Owner: Vision Codex</p>
          </div>
        </div>
        <nav className="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
          {navLinks.map(renderLink)}
          {isOwner && ownerLinks.map(renderLink)}
        </nav>
      </aside>
    </>
  );
}