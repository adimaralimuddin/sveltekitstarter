// src/lib/server/auth.ts
import { dev } from '$app/environment';
import { PrismaAdapter } from '@lucia-auth/adapter-prisma';
import { PrismaClient, Subscription, UserRole } from '@prisma/client';
import { Lucia } from 'lucia';

const client = new PrismaClient();

const adapter = new PrismaAdapter(client.session, client.user);

export const lucia = new Lucia(adapter, {
	sessionCookie: {
		attributes: {
			// set to `true` when using HTTPS
			secure: !dev
		}
	},
	getUserAttributes: (attr) => {
		return {
			email: attr.email,
			role: attr.role,
			lessonId: attr.lessonId,
			courseId: attr.courseId,
			avatar: attr.avatar,
			username: attr.username,
			subscription: attr.subscription
		};
	}
});

declare module 'lucia' {
	interface Register {
		Lucia: typeof lucia;
		DatabaseUserAttributes: DatabaseUserAttributes;
	}
}

interface DatabaseUserAttributes {
	email: string;
	role: UserRole;
	lessonId: string;
	courseId: string;
	avatar: string;
	username: string;
	subscription: Subscription;
}
