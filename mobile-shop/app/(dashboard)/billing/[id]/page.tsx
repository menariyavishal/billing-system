"use client";

import { useState, useEffect, useRef, use } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/hooks/useAuth";
import { getBill, voidBill } from "@/lib/api/billing";
import { useReactToPrint } from "react-to-print";
import InvoiceTemplate from "@/components/InvoiceTemplate";

export default function BillDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const router = useRouter();
  const { role } = useAuth();

  const unwrappedParams = use(params);
  const billId = unwrappedParams.id;

  const [bill, setBill] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [voiding, setVoiding] = useState(false);
  const [error, setError] = useState("");
  const [sendingWhatsapp, setSendingWhatsapp] = useState(false);
  const [whatsappStatus, setWhatsappStatus] = useState<{ type: "success" | "error"; message: string } | null>(null);

  const printComponentRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    loadBill();
  }, []);

  const loadBill = async () => {
    try {
      setLoading(true);
      const data = await getBill(parseInt(billId));
      setBill(data);
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handlePrint = useReactToPrint({
    contentRef: printComponentRef,
    documentTitle: `VCD_Invoice_${bill?.billNumber || ""}`,
  });

  const handleVoid = async () => {
    if (!confirm("Are you sure you want to void this bill? This action is irreversible and restores stock levels.")) {
      return;
    }
    setVoiding(true);
    setError("");
    try {
      await voidBill(parseInt(billId));
      await loadBill();
    } catch (err: any) {
      setError(err.message || "Failed to void invoice");
      setVoiding(false);
    }
  };

  const handleSendWhatsapp = async () => {
    if (!bill) return;
    const customerPhone = bill.customer?.phone || bill.customerPhone || "";
    if (!customerPhone) {
      setWhatsappStatus({ type: "error", message: "No customer phone number on this bill." });
      return;
    }
    try {
      setSendingWhatsapp(true);
      setWhatsappStatus(null);

      // Generate PDF client-side
      const { generateBillPdfBlob } = await import("@/lib/client-pdf");
      const blob = await generateBillPdfBlob(bill);

      // Upload PDF and trigger WhatsApp delivery
      const formData = new FormData();
      formData.append("file", blob, `VCD_Invoice_${bill.billNumber}.pdf`);
      formData.append("customerName", bill.customer?.name || bill.customerName || "Customer");
      formData.append("customerAddress", bill.customer?.address || "");
      formData.append("mobileNumber", customerPhone);
      formData.append("billNumber", bill.billNumber);

      const res = await fetch(`/api/v1/bills/${bill.id}/whatsapp/upload`, {
        method: "POST",
        body: formData,
      });

      const data = await res.json();
      if (res.ok && data.success) {
        setWhatsappStatus({ type: "success", message: `Invoice sent to ${customerPhone} via WhatsApp!` });
      } else {
        setWhatsappStatus({ type: "error", message: data.error || "Failed to send WhatsApp message." });
      }
    } catch (err: any) {
      console.error("WhatsApp send error:", err);
      setWhatsappStatus({ type: "error", message: err.message || "Failed to send WhatsApp message." });
    } finally {
      setSendingWhatsapp(false);
    }
  };

  // Check if same calendar day
  const isSameDay = () => {
    if (!bill) return false;
    const billDate = new Date(bill.createdAt);
    const today = new Date();
    return (
      billDate.getFullYear() === today.getFullYear() &&
      billDate.getMonth() === today.getMonth() &&
      billDate.getDate() === today.getDate()
    );
  };

  if (loading) return <div className="text-center py-10">Loading invoice...</div>;
  if (!bill) return <div className="text-center py-10 text-red-500">Invoice not found</div>;

  return (
    <div className="max-w-4xl mx-auto space-y-4 sm:space-y-6">
      {/* Top action bar */}
      <div className="bg-white p-3.5 sm:p-5 rounded-2xl shadow-sm border border-gray-100 flex flex-col md:flex-row md:justify-between md:items-center gap-3 sm:gap-4">
        {/* Navigation & Bill Info */}
        <div className="flex flex-wrap items-center justify-between sm:justify-start gap-2.5 sm:gap-3">
          <button
            onClick={() => router.push("/billing/history")}
            className="inline-flex items-center gap-1.5 text-gray-700 hover:text-gray-900 font-bold text-xs sm:text-sm bg-gray-100 hover:bg-gray-200 active:scale-95 px-3 py-1.5 rounded-xl transition-all whitespace-nowrap"
          >
            <span>←</span> Back to History
          </button>
          
          <div className="hidden sm:block h-4 w-[1px] bg-gray-200"></div>

          <div className="flex items-center gap-2">
            <span className="font-extrabold text-gray-900 text-sm sm:text-base">
              Bill #{bill.billNumber}
            </span>
            <span
              className={`px-2.5 py-0.5 inline-flex text-[10px] sm:text-xs font-bold rounded-full uppercase tracking-wider ${
                bill.status === "voided"
                  ? "bg-red-100 text-red-700 border border-red-200"
                  : "bg-emerald-100 text-emerald-800 border border-emerald-200"
              }`}
            >
              {bill.status}
            </span>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="flex flex-wrap sm:flex-nowrap items-center gap-2 w-full md:w-auto">
          {bill.status !== "voided" && (
            <button
              onClick={handleSendWhatsapp}
              disabled={sendingWhatsapp}
              className="flex-1 sm:flex-initial inline-flex items-center justify-center gap-1.5 bg-emerald-600 hover:bg-emerald-700 active:scale-95 text-white font-bold py-2 px-3 sm:px-4 rounded-xl text-xs sm:text-sm shadow-sm hover:shadow transition-all disabled:opacity-50 whitespace-nowrap"
            >
              {sendingWhatsapp ? (
                <>
                  <span className="animate-spin inline-block w-3.5 h-3.5 border-2 border-white border-t-transparent rounded-full"></span>
                  <span>Sending...</span>
                </>
              ) : (
                <>
                  <span>📲</span>
                  <span>Send via WhatsApp</span>
                </>
              )}
            </button>
          )}

          {bill.status !== "voided" && (
            <button
              onClick={handlePrint}
              className="flex-1 sm:flex-initial inline-flex items-center justify-center gap-1.5 bg-blue-600 hover:bg-blue-700 active:scale-95 text-white font-bold py-2 px-3 sm:px-4 rounded-xl text-xs sm:text-sm shadow-sm hover:shadow transition-all whitespace-nowrap"
            >
              <span>🖨️</span>
              <span>Print Receipt</span>
            </button>
          )}

          {role === "owner" && bill.status !== "voided" && !bill.isSettled && isSameDay() && (
            <button
              onClick={handleVoid}
              disabled={voiding}
              className="w-full sm:w-auto inline-flex items-center justify-center gap-1.5 bg-red-600 hover:bg-red-700 active:scale-95 text-white font-bold py-2 px-3 sm:px-4 rounded-xl text-xs sm:text-sm shadow-sm hover:shadow transition-all disabled:opacity-50 whitespace-nowrap"
            >
              <span>🚫</span>
              <span>{voiding ? "Voiding..." : "Void Bill"}</span>
            </button>
          )}
        </div>
      </div>

      {error && <div className="text-red-600 bg-red-50 p-3 rounded-xl text-sm font-semibold border border-red-100">{error}</div>}

      {whatsappStatus && (
        <div className={`p-3 rounded-xl text-sm font-semibold ${whatsappStatus.type === "success"
          ? "bg-green-50 text-green-700 border border-green-200"
          : "bg-red-50 text-red-700 border border-red-200"
          }`}>
          {whatsappStatus.type === "success" ? "✅" : "❌"} {whatsappStatus.message}
        </div>
      )}

      {/* Invoice sheet preview */}
      <div className="bg-gray-50 p-2 sm:p-6 md:p-8 rounded-2xl shadow-sm border border-gray-100 overflow-x-auto flex justify-center">
        <div
          ref={printComponentRef}
          className="p-1"
          style={{ width: "100%", maxWidth: "800px", margin: "0 auto" }}
        >
          <InvoiceTemplate
            isDraft={false}
            billNumber={bill.billNumber}
            createdAt={bill.createdAt}
            customerName={bill.customer?.name || bill.customerName || "Guest Customer"}
            customerAddress={bill.customer?.address || undefined}
            customerPhone={bill.customer?.phone || bill.customerPhone || ""}
            cartItems={bill.billItems || []}
            subtotal={Number(bill.subtotal)}
            grossTotal={Number(bill.totalAmount)}
            discount={Number(bill.discount)}
            totalAmount={Number(bill.totalAmount)}
            sgstPercent={bill.sgstPercent?.toString() || "0"}
            cgstPercent={bill.cgstPercent?.toString() || "0"}
            paidAmount={Number(bill.paidAmount || 0)}
            dueAmount={Number(bill.dueAmount || 0)}
            paymentMode={bill.paymentMode || "cash"}
          />
        </div>
      </div>
    </div>
  );
}
