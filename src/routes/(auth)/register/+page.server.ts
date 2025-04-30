import { lucia } from '$lib/app/auth/lucia.server.js';
import prisma from '$lib/app/db/prisma.server.js';
import { fail, redirect } from '@sveltejs/kit';
import { generateId } from 'lucia';
import { Argon2id } from 'oslo/password';
import type { PageServerLoad } from './$types.js';

export const load: PageServerLoad = async (event) => {
	if (event.locals.user) redirect(302, '/accounts/profile');
};

export const actions = {
	default: async ({ request, cookies }) => {
		const data = await request.formData();
		const { email, password } = Object.fromEntries(data) as Record<string, string>;

		const userId = generateId(15);
		const hashedPassword = await new Argon2id().hash(password);

		const existingUser = await prisma.user.findUnique({
			where: { email }
		});

		if (existingUser)
			return fail(401, { success: false, msg: 'email already registered. try login in!' });
		const user = await prisma.user.create({
			data: {
				id: userId,
				email: email,
				password_hash: hashedPassword
				// username: String(Math.random() * 1000),
				// avatar: 'defaultAvatar.png'
			}
		});

		// console.log('user created', user);

		const session = await lucia.createSession(user.id, {});
		const sessionCookie = lucia.createSessionCookie(session.id);
		cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});

		console.log('registered successfully!');

		redirect(301, '/login');
	}
};
