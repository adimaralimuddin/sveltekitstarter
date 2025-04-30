import { createContext } from '$lib/app/db/trps/trpcContext';
import type { Handle } from '@sveltejs/kit';
import { createTRPCHandle } from 'trpc-sveltekit';
import { appRouter } from './trpcRouter';

export const trpcHook: Handle = createTRPCHandle({
	router: appRouter,
	createContext,
	onError({ error, type, path, input, ctx, req }) {
		if (error.code === 'INTERNAL_SERVER_ERROR') {
			// send to bug reporting
		}
	}
});
