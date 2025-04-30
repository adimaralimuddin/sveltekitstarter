-- CreateEnum
CREATE TYPE "EditorTabs" AS ENUM ('users', 'courses', 'detail', 'courseId', 'modules', 'moduleId', 'lessons', 'lessonId');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('learner', 'editor', 'admin');

-- CreateEnum
CREATE TYPE "Subscription" AS ENUM ('freemium', 'premium');

-- CreateEnum
CREATE TYPE "Level" AS ENUM ('beginner', 'elementary', 'intermediate', 'advance', 'expert');

-- CreateEnum
CREATE TYPE "LessonKinds" AS ENUM ('lesson', 'vocab', 'grammar', 'story', 'culture');

-- CreateEnum
CREATE TYPE "LineTypeOptions" AS ENUM ('intro', 'diag', 'select', 'obj', 'narrate', 'trivia', 'choice', 'match', 'arrange', 'scene');

-- CreateEnum
CREATE TYPE "SideOption" AS ENUM ('text', 'eng', 'roman', 'img', 'textAudio', 'engAudio');

-- CreateEnum
CREATE TYPE "ShowEnums" AS ENUM ('yes', 'no', 'onPlay', 'onDone', 'onEnded');

-- CreateEnum
CREATE TYPE "Speaker" AS ENUM ('narator', 'a', 'b', 'c');

-- CreateEnum
CREATE TYPE "Alignment" AS ENUM ('center', 'left', 'right');

-- CreateEnum
CREATE TYPE "ElemTypeOptions" AS ENUM ('word', 'plain', 'img', 'textAud', 'engAud', 'letter');

