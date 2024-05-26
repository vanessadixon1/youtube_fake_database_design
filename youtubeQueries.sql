CREATE TABLE if not exists user_profile(
    id uuid not null primary key,
    first_name text not null,
    last_name text not null,
    email text unique not null ,
    gender text check(gender in ('MALE', 'FEMALE')) not null ,
    create_at timestamp without time zone
);

create table if not exists youtube_account(
    id uuid primary key references user_profile(id),
    create_at timestamp with time zone
);

CREATE TABLE if not exists youtube_channel(
    id uuid primary key,
    youtube_account_id uuid not null references youtube_account(id),
    channel_name text unique,
    created_at timestamp without time zone
);

create table if not exists channel_subscriber(
  youtube_account_id uuid references youtube_account(id),
  youtube_channel_id uuid references youtube_channel(id),
  create_at timestamp with time zone,
  primary key (youtube_account_id, youtube_channel_id)
);

-- users
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, create_at)
VALUES (gen_random_uuid(), 'Mariam', 'Ali', 'm.ali@gmail.com', 'FEMALE', '2020-11-24 23:42:47.000000');
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, create_at)
VALUES (gen_random_uuid(), 'Joe', 'James', 'j.james@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, create_at)
VALUES (gen_random_uuid(), 'Jamila', 'Ahmed', 'jamila@gmail.com', 'FEMALE', '2020-11-24 23:42:47.000000');
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, create_at)
VALUES (gen_random_uuid(), 'Alex', 'Smith', 'alex2000@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, create_at)
VALUES (gen_random_uuid(), 'Bob', 'Bill', 'bobbill@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');

-- accounts
INSERT INTO public.youtube_account (id, create_at)
VALUES ('6e6e1af4-629d-4c61-8350-848846f384d0', '2020-11-24 23:44:36.000000');
INSERT INTO public.youtube_account (id, create_at)
VALUES ('e78d46be-7378-490d-b734-8921018e7d1e', '2020-11-24 23:00:36.000000');
INSERT INTO public.youtube_account (id, create_at)
VALUES ('c2b8abe6-5726-4926-a498-7479921a3d1f', '2020-11-24 10:44:36.000000');

-- youtube channels
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (gen_random_uuid(),'6e6e1af4-629d-4c61-8350-848846f384d0', 'MariamBeauty', '2020-11-24 23:47:05.385073');
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (gen_random_uuid(), 'c2b8abe6-5726-4926-a498-7479921a3d1f', 'MariamBeautyTutorials', '2020-11-24 23:47:05.385073');
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (gen_random_uuid(), 'c2b8abe6-5726-4926-a498-7479921a3d1f', 'JoeTech', '2020-11-24 23:47:50.904706');
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (gen_random_uuid(),'6e6e1af4-629d-4c61-8350-848846f384d0', 'AlexTutorials', '2020-11-24 23:47:50.904706');

-- subscribers
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, create_at)
VALUES ('c2b8abe6-5726-4926-a498-7479921a3d1f', '0a591138-7c00-4a0a-ac7b-dcbfb7a45e10', '2020-11-25 22:19:41.000000');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, create_at)
VALUES ('e78d46be-7378-490d-b734-8921018e7d1e','354f5dc8-fe93-4c8e-94ab-23cacabafa68', '2020-11-25 22:19:58.000000');
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, create_at)
VALUES ('c2b8abe6-5726-4926-a498-7479921a3d1f','fe6ac73b-8720-424c-b415-ab3a4f3d8fd3', '2020-11-25 22:19:58.000000');
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, create_at)
VALUES ('6e6e1af4-629d-4c61-8350-848846f384d0', '0a591138-7c00-4a0a-ac7b-dcbfb7a45e10', '2020-11-25 22:19:58.000000');

create table if not exists video(
    id uuid primary key,
    youtube_channel_id uuid references youtube_channel(id),
    title text,
    description text,
    url text unique,
    created_at timestamp without time zone
);

create table if not exists video_comment(
    id uuid primary key,
    youtube_account_id uuid references youtube_account(id),
    video_id uuid references video(id),
    comment text,
    created_at timestamp without time zone
);

create table if not exists video_comment_like(
    comment_id uuid references video_comment(id),
    video_id uuid references video(id),
    created_at timestamp without time zone,
    primary key (comment_id, video_id)
);

create table if not exists video_like(
    youtube_account_id uuid references youtube_account(id),
    video_id uuid references video(id),
    create_at timestamp without time zone,
    primary key(youtube_account_id, video_id)
);

