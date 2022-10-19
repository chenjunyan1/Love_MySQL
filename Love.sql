DROP DATABASE IF EXISTS love;
CREATE DATABASE love;
USE love;
ALTER DATABASE love CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# PRIMARY KEY 主键 唯一的值
#  auto_increment 自增加
# 用户表  -------------------------------------------------------
DROP TABLE IF EXISTS user;
CREATE TABLE IF NOT EXISTS user
(
    id        int PRIMARY KEY auto_increment COMMENT '用户id',
    img       longblob COMMENT '用户照片',
    user_name VARCHAR(256) COMMENT '用户名',
    gender    VARCHAR(256) COMMENT '性别',
    email     VARCHAR(256) COMMENT '邮箱',
    password  VARCHAR(256) COMMENT '密码',
    role      VARCHAR(256) COMMENT '权限'
);

# 实名认证  -------------------------------------------------------
DROP TABLE IF EXISTS user_id_card;
CREATE TABLE IF NOT EXISTS user_id_card
(
    user_id   int COMMENT '外键_用户id',
    real_name VARCHAR(256) COMMENT '真实姓名',
    id_number VARCHAR(256) COMMENT '用户身份证号'
);
alter table user_id_card
    add constraint fk_user_id_card_user_id foreign key (user_id) references user (id);

# 用户伴侣 userlove  -------------------------------------------------------
DROP TABLE IF EXISTS user_love;
CREATE TABLE IF NOT EXISTS user_love
(
    user_id       int COMMENT '用户id',
    love_id       int COMMENT '伴侣id',
    userlove_time datetime COMMENT '确定伴侣的时间'
);
alter table user_love
    add constraint fk_userlove_user_id foreign key (user_id) references user (id);

# 伴侣申请列表HistoryCompanion  -------------------------------------------------------
DROP TABLE IF EXISTS companion_pplication_list;
CREATE TABLE IF NOT EXISTS companion_pplication_list
(
    id           int PRIMARY KEY auto_increment COMMENT 'id自增',
    user_id      int COMMENT '用户id',
    applicant_id int COMMENT '申请者id'
);
alter table companion_pplication_list
    add constraint fk_companion_pplication_list_id foreign key (user_id) references user (id);

# 恋爱小记  -------------------------------------------------------
DROP TABLE IF EXISTS small_notes;
CREATE TABLE IF NOT EXISTS small_notes
(
    id              int PRIMARY KEY auto_increment COMMENT '小记id',
    user_id         int COMMENT '外键用户id',
    release_time    datetime COMMENT '发布时间',
    small_notes_img longblob COMMENT '封面',
    location        VARCHAR(256) COMMENT '地点',
    content         VARCHAR(256) COMMENT '内容',
    title           VARCHAR(256) COMMENT '标题'
);
alter table small_notes
    add constraint fk_small_notes_user_id foreign key (user_id) references user (id);

# 恋爱小记留言  -------------------------------------------------------
DROP TABLE IF EXISTS small_notes_message;
CREATE TABLE IF NOT EXISTS small_notes_message
(
    id             int PRIMARY KEY auto_increment COMMENT '留言_id_自增',
    small_notes_id int COMMENT '外键_小记id',
    user_id        int COMMENT '用户_id',
    message        VARCHAR(256) COMMENT '留言'
);
alter table small_notes_message
    add constraint fk_small_notes_message_small_notes_id foreign key (small_notes_id) references small_notes (id);

# 恋爱小记—点赞  -------------------------------------------------------
DROP TABLE IF EXISTS small_notes_kudos;
CREATE TABLE IF NOT EXISTS small_notes_kudos
(
    id             int COMMENT '外键_恋爱小记_id',
    small_notes_id int COMMENT '点赞者id'
);
alter table small_notes_kudos
    add constraint fk_small_notes_kudos_id foreign key (id) references small_notes (id);

# 重要历程 ImportantHistory  -------------------------------------------------------
DROP TABLE IF EXISTS important_history;
CREATE TABLE IF NOT EXISTS important_history
(
    id       int PRIMARY KEY auto_increment COMMENT '历程id自增',
    user_id  int COMMENT '外链 user_id',
    location VARCHAR(256) COMMENT '地点',
    time     datetime COMMENT '时间',
    events   VARCHAR(256) COMMENT '事件'
);
alter table important_history
    add constraint fk_important_history_user_id foreign key (user_id) references user (id);

