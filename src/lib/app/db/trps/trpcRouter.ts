// import courseRouter from '$features/course/course.router';
// import lessonStatRouter from '$features/lessonStat/lessonStat.router';
// import moduleStatRouter from '$features/moduleStat/moduleStat.router';
// import { translatorTranslateProcedure } from '$features/translator/translatorServer';
// import { default as corseRouter, default as corseRouter } from '$lib/features/cores/corseRouter';
// import { elemRouter } from '$lib/features/elems/elemRouter';
// import lessonRouter from '$lib/features/lessons/Lesson.Router';
// import { lineRouter } from '$lib/features/lines/lineRouter';
// import ModuleRouter from '$lib/features/modules/Module.Router';
// import { stepRouter } from '$lib/features/steps/stepRouter';
// import playRouter from '$lib/modules/play/playRouter';
// import reportRouter from '$lib/modules/reports/report.router';
// import userRouter from '$lib/modules/user/userRouter';
// import welcomeRouter from '$lib/modules/welcome/welcomeRouter';
import type { inferRouterInputs, inferRouterOutputs } from '@trpc/server';
// import testRouter from '../../../../routes/editor/(editorSideBar)/test/test.router';
import { t, TRPCRouter } from './trpc';

export const appRouter = TRPCRouter({
	// test: testRouter,
	// step: stepRouter,
	// line: lineRouter,
	// elem: elemRouter,
	// play: playRouter,
	// module: ModuleRouter,
	// course: courseRouter,
	// welcome: welcomeRouter,
	// user: userRouter,
	// lesson: lessonRouter,
	// moduleStat: moduleStatRouter,
	// lessonStat: lessonStatRouter,
	// core: corseRouter,
	// reports: reportRouter,
	// tools: TRPCRouter({
	// 	translator: translatorTranslateProcedure
	// })
});

export const createCaller = t.createCallerFactory(appRouter);

export type AppRouter = typeof appRouter;
export type RouterInputs = inferRouterInputs<AppRouter>;
export type RouterOutputs = inferRouterOutputs<AppRouter>;
