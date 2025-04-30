import { TRPCError } from '@trpc/server';
import { t } from '../trpc';

export const trpcUseAuth = t.middleware(async ({ next, ctx }) => {
	if (!ctx.user?.id) throw new TRPCError({ code: 'UNAUTHORIZED' });
	return next();
});
