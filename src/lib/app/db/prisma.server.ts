// src/lib/db/prisma.ts

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
export default prisma;

// ======================

// const globalForPrisma = global as unknown as { prisma: PrismaClient | undefined };

// // Use the existing `PrismaClient` instance in `globalForPrisma`, or create a new one if it doesn’t exist.
// const prisma = globalForPrisma.prisma ?? new PrismaClient();

// // In non-serverless environments, save the `PrismaClient` instance to the global object.
// if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;

// export default prisma;
