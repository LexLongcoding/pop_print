BEGIN TRANSACTION;
DROP TABLE IF EXISTS "django_migrations";
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_admin";
CREATE TABLE IF NOT EXISTS "Pop_App_admin" (
	"id"	integer NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"password"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_user";
CREATE TABLE IF NOT EXISTS "Pop_App_user" (
	"id"	integer NOT NULL,
	"first_name"	varchar(45) NOT NULL,
	"last_name"	varchar(45) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"password"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_product";
CREATE TABLE IF NOT EXISTS "Pop_App_product" (
	"id"	integer NOT NULL,
	"title"	varchar(255) NOT NULL,
	"category"	varchar(255) NOT NULL,
	"description"	varchar(255) NOT NULL,
	"price"	decimal NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_product_favorited_by";
CREATE TABLE IF NOT EXISTS "Pop_App_product_favorited_by" (
	"id"	integer NOT NULL,
	"product_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("product_id") REFERENCES "Pop_App_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "Pop_App_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_order";
CREATE TABLE IF NOT EXISTS "Pop_App_order" (
	"id"	integer NOT NULL,
	"total_price"	decimal NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"buyer_name"	varchar(255) NOT NULL,
	"buyer_address"	varchar(255) NOT NULL,
	"buyer_city"	varchar(255) NOT NULL,
	"buyer_state"	varchar(255) NOT NULL,
	"buyer_zip"	integer NOT NULL,
	"buyer_CC"	integer NOT NULL,
	"buyer_securtiy"	integer NOT NULL,
	"buyer_exp"	date NOT NULL,
	"recipiant_name"	varchar(255) NOT NULL,
	"recipiant_address"	varchar(255) NOT NULL,
	"recipiant_city"	varchar(255) NOT NULL,
	"recipiant_state"	varchar(255) NOT NULL,
	"recipiant_zip"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "Pop_App_order_ordered_products";
CREATE TABLE IF NOT EXISTS "Pop_App_order_ordered_products" (
	"id"	integer NOT NULL,
	"order_id"	integer NOT NULL,
	"product_id"	integer NOT NULL,
	FOREIGN KEY("order_id") REFERENCES "Pop_App_order"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "Pop_App_product"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_group_permissions";
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user_groups";
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user_user_permissions";
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_admin_log";
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_content_type";
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_permission";
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user";
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_group";
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "django_session";
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'Pop_App','0001_initial','2021-04-04 04:06:53.489483');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0001_initial','2021-04-04 04:06:53.495808');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2021-04-04 04:06:53.509267');
INSERT INTO "django_migrations" VALUES (4,'admin','0001_initial','2021-04-04 04:06:53.519824');
INSERT INTO "django_migrations" VALUES (5,'admin','0002_logentry_remove_auto_add','2021-04-04 04:06:53.533861');
INSERT INTO "django_migrations" VALUES (6,'admin','0003_logentry_add_action_flag_choices','2021-04-04 04:06:53.546293');
INSERT INTO "django_migrations" VALUES (7,'contenttypes','0002_remove_content_type_name','2021-04-04 04:06:53.584984');
INSERT INTO "django_migrations" VALUES (8,'auth','0002_alter_permission_name_max_length','2021-04-04 04:06:53.593464');
INSERT INTO "django_migrations" VALUES (9,'auth','0003_alter_user_email_max_length','2021-04-04 04:06:53.604635');
INSERT INTO "django_migrations" VALUES (10,'auth','0004_alter_user_username_opts','2021-04-04 04:06:53.615555');
INSERT INTO "django_migrations" VALUES (11,'auth','0005_alter_user_last_login_null','2021-04-04 04:06:53.627022');
INSERT INTO "django_migrations" VALUES (12,'auth','0006_require_contenttypes_0002','2021-04-04 04:06:53.629293');
INSERT INTO "django_migrations" VALUES (13,'auth','0007_alter_validators_add_error_messages','2021-04-04 04:06:53.640756');
INSERT INTO "django_migrations" VALUES (14,'auth','0008_alter_user_username_max_length','2021-04-04 04:06:53.652713');
INSERT INTO "django_migrations" VALUES (15,'auth','0009_alter_user_last_name_max_length','2021-04-04 04:06:53.662810');
INSERT INTO "django_migrations" VALUES (16,'auth','0010_alter_group_name_max_length','2021-04-04 04:06:53.674272');
INSERT INTO "django_migrations" VALUES (17,'auth','0011_update_proxy_permissions','2021-04-04 04:06:53.687282');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2021-04-04 04:06:53.691709');
INSERT INTO "django_content_type" VALUES (1,'Pop_App','admin');
INSERT INTO "django_content_type" VALUES (2,'Pop_App','user');
INSERT INTO "django_content_type" VALUES (3,'Pop_App','product');
INSERT INTO "django_content_type" VALUES (4,'Pop_App','order');
INSERT INTO "django_content_type" VALUES (5,'admin','logentry');
INSERT INTO "django_content_type" VALUES (6,'auth','permission');
INSERT INTO "django_content_type" VALUES (7,'auth','group');
INSERT INTO "django_content_type" VALUES (8,'auth','user');
INSERT INTO "django_content_type" VALUES (9,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (10,'sessions','session');
INSERT INTO "auth_permission" VALUES (1,1,'add_admin','Can add admin');
INSERT INTO "auth_permission" VALUES (2,1,'change_admin','Can change admin');
INSERT INTO "auth_permission" VALUES (3,1,'delete_admin','Can delete admin');
INSERT INTO "auth_permission" VALUES (4,1,'view_admin','Can view admin');
INSERT INTO "auth_permission" VALUES (5,2,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (6,2,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (7,2,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (8,2,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (9,3,'add_product','Can add product');
INSERT INTO "auth_permission" VALUES (10,3,'change_product','Can change product');
INSERT INTO "auth_permission" VALUES (11,3,'delete_product','Can delete product');
INSERT INTO "auth_permission" VALUES (12,3,'view_product','Can view product');
INSERT INTO "auth_permission" VALUES (13,4,'add_order','Can add order');
INSERT INTO "auth_permission" VALUES (14,4,'change_order','Can change order');
INSERT INTO "auth_permission" VALUES (15,4,'delete_order','Can delete order');
INSERT INTO "auth_permission" VALUES (16,4,'view_order','Can view order');
INSERT INTO "auth_permission" VALUES (17,5,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (18,5,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (19,5,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (20,5,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (21,6,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (22,6,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (23,6,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (24,6,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (25,7,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (26,7,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (27,7,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (28,7,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (29,8,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (30,8,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (31,8,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (32,8,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (33,9,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (34,9,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (35,9,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (36,9,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (37,10,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (38,10,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (39,10,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (40,10,'view_session','Can view session');
DROP INDEX IF EXISTS "Pop_App_product_favorited_by_product_id_user_id_553c8188_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "Pop_App_product_favorited_by_product_id_user_id_553c8188_uniq" ON "Pop_App_product_favorited_by" (
	"product_id",
	"user_id"
);
DROP INDEX IF EXISTS "Pop_App_product_favorited_by_product_id_c0a02f39";
CREATE INDEX IF NOT EXISTS "Pop_App_product_favorited_by_product_id_c0a02f39" ON "Pop_App_product_favorited_by" (
	"product_id"
);
DROP INDEX IF EXISTS "Pop_App_product_favorited_by_user_id_11ea6f76";
CREATE INDEX IF NOT EXISTS "Pop_App_product_favorited_by_user_id_11ea6f76" ON "Pop_App_product_favorited_by" (
	"user_id"
);
DROP INDEX IF EXISTS "Pop_App_order_ordered_products_order_id_product_id_58f2e882_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "Pop_App_order_ordered_products_order_id_product_id_58f2e882_uniq" ON "Pop_App_order_ordered_products" (
	"order_id",
	"product_id"
);
DROP INDEX IF EXISTS "Pop_App_order_ordered_products_order_id_3c24e9d7";
CREATE INDEX IF NOT EXISTS "Pop_App_order_ordered_products_order_id_3c24e9d7" ON "Pop_App_order_ordered_products" (
	"order_id"
);
DROP INDEX IF EXISTS "Pop_App_order_ordered_products_product_id_03243d5e";
CREATE INDEX IF NOT EXISTS "Pop_App_order_ordered_products_product_id_03243d5e" ON "Pop_App_order_ordered_products" (
	"product_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_b120cbf9";
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_permission_id_84c5c92e";
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_6a12ed8b";
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_groups_group_id_97559544";
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_a95ead1b";
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c";
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "django_admin_log_content_type_id_c4bce8eb";
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
DROP INDEX IF EXISTS "django_admin_log_user_id_c564eba6";
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
DROP INDEX IF EXISTS "django_content_type_app_label_model_76bd3d3b_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq";
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_2f476e4b";
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
DROP INDEX IF EXISTS "django_session_expire_date_a5c62663";
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
