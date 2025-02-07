-- CreateEnum
CREATE TYPE "chatrole" AS ENUM ('USER', 'ASSISTANT');

-- CreateTable
CREATE TABLE "HealthData" (
    "id" VARCHAR(255) NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "data" JSONB NOT NULL,
    "metadata" JSONB,
    "filepath" VARCHAR(255),
    "filetype" VARCHAR(255),
    "status" VARCHAR(255) NOT NULL DEFAULT 'COMPLETED',
    "createdat" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "HealthData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatRoom" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "assistantmodeid" VARCHAR(255) NOT NULL,
    "llmproviderid" VARCHAR(255) NOT NULL,
    "llmprovidermodelid" VARCHAR(255),
    "createdat" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "ChatRoom_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatMessage" (
    "id" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "chatroomid" VARCHAR(255) NOT NULL,
    "role" "chatrole" NOT NULL,
    "createdat" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "ChatMessage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssistantMode" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "systemprompt" TEXT NOT NULL,
    "createdat" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "AssistantMode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LLMProvider" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "apikey" VARCHAR(255) NOT NULL DEFAULT '',
    "apiurl" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "createdat" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "LLMProvider_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_chatroom_assistantmode" ON "ChatRoom"("assistantmodeid");

-- CreateIndex
CREATE INDEX "idx_chatroom_llmprovider" ON "ChatRoom"("llmproviderid");

-- CreateIndex
CREATE INDEX "idx_chatmessage_chatroom" ON "ChatMessage"("chatroomid");

-- AddForeignKey
ALTER TABLE "ChatRoom" ADD CONSTRAINT "ChatRoom_assistantmodeid_fkey" FOREIGN KEY ("assistantmodeid") REFERENCES "AssistantMode"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ChatRoom" ADD CONSTRAINT "ChatRoom_llmproviderid_fkey" FOREIGN KEY ("llmproviderid") REFERENCES "LLMProvider"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ChatMessage" ADD CONSTRAINT "ChatMessage_chatroomid_fkey" FOREIGN KEY ("chatroomid") REFERENCES "ChatRoom"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