-- CreateTable
CREATE TABLE "Editor" (
    "id" TEXT NOT NULL,
    "courseId" TEXT,
    "moduleId" TEXT,
    "lessonId" TEXT,
    "tab" "EditorTabs" NOT NULL DEFAULT 'courses',
    "userId" TEXT NOT NULL,

    CONSTRAINT "Editor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" TEXT,
    "avatar" TEXT,
    "email" TEXT,
    "password_hash" TEXT,
    "verified" BOOLEAN,
    "darkmode" BOOLEAN NOT NULL DEFAULT false,
    "role" "UserRole" NOT NULL DEFAULT 'learner',
    "subscription" "Subscription" NOT NULL DEFAULT 'freemium',
    "lang" TEXT,
    "native" TEXT NOT NULL DEFAULT 'en',
    "courseId" TEXT,
    "isCourseCompleted" BOOLEAN NOT NULL DEFAULT false,
    "moduleId" TEXT,
    "moduleInd" INTEGER,
    "lessonId" TEXT,
    "lessonInd" INTEGER,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Key" (
    "id" TEXT NOT NULL,
    "hashed_password" TEXT,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "Key_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseStat" (
    "lang" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    "lessonId" TEXT,
    "moduleInd" INTEGER NOT NULL,
    "lessonInd" INTEGER NOT NULL,
    "lessonLevel" INTEGER NOT NULL DEFAULT 0,
    "progress" INTEGER,
    "newWords" INTEGER,
    "totalWords" INTEGER,
    "weakWords" INTEGER,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "langName" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "level" "Level" NOT NULL,
    "description" TEXT,
    "wordCount" INTEGER DEFAULT 0,
    "grammarCount" INTEGER DEFAULT 0,
    "moduleCount" INTEGER DEFAULT 0,
    "lessonCount" INTEGER DEFAULT 0,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Module" (
    "id" TEXT NOT NULL,
    "ind" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "langName" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "description" TEXT,
    "type" "LessonKinds" NOT NULL DEFAULT 'lesson',
    "courseId" TEXT NOT NULL,
    "nextModuleId" TEXT,
    "prevModuleId" TEXT,

    CONSTRAINT "Module_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Lesson" (
    "id" TEXT NOT NULL,
    "ind" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "langName" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "description" TEXT,
    "startupStep" TEXT NOT NULL,
    "img" TEXT,
    "type" "LessonKinds" NOT NULL DEFAULT 'lesson',
    "free" BOOLEAN NOT NULL DEFAULT false,
    "wordCount" INTEGER NOT NULL DEFAULT 0,
    "grammarCount" INTEGER NOT NULL DEFAULT 0,
    "storyCount" INTEGER NOT NULL DEFAULT 0,
    "moduleId" TEXT,
    "courseId" TEXT,
    "lessonId" TEXT,
    "nextLessonId" TEXT,
    "prevLessonId" TEXT,

    CONSTRAINT "Lesson_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LessonStat" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "vocabs" JSONB[],
    "played" BOOLEAN NOT NULL DEFAULT false,
    "grammarInd" INTEGER NOT NULL DEFAULT 1,
    "grammarId" TEXT,
    "storyrInd" INTEGER NOT NULL DEFAULT 1,
    "storyId" TEXT,
    "grammarMastery" INTEGER NOT NULL DEFAULT 0,
    "vocabMastery" INTEGER NOT NULL DEFAULT 0,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "dateCompleted" TIMESTAMP(3),
    "lessonId" TEXT NOT NULL,

    CONSTRAINT "LessonStat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GrammarStat" (
    "id" TEXT NOT NULL,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "lessonStatId" TEXT NOT NULL,
    "grammarId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "played" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "GrammarStat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Step" (
    "id" TEXT NOT NULL,
    "ind" SERIAL NOT NULL,
    "prev" TEXT,
    "next" TEXT,
    "lang" TEXT NOT NULL,
    "lineInd" INTEGER NOT NULL DEFAULT 0,
    "lessonId" TEXT NOT NULL,
    "nextButton" TEXT NOT NULL DEFAULT 'Next',
    "color" TEXT,
    "done" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Step_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LineTrans" (
    "id" TEXT NOT NULL,
    "native" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "lineId" TEXT NOT NULL,

    CONSTRAINT "LineTrans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Line" (
    "id" TEXT NOT NULL,
    "ind" SERIAL NOT NULL,
    "lang" TEXT NOT NULL,
    "type" "LineTypeOptions" NOT NULL DEFAULT 'diag',
    "speaker" "Speaker" NOT NULL DEFAULT 'a',
    "align" "Alignment" NOT NULL DEFAULT 'center',
    "text" TEXT,
    "eng" TEXT,
    "roman" TEXT,
    "value" TEXT,
    "textAudio" TEXT,
    "engAudio" TEXT,
    "image" TEXT,
    "ansType" "SideOption",
    "optType" "SideOption",
    "prev" TEXT,
    "next" TEXT,
    "quiz" BOOLEAN NOT NULL DEFAULT false,
    "playable" BOOLEAN NOT NULL DEFAULT false,
    "engPlayable" BOOLEAN NOT NULL DEFAULT false,
    "show" "ShowEnums" NOT NULL DEFAULT 'yes',
    "showEng" "ShowEnums" NOT NULL DEFAULT 'onEnded',
    "showRoman" "ShowEnums" NOT NULL DEFAULT 'yes',
    "done" BOOLEAN NOT NULL DEFAULT false,
    "lessonId" TEXT NOT NULL,
    "stepId" TEXT,
    "meanerId" TEXT,
    "voice" TEXT DEFAULT 'f1',
    "showSpeaker" BOOLEAN DEFAULT false,

    CONSTRAINT "Line_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Audio" (
    "id" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "src" TEXT NOT NULL,

    CONSTRAINT "Audio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "elem" (
    "native" TEXT NOT NULL,
    "trans" TEXT NOT NULL,
    "otherTrans" TEXT[],
    "textAudioId" TEXT,
    "imgId" TEXT,
    "id" TEXT NOT NULL,
    "ind" SERIAL NOT NULL,
    "type" "ElemTypeOptions" NOT NULL,
    "lang" TEXT NOT NULL,
    "text" TEXT,
    "color" TEXT DEFAULT 'c',
    "pined" BOOLEAN NOT NULL DEFAULT false,
    "wordId" TEXT,
    "lessonId" TEXT,
    "vocabId" TEXT,
    "lineId" TEXT,
    "eng" TEXT,
    "vocabLessonId" TEXT,

    CONSTRAINT "elem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Word" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "roman" TEXT,
    "textAudio" TEXT,
    "engAudio" TEXT,
    "img" TEXT,
    "lang" TEXT NOT NULL,
    "quiz" BOOLEAN NOT NULL DEFAULT false,
    "vocab" BOOLEAN NOT NULL DEFAULT true,
    "engs" TEXT[],
    "pos" TEXT[],

    CONSTRAINT "Word_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Meaning" (
    "id" TEXT NOT NULL,
    "eng" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "engAudio" TEXT,
    "pos" TEXT[],

    CONSTRAINT "Meaning_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VocabCat" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "ind" SERIAL NOT NULL,
    "words" INTEGER NOT NULL DEFAULT 0,
    "courseId" TEXT NOT NULL,
    "lang" TEXT NOT NULL,

    CONSTRAINT "VocabCat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VocabSub" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "img" TEXT,
    "ind" SERIAL NOT NULL,
    "words" INTEGER NOT NULL DEFAULT 0,
    "free" BOOLEAN NOT NULL DEFAULT false,
    "catId" TEXT NOT NULL,
    "lang" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,

    CONSTRAINT "VocabSub_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubStat" (
    "id" TEXT NOT NULL,
    "words" JSONB[],
    "progress" INTEGER NOT NULL DEFAULT 0,
    "subId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "played" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SubStat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Img" (
    "id" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    "folderId" TEXT NOT NULL,
    "name" TEXT,
    "attr" JSONB,

    CONSTRAINT "Img_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ImgFolder" (
    "id" TEXT NOT NULL,
    "path" TEXT NOT NULL,

    CONSTRAINT "ImgFolder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ImgSubFolder" (
    "id" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "folderId" TEXT NOT NULL,

    CONSTRAINT "ImgSubFolder_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Editor_id_key" ON "Editor"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Editor_userId_key" ON "Editor"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_password_hash_key" ON "User"("password_hash");

-- CreateIndex
CREATE INDEX "Session_userId_idx" ON "Session"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Key_id_key" ON "Key"("id");

-- CreateIndex
CREATE INDEX "Key_user_id_idx" ON "Key"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "CourseStat_courseId_userId_key" ON "CourseStat"("courseId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Course_lang_level_key" ON "Course"("lang", "level");

-- CreateIndex
CREATE UNIQUE INDEX "Module_courseId_title_ind_type_key" ON "Module"("courseId", "title", "ind", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Lesson_moduleId_title_ind_lessonId_key" ON "Lesson"("moduleId", "title", "ind", "lessonId");

-- CreateIndex
CREATE UNIQUE INDEX "LessonStat_userId_lessonId_key" ON "LessonStat"("userId", "lessonId");

-- CreateIndex
CREATE UNIQUE INDEX "GrammarStat_grammarId_key" ON "GrammarStat"("grammarId");

-- CreateIndex
CREATE UNIQUE INDEX "Word_text_lang_key" ON "Word"("text", "lang");

-- CreateIndex
CREATE UNIQUE INDEX "SubStat_subId_key" ON "SubStat"("subId");

-- AddForeignKey
ALTER TABLE "Editor" ADD CONSTRAINT "Editor_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Key" ADD CONSTRAINT "Key_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseStat" ADD CONSTRAINT "CourseStat_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseStat" ADD CONSTRAINT "CourseStat_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lesson"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseStat" ADD CONSTRAINT "CourseStat_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseStat" ADD CONSTRAINT "CourseStat_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lesson" ADD CONSTRAINT "Lesson_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lesson"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lesson" ADD CONSTRAINT "Lesson_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LessonStat" ADD CONSTRAINT "LessonStat_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lesson"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrammarStat" ADD CONSTRAINT "GrammarStat_grammarId_fkey" FOREIGN KEY ("grammarId") REFERENCES "Lesson"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrammarStat" ADD CONSTRAINT "GrammarStat_lessonStatId_fkey" FOREIGN KEY ("lessonStatId") REFERENCES "LessonStat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GrammarStat" ADD CONSTRAINT "GrammarStat_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Step" ADD CONSTRAINT "Step_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lesson"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LineTrans" ADD CONSTRAINT "LineTrans_lineId_fkey" FOREIGN KEY ("lineId") REFERENCES "Line"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Line" ADD CONSTRAINT "Line_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lesson"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Line" ADD CONSTRAINT "Line_meanerId_fkey" FOREIGN KEY ("meanerId") REFERENCES "Meaning"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Line" ADD CONSTRAINT "Line_stepId_fkey" FOREIGN KEY ("stepId") REFERENCES "Step"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_textAudioId_fkey" FOREIGN KEY ("textAudioId") REFERENCES "Audio"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_imgId_fkey" FOREIGN KEY ("imgId") REFERENCES "Img"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_lineId_fkey" FOREIGN KEY ("lineId") REFERENCES "Line"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_vocabId_fkey" FOREIGN KEY ("vocabId") REFERENCES "VocabSub"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_wordId_fkey" FOREIGN KEY ("wordId") REFERENCES "Word"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elem" ADD CONSTRAINT "elem_vocabLessonId_fkey" FOREIGN KEY ("vocabLessonId") REFERENCES "Lesson"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VocabCat" ADD CONSTRAINT "VocabCat_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VocabSub" ADD CONSTRAINT "VocabSub_catId_fkey" FOREIGN KEY ("catId") REFERENCES "VocabCat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubStat" ADD CONSTRAINT "SubStat_subId_fkey" FOREIGN KEY ("subId") REFERENCES "VocabSub"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubStat" ADD CONSTRAINT "SubStat_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Img" ADD CONSTRAINT "Img_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "ImgSubFolder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ImgSubFolder" ADD CONSTRAINT "ImgSubFolder_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "ImgFolder"("id") ON DELETE CASCADE ON UPDATE CASCADE;
