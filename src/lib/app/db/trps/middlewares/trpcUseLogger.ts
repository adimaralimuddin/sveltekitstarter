import { t } from '../trpc';

// export const trpcUseLogger = t.middleware(async ({ next }) => {
// 	console.log('trpc logger: ', next);
// 	return next();
// });

export const trpcUseLogger = t.middleware(async ({ path, type, next }) => {
	const start = Date.now();
	const result = await next();
	const ms = Date.now() - start;
	console.log(`${result.ok ? 'OK' : 'ERR'} ${type} ${path} - ${ms}ms`);
	return result;
});
