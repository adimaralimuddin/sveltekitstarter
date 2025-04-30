// import * as Err from '$lib/app/errors';
import { initTRPC, TRPCError } from '@trpc/server';
import type { TrpcContext } from './trpcContext';

// { NoOrganizationError, type ErrCode }

export const t = initTRPC.context<TrpcContext>().create();

export const publicProcedure = t.procedure;
export const TRPCRouter = t.router;

export type TRPCStatus = 'fetching' | 'idle' | 'success' | 'fail';

export type TRPCApiError = {
	meta: {
		response: object;
		responseJSON: [
			{
				error: {
					message: string;
					code: number;
					data: {
						code: TRPCError['code'];
						httpStatus: number;
						stack: string;
						path: string;
					};
				};
			}
		];
	};
	shape: {
		message: string;
		code: number;
		data: {
			code: TRPCError['code'];
			httpStatus: number;
			stack: string;
			path: string;
		};
	};
	data: {
		code: TRPCError['code'];
		httpStatus: number;
		stack: string;
		path: string;
	};
	name: string;
};
