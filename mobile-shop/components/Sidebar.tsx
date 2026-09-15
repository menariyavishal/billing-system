"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

interface SidebarProps {
  isOwner: boolean;
}

export default function Sidebar({ isOwner }: SidebarProps) {
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
    // Check if the current pathname matches the link's href.
    // We use exact match for /billing because /billing/history also starts with /billing
    const isActive = 
      link.href === "/billing" 
        ? pathname === "/billing"
        : pathname.startsWith(link.href);

    return (
      <Link
        key={link.href}
        href={link.href}
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
  );
}
