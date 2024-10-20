create table repos
(
    repo_id         uuid primary key,
    user_id         uuid references users (user_id),
    repo_name       varchar(255) not null,
    clone_url       varchar(255) not null,
    ssh_url         varchar(255) not null,
    ec2_instance_id varchar(255),
    ec2_public_ip   varchar(255),
    status          varchar(255)
);