import { lucia } from '$lib/app/auth/lucia.server';
import prisma from '$lib/app/db/prisma.server';
import { fail, redirect, type Actions } from '@sveltejs/kit';
import { Argon2id } from 'oslo/password';

export const load = async ({ locals }) => {
	if (locals?.user) throw redirect(302, '/profile');
};

export const actions: Actions = {
	default: async ({ request, cookies, url }) => {
		const { email, password } = Object.fromEntries(await request.formData()) as Record<
			string,
			string
		>;

		const user = await prisma.user.findFirst({
			where: {
				email: email
			}
		});

		if (!user) {
			return fail(400, { success: false, msg: 'Incorrect username or password' });
		}

		if (!user?.password_hash) return fail(400, { msg: 'user has no password_hash' });

		const validPassword = await new Argon2id().verify(user.password_hash, password);
		if (!validPassword) {
			return fail(400, { msg: 'Incorrect username or password' });
		}

		const session = await lucia.createSession(user.id, []);
		const sessionCookie = lucia.createSessionCookie(session.id);
		cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});
		// console.log('about to redirect userId: ', user?.id);
		// return { success: true };
		const from = url.searchParams.get('from');
		throw redirect(303, from || '/profile');
		// redirect(303, '/accounts/profile');
	}
};
