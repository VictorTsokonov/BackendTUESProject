create table users
(
    user_id             uuid primary key,
    github_username     varchar(255) not null,
    github_access_token varchar(255) not null
);