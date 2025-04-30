import type { RequestEvent } from '@sveltejs/kit';

export async function createContext(event: RequestEvent) {
	return {
		event, // 👈 `event` is now available in your context
		user: event.locals?.user,
		session: event.locals?.session
	};
}

export type TrpcContext = Awaited<ReturnType<typeof createContext>>;
