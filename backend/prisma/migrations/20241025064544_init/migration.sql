-- CreateTable
CREATE TABLE "phone_app_chat" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "channel" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "phone_calls" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "owner" TEXT NOT NULL,
    "num" TEXT NOT NULL,
    "incoming" INTEGER NOT NULL,
    "time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accepts" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "phone_messages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "transmitter" TEXT NOT NULL,
    "receiver" TEXT NOT NULL,
    "message" TEXT NOT NULL DEFAULT '0',
    "time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isRead" INTEGER NOT NULL DEFAULT 0,
    "owner" INTEGER NOT NULL DEFAULT 0
);

-- CreateTable
CREATE TABLE "phone_users_contacts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "identifier" TEXT,
    "number" TEXT,
    "display" TEXT NOT NULL DEFAULT '-1'
);

-- CreateTable
CREATE TABLE "twitter_accounts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "avatar_url" TEXT
);

-- CreateTable
CREATE TABLE "twitter_likes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "authorId" INTEGER NOT NULL,
    "tweetId" INTEGER NOT NULL,
    CONSTRAINT "twitter_likes_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "twitter_accounts" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "twitter_likes_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "twitter_tweets" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "twitter_tweets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "authorId" INTEGER NOT NULL,
    "realUser" TEXT,
    "message" TEXT NOT NULL,
    "time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "likes" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "twitter_tweets_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "twitter_accounts" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_business" (
    "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "capital" INTEGER,
    "laundered" INTEGER,
    "reset_timestamp" INTEGER,
    CONSTRAINT "vrp_business_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_estoque" (
    "vehicle" TEXT NOT NULL PRIMARY KEY,
    "quantidade" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "vrp_homes_permissions" (
    "owner" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "garage" INTEGER NOT NULL,
    "home" TEXT NOT NULL DEFAULT '',
    "tax" TEXT NOT NULL DEFAULT '',

    PRIMARY KEY ("owner", "user_id", "home")
);

-- CreateTable
CREATE TABLE "vrp_srv_data" (
    "dkey" TEXT NOT NULL PRIMARY KEY,
    "dvalue" TEXT
);

-- CreateTable
CREATE TABLE "vrp_users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "whitelisted" BOOLEAN,
    "banned" BOOLEAN
);

-- CreateTable
CREATE TABLE "vrp_user_data" (
    "user_id" INTEGER NOT NULL,
    "dkey" TEXT NOT NULL,
    "dvalue" TEXT,

    PRIMARY KEY ("user_id", "dkey"),
    CONSTRAINT "vrp_user_data_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_user_homes" (
    "user_id" INTEGER NOT NULL,
    "home" TEXT NOT NULL,
    "number" INTEGER,

    PRIMARY KEY ("user_id", "home"),
    CONSTRAINT "vrp_user_homes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_user_identities" (
    "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "registration" TEXT,
    "phone" TEXT,
    "firstname" TEXT,
    "name" TEXT,
    "age" INTEGER,
    "foto" TEXT,
    "foragido" INTEGER NOT NULL DEFAULT 0,
    "licensa" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "vrp_user_identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_user_ids" (
    "identifier" TEXT NOT NULL PRIMARY KEY,
    "user_id" INTEGER,
    CONSTRAINT "vrp_user_ids_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_user_moneys" (
    "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "wallet" INTEGER,
    "bank" INTEGER,
    CONSTRAINT "vrp_user_moneys_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vrp_user_vehicles" (
    "user_id" INTEGER NOT NULL,
    "vehicle" TEXT NOT NULL,
    "detido" INTEGER NOT NULL DEFAULT 0,
    "time" TEXT NOT NULL DEFAULT '0',
    "engine" INTEGER NOT NULL DEFAULT 1000,
    "body" INTEGER NOT NULL DEFAULT 1000,
    "fuel" INTEGER NOT NULL DEFAULT 100,
    "ipva" TEXT,

    PRIMARY KEY ("user_id", "vehicle"),
    CONSTRAINT "vrp_user_vehicles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "vrp_users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "twitter_accounts_username_key" ON "twitter_accounts"("username");
