DROP TABLE IF EXISTS TBL_USERPROFILE;
CREATE TABLE TBL_USERPROFILE (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    propertyname varchar(40),
    propertyvalue varchar(300)
);

INSERT INTO TBL_USERPROFILE (propertyname, propertyvalue)
SELECT 'db_version', '1010000';

DROP TABLE IF EXISTS TBL_USER_INFO;
CREATE TABLE TBL_USER_INFO (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name varchar(10) DEFAULT '',
    password varchar(30) DEFAULT ''
);

DROP TABLE IF EXISTS TBL_PHOTO_LIST;
CREATE TABLE TBL_PHOTO_LIST (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid varchar(36,0),
    name varchar(40,0),
    title varchar(40,0),
    content varchar(40,0),
    comment varchar(40,0),
    address varchar(40,0),
    author varchar(40,0),
    thumbimageurl varchar(200,0),
    imageurl varchar(200, 0),
    UNIQUE(uuid)
);