import prisma from '$lib/app/db/prisma.server';

export default async function seedLessons(args: {
	moduleId: string;
	moduleTitle: string;
	courseId: string;
	lang: string;
	langName: string;
	count: number;
}) {
	// const less = new Array(args.count).fill({}).map((l, ind) => ({
	// 	courseId: args.courseId,
	// 	id: String(Math.random()),
	// 	ind,
	// 	title: `lesson titile - ${args.moduleTitle} - ${ind}`,
	// 	description: 'some descriptiotn meaningless haha',
	// 	lang: args.lang,
	// 	langName: args.langName,
	// 	startupStep: '',
	// 	status: 'published',
	// 	free: true
	// }));

	const lessons = await Promise.all(
		new Array(args.count).fill({}).map(async (l,i) => {
      const ind = i+1
			const less = await prisma.lesson.create({
				data: {
					courseId:args.courseId,
          ind,
          title:`lesson - ${ind}`,
          description:`samp`,
          lang:args.lang,
          langName:args.langName,
          free:true,
          startupStep:'',
					module: {
						connect: { id: args.moduleId }
					}
				}
			});

			return less;
		})
	);

	return lessons;
}
