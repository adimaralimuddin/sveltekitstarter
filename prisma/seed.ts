// // prisma/seed.ts

import { PrismaClient } from '@prisma/client';
import seedLessons from './seed/seedLessons/seedLessons';
import { seedModules } from './seed/seedModules/seedModules';
const prisma = new PrismaClient();

function main() {
	seedCourse();
}

// main();

export async function seedCourse() {
	// return;
	// await prisma.course.deleteMany();
  // await prisma.user.deleteMany();
  await deleteAll()

	const course = await prisma.course.create({
		data: {
			lang: 'es',
			langName: 'spanish',
			level: 'beginner',
			title: 'spanish b',
			status: 'published',

		}
	});

	console.log('prisma seed ==========================');

	console.log('1: course created: ', course.title);

	const modules = await seedModules({
		courseId: course.id,
		count: 14,
		lang: course.lang,
		langName: course.langName
	});

	const lessons = await Promise.all(
		modules.map(async (m) => {
			const lessons = await seedLessons({
				count: 15,
				courseId: m.courseId,
				lang: m.lang,
				langName: m.langName,
				moduleId: m.id,
				moduleTitle: m.title
			});

			await prisma.module.update({
				where: { id: m.id },
				data: { firstLessonId: lessons[0].id }
			});

			if (m.ind == 0) {
				await prisma.course.update({
					where: { id: course.id },
					data: { lesson0: `${lessons[0].id}@@${lessons[0].title}@@${m.id}` }
				});
			}
			if (m.ind == 1) {
				await prisma.course.update({
					where: { id: course.id },
					data: { lesson1: `${lessons[1].id}@@${lessons[1].title}@@${m.id}` }
				});
			}
			return lessons;
		})
	);

  console.log('prisma seeded successfully.')
	return { course, modules, lessons };
}
async function deleteAll() {
	const e = await prisma.course.deleteMany();
	console.log('delete all courses: ', e);
}

// deleteAll();

// async function main() {
// 	console.log(`Start seeding ...`);

// 	// for (const p of userData) {
// 	// 	const user = await prisma.user.create({
// 	// 		data: {
// 	// 			email: p.author.email,
// 	// 			posts: {
// 	// 				create: {
// 	// 					title: p.title,
// 	// 					content: p.content,
// 	// 					published: p.published
// 	// 				}
// 	// 			}
// 	// 		}
// 	// 	});
// 	// 	console.log(`Created user with id: ${user.id}`);
// 	// }
// 	// console.log(`Seeding finished.`);
// }

// // main()
// // 	.then(async () => {
// // 		await prisma.$disconnect();
// // 	})
// // 	.catch(async (e) => {
// // 		console.error(e);
// // 		await prisma.$disconnect();
// // 		process.exit(1);
// // 	});
