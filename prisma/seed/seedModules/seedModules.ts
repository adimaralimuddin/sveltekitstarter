import prisma from '$lib/app/db/prisma.server';

export async function seedModules(args: {
	courseId: string;
	lang: string;
	count: number;
	langName: string;
}) {
	const mods = new Array(args.count).fill({}).map((m, ind) => ({
		id: String(ind + Math.random()),
		title: `module - ${ind}`,
		description: `module description - ${ind}`,
		courseId: args.courseId,
		ind,
		lang: args.lang,
		langName: args.langName,
		lessonCount: 15
	}));
	await prisma.module.createMany({
		data: mods
	});

	return mods;
}
