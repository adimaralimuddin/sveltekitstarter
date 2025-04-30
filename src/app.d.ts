// See https://kit.svelte.dev/docs/types#app

import type { Course, LessonKinds } from '@prisma/client';
import type { Session, User } from 'lucia';
import type Module from 'module';

// for information about these interfaces

export interface AppCache {
	modules: Partial<Record<LessonKinds, string>>;
}

export interface AppData {
	user: User | null;
	session: Session | null;
	course: Course | null;
	module: Module | null;
	theme: string;
	caches: AppCache;
}

declare global {
	namespace App {
		interface Locals extends AppData {
			user: User | null;
		}

		interface PageState {
			showModal?: boolean;
		}
		// interface Error {}
		// interface Locals {}
		interface PageData extends AppData {
			user: User | null;
			// session: Session | null;
			// course: Course | null;
			// module: Module | null;
		}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};

export type Cache<T extends 'cache-modules' | 'cache-lessons' | 'cache-lessonStats'> = {
	key: T;
	cached: boolean;
	count: number;
};

export type Status = 'info' | 'warning' | 'error' | 'success';
