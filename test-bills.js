const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const bills = await prisma.bill.findMany({
    where: { billNumber: { contains: '314' } },
    include: { billItems: { include: { productUnit: true, product: true } } }
  });
  console.dir(bills, { depth: null });
  
  const bills2 = await prisma.bill.findMany({
    where: { billNumber: { contains: '313' } },
    include: { billItems: { include: { productUnit: true, product: true } } }
  });
  console.dir(bills2, { depth: null });
}

main().catch(console.error).finally(() => prisma.$disconnect());