create table if not exists video_view(
    id uuid primary key,
    youtube_account_id uuid references youtube_account(id),
    video_id uuid references video(id),
    created_at timestamp without time zone
);

-- -- video
INSERT INTO public.video (id, youtube_channel_id, title, url, description, created_at) VALUES (gen_random_uuid(), '354f5dc8-fe93-4c8e-94ab-23cacabafa68', 'How to take care of your skin', 'https://youtube.com/9328982', 'You will learn the best way to take care of your skin', '2020-05-02 22:30:28.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, created_at) VALUES (gen_random_uuid(), '354f5dc8-fe93-4c8e-94ab-23cacabafa68', 'Database Design', 'https://youtube.com/932898233', 'Master db design', '2020-12-02 22:41:08.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, created_at) VALUES (gen_random_uuid(), '7569550c-6eec-4085-88d2-2eee2ff259fc', 'Advanced Database', 'https://youtube.com/423432', 'Advanced DB Course', '2020-12-02 22:41:10.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, created_at) VALUES (gen_random_uuid(), 'fe6ac73b-8720-424c-b415-ab3a4f3d8fd3', 'Macbook Air M1 Unboxing', 'https://youtube.com/432423k', 'Unboxing', '2020-12-02 22:41:10.000000');

-- -- comments
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (gen_random_uuid(),'c2b8abe6-5726-4926-a498-7479921a3d1f', '0dc9b357-4f41-486e-8650-828eb723a803', 'Nice video', '2020-12-02 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (gen_random_uuid(),'e78d46be-7378-490d-b734-8921018e7d1e', 'de31a32f-6152-44de-9d8d-a8217334b047', 'I loved it.', '2020-12-02 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (gen_random_uuid(),'6e6e1af4-629d-4c61-8350-848846f384d0','45814170-c182-459b-8cf1-045c05a16848', 'Keep Going', '2020-12-02 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (gen_random_uuid(), '6e6e1af4-629d-4c61-8350-848846f384d0', 'de31a32f-6152-44de-9d8d-a8217334b047', 'Best course', '2020-12-02 22:35:08.000000');

-- -- likes to comments
INSERT INTO public.video_comment_like (comment_id, video_id, created_at) VALUES ('57bfe494-b89d-40f6-b2e1-bcf681137aa9','0dc9b357-4f41-486e-8650-828eb723a803', '2020-12-02 22:51:00.000000');
INSERT INTO public.video_comment_like (comment_id, video_id, created_at) VALUES ('eb0a874c-3146-45d5-a6c8-6fdc7084cade','de31a32f-6152-44de-9d8d-a8217334b047', '2020-12-02 22:51:00.000000');
INSERT INTO public.video_comment_like (comment_id, video_id, created_at) VALUES ('0f9520e9-d71a-4383-8c4a-4ad720b39bf5','45814170-c182-459b-8cf1-045c05a16848' , '2020-12-02 22:51:00.000000');
INSERT INTO public.video_comment_like (comment_id, video_id, created_at) VALUES ('57bfe494-b89d-40f6-b2e1-bcf681137aa9','1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:51:00.000000');
INSERT INTO public.video_comment_like (comment_id, video_id, created_at) VALUES ('75529fe1-0cc5-4d67-9e07-b7fd5c1dc64a','1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:51:00.000000');

-- -- likes to videos
INSERT INTO public.video_like (youtube_account_id, video_id, create_at) VALUES ('6e6e1af4-629d-4c61-8350-848846f384d0','45814170-c182-459b-8cf1-045c05a16848', '2020-12-02 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, create_at) VALUES ('c2b8abe6-5726-4926-a498-7479921a3d1f', '0dc9b357-4f41-486e-8650-828eb723a803' , '2020-12-02 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, create_at) VALUES ('e78d46be-7378-490d-b734-8921018e7d1e', '1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:35:38.000000');

-- -- views
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (gen_random_uuid(), 'e78d46be-7378-490d-b734-8921018e7d1e', 'de31a32f-6152-44de-9d8d-a8217334b047', '2020-12-02 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (gen_random_uuid(), 'c2b8abe6-5726-4926-a498-7479921a3d1f', '1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (gen_random_uuid(), '6e6e1af4-629d-4c61-8350-848846f384d0', '1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (gen_random_uuid(), null, '1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (gen_random_uuid(), null, '1642507c-3815-4132-aaa0-fb0674ca2f39', '2020-12-02 22:36:07.000000');