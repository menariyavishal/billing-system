const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const todayBills = await prisma.bill.findMany({
    where: { status: 'completed', createdAt: { gte: todayStart } },
    include: { billItems: { include: { product: true, productUnit: true } } }
  });
  
  for (const b of todayBills) {
    console.log(`Bill: ${b.billNumber} | Subtotal: ${b.subtotal} | Discount: ${b.discount}`);
  }
}

main().catch(console.error).finally(() => prisma.$disconnect());
