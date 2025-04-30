// import { COURSE } from '$features/course/Course.store';
// import { MODULE } from '$features/modules/Module.Store';
import { lucia } from '$lib/app/auth/lucia.server';
// import { createContext } from '$lib/app/db/trps/trpcContext';
import { trpcHook } from '$lib/app/db/trps/trpcHooks';
// import AppCookiesHooks from '$lib/app/hooks/AppCookiesHooks.server';
// import { THEME } from '$lib/app/theme/theme.store';
// import { varParse } from '$lib/utils/utilData';
import type { LessonKinds } from '@prisma/client';
// import { appRouter } from '$lib/app/db/trps/trpcRouter';
// import { Router_auth, Router_Client } from '$lib/app/routes/appRoutes';
import { json, redirect, type Handle } from '@sveltejs/kit';
import { sequence } from '@sveltejs/kit/hooks';
import type { AppCache } from './app';
// import { createTRPCHandle } from 'trpc-sveltekit';

export const appHook: Handle = async ({ event, resolve }) => {
	const sessionId = event.cookies.get(lucia.sessionCookieName);
	if (!sessionId) {
		event.locals.user = null;
		event.locals.session = null;
		return resolve(event);
	}


	const { session, user } = await lucia.validateSession(sessionId);
	if (session && session.fresh) {
		const sessionCookie = lucia.createSessionCookie(session.id);
		event.cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});
	}
	if (!session) {
		const sessionCookie = lucia.createBlankSessionCookie();
		event.cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});
	}
	event.locals.user = user;
	event.locals.session = session;



	return resolve(event);
};

// export const trpcHook: Handle = createTRPCHandle({
// 	router: appRouter,
// 	createContext,
// 	onError({ error, type, path, input, ctx, req }) {
// 		if (error.code === 'INTERNAL_SERVER_ERROR') {
// 			// send to bug reporting
// 		}
// 	}
// });

export const handle = sequence(appHook, trpcHook);
