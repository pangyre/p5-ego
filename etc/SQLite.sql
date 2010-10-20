-- 
-- Stubs by SQL::Translator::Producer::SQLite
-- Modified to support more modern SQLite features.
-- 

BEGIN TRANSACTION;

--
-- Table: article_role
--
DROP TABLE IF EXISTS article_role;

CREATE TABLE article_role (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(40) NOT NULL,
  description TEXT NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

CREATE UNIQUE INDEX name ON article_role (name);

--
-- Table: attribute
--
DROP TABLE IF EXISTS attribute;

CREATE TABLE attribute (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX attribute_name ON attribute (name);

--
-- Table: filter
--
DROP TABLE IF EXISTS filter;

CREATE TABLE filter (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  author CHAR(36) NOT NULL,
  name TEXT NOT NULL,
  code TEXT NOT NULL,
  description TEXT,
  description_type ENUM(8) DEFAULT 'plain',
  core ENUM(1) NOT NULL DEFAULT '0',
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

--
-- Table: license
--
DROP TABLE IF EXISTS license;

CREATE TABLE license (
  id INTEGER PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  uri VARCHAR(255) NOT NULL,
  display VARCHAR(255),
  updated TIMESTAMP(14)
);

CREATE UNIQUE INDEX title ON license (title);

CREATE UNIQUE INDEX uri ON license (uri);

--
-- Table: nice_uri
--
DROP TABLE IF EXISTS nice_uri;

CREATE TABLE nice_uri (
  article INT(10) NOT NULL,
  path VARCHAR(255) NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (article, path)
);

--
-- Table: role
--
DROP TABLE IF EXISTS role;

CREATE TABLE role (
  id BINARY(36) NOT NULL DEFAULT '',
  name VARCHAR(40) NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  created DATETIME(19) NOT NULL DEFAULT '',
  updated TIMESTAMP(14) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  PRIMARY KEY (id)
);

CREATE UNIQUE INDEX name02 ON role (name);

--
-- Table: site_role
--
DROP TABLE IF EXISTS site_role;

CREATE TABLE site_role (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  name VARCHAR(40) NOT NULL,
  description TEXT NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

CREATE UNIQUE INDEX name03 ON site_role (name);

--
-- Table: tag
--
DROP TABLE IF EXISTS tag;

CREATE TABLE tag (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  name VARCHAR(40) NOT NULL,
  description TEXT NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

--
-- Table: template
--
DROP TABLE IF EXISTS template;

CREATE TABLE template (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

--
-- Table: user
--
DROP TABLE IF EXISTS user;

CREATE TABLE user (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(60) NOT NULL,
  email VARCHAR(100) NOT NULL,
  created datetime NOT NULL,
  updated datetime NOT NULL
);

CREATE UNIQUE INDEX email ON user (email);

CREATE UNIQUE INDEX username ON user (username);

--
-- Table: display_group
--
DROP TABLE IF EXISTS display_group;

CREATE TABLE display_group (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  template INTEGER,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  FOREIGN KEY(template) REFERENCES template(id)
);

CREATE INDEX display_group_idx_template ON display_group (template);

--
-- Table: fragment
--
DROP TABLE IF EXISTS fragment;

CREATE TABLE fragment (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  author INT(10) NOT NULL,
  template INT(10),
  css_class TINYTEXT NOT NULL,
  body MEDIUMTEXT NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  FOREIGN KEY(template) REFERENCES template(id)
);

CREATE INDEX fragment_idx_template ON fragment (template);

--
-- Table: user_article_role
--
DROP TABLE IF EXISTS user_article_role;

CREATE TABLE user_article_role (
  user INT(10) NOT NULL,
  article_role INT(10) NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (user, article_role),
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(article_role) REFERENCES article_role(id)

);

CREATE INDEX user_article_role_idx_article_role ON user_article_role (article_role);

CREATE INDEX user_article_role_idx_user ON user_article_role (user);

--
-- Table: user_attribute
--
DROP TABLE IF EXISTS user_attribute;

CREATE TABLE user_attribute (
  user INT(10) NOT NULL,
  attribute INT(10) NOT NULL,
  value MEDIUMTEXT NOT NULL,
  PRIMARY KEY (user, attribute),
  FOREIGN KEY(user) REFERENCES user(id)
);

CREATE INDEX user_attribute_idx_attribute ON user_attribute (attribute);

CREATE INDEX user_attribute_idx_user ON user_attribute (user);

--
-- Table: user_site_role
--
DROP TABLE IF EXISTS user_site_role;

CREATE TABLE user_site_role (
  user INT NOT NULL,
  site_role INT(10) NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (user, site_role)
);

CREATE INDEX user_site_role_idx_site_role ON user_site_role (site_role);

CREATE INDEX user_site_role_idx_user ON user_site_role (user);

--
-- Table: article
--
DROP TABLE IF EXISTS article;

CREATE TABLE article (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  user INT(10) NOT NULL,
  parent INT(10),
  template INT(10),
  license INT(10) NOT NULL,
  title TEXT NOT NULL,
  body MEDIUMTEXT NOT NULL,
  note TEXT,
  status ENUM(8) DEFAULT 'draft',
  comment_flag ENUM(6) DEFAULT 'on',
  golive DATETIME(19) NOT NULL,
  takedown DATETIME(19), -- Can be NULL!
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  FOREIGN KEY(license) REFERENCES license(id),
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(parent) REFERENCES article(id)
);

CREATE INDEX article_idx_license ON article (license);

CREATE INDEX article_idx_parent ON article (parent);

CREATE INDEX article_idx_template ON article (template);

CREATE INDEX article_idx_user ON article (user);

--
-- Table: fragment_filter
--
DROP TABLE IF EXISTS fragment_filter;

CREATE TABLE fragment_filter (
  fragment INT(10) NOT NULL,
  filter INT(10) NOT NULL,
  priority INT(2) NOT NULL DEFAULT 1,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (fragment, filter)
);

CREATE INDEX fragment_filter_idx_filter ON fragment_filter (filter);

CREATE INDEX fragment_filter_idx_fragment ON fragment_filter (fragment);

--
-- Table: comment
--
DROP TABLE IF EXISTS comment;

CREATE TABLE comment (
  id INTEGER PRIMARY KEY NOT NULL,
  uuid CHAR(36) NOT NULL,
  article INT(10) NOT NULL,
  parent INT(10),
  user INT(10) NOT NULL,
  license INT(10) NOT NULL,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  note TEXT,
  data BLOB,
  status ENUM(8) DEFAULT 'pending',
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14)
);

CREATE INDEX comment_idx_article ON comment (article);

CREATE INDEX comment_idx_license ON comment (license);

CREATE INDEX comment_idx_parent ON comment (parent);

CREATE INDEX comment_idx_user ON comment (user);

--
-- Table: article_display_group
--
DROP TABLE IF EXISTS article_display_group;

CREATE TABLE article_display_group (
  article INT(10) NOT NULL,
  display_group INT(10) NOT NULL,
  created DATETIME(19) NOT NULL,
  PRIMARY KEY (article, display_group)
);

CREATE INDEX article_display_group_idx_article ON article_display_group (article);

CREATE INDEX article_display_group_idx_display_group ON article_display_group (display_group);

--
-- Table: article_fragment
--
DROP TABLE IF EXISTS article_fragment;

CREATE TABLE article_fragment (
  article INT(10) NOT NULL,
  fragment INT(10) NOT NULL,
  priority INT(2) NOT NULL DEFAULT 1,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (article, fragment)
);

CREATE INDEX article_fragment_idx_article ON article_fragment (article);

CREATE INDEX article_fragment_idx_fragment ON article_fragment (fragment);

--
-- Table: article_tag
--
DROP TABLE IF EXISTS article_tag;

CREATE TABLE article_tag (
  article INT(10) NOT NULL,
  tag INT(10) NOT NULL,
  created DATETIME(19) NOT NULL,
  updated TIMESTAMP(14),
  PRIMARY KEY (tag, article)
);

CREATE INDEX article_tag_idx_article ON article_tag (article);

CREATE INDEX article_tag_idx_tag ON article_tag (tag);

COMMIT;
