import NextAuthSessionProvider from "@/components/providers/SessionProvider";
import Link from "next/link";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { redirect } from "next/navigation";
import NotificationBell from "@/components/NotificationBell";
import Sidebar from "@/components/Sidebar";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await getServerSession(authOptions);

  if (!session) {
    redirect("/login");
  }

  const isOwner = session.user.role === "owner";

  return (
    <NextAuthSessionProvider>
      <div className="min-h-screen bg-gray-100 flex">
        {/* Sidebar */}
        <Sidebar isOwner={isOwner} />

        {/* Main Content */}
        <div className="flex-1 flex flex-col min-w-0">
          <header className="h-16 bg-white shadow-sm flex items-center justify-between px-6">
            <div className="md:hidden text-lg font-bold text-black">Shree Krishna Computer</div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-600 font-medium">
                {session.user.role === "owner" ? "Welcome Lalit Menariya" : `Welcome ${session.user.name}`}
              </span>
              <NotificationBell />
              <Link
                href="/api/auth/signout"
                className="text-sm font-medium text-red-600 hover:text-red-800"
              >
                Logout
              </Link>
            </div>
          </header>
          <main className="flex-1 p-6">{children}</main>
        </div>
      </div>
    </NextAuthSessionProvider>
  );
}
