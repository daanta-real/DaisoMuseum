-- 다이소 전시관 프로젝트 관련 DDL 정리

-- 회원등급 테이블의 생성
DROP TABLE grd;
CREATE TABLE grd(
	  grd_idx    SERIAL      PRIMARY KEY    
	, grd_nm     VARCHAR(50) NOT NULL
	, grd_adm    BOOLEAN     NOT NULL
	, grd_wld    BOOLEAN     NOT NULL
	, grd_map    BOOLEAN     NOT NULL
	, grd_spt    BOOLEAN     NOT NULL
	, grd_pht    BOOLEAN     NOT NULL
);

-- 회원 테이블의 생성
DROP TABLE usr;
CREATE TABLE usr(
	  usr_idx    SERIAL       PRIMARY KEY
	, grd_idx    INTEGER      REFERENCES grd(grd_idx) ON DELETE SET NULL
	, usr_id     VARCHAR(50)  NOT NULL
	, usr_mail   VARCHAR(100)
	, usr_pw     VARCHAR(255)
	, usr_nm     VARCHAR(50)
	, usr_reg_dt DATE         NOT NULL DEFAULT CURRENT_DATE
	, usr_chg_dt DATE         NOT NULL DEFAULT CURRENT_DATE
	, usr_del_dt DATE
);

-- 회원사진 테이블의 생성
DROP TABLE uph;
CREATE TABLE uph(
	  uph_idx       SERIAL       PRIMARY KEY
	, usr_idx       INTEGER      NOT NULL REFERENCES usr(usr_idx) ON DELETE CASCADE
	, uph_upload_nm VARCHAR(256) NOT NULL
	, uph_save_nm   VARCHAR(256) NOT NULL
	, uph_path      VARCHAR(256) NOT NULL
	, uph_size      INTEGER      NOT NULL
	, uph_type      VARCHAR(256) NOT NULL
	, uph_path      
    , uph_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, uph_del_dt    DATE
);



-- 전시관 테이블의 생성
DROP TABLE wld;
CREATE TABLE wld(
	  wld_idx       SERIAL       PRIMARY KEY
	, wld_nm        VARCHAR(100) NOT NULL
	, wld_reg_id    VARCHAR(50)
	, wld_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, wld_chg_id    VARCHAR(50)
	, wld_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, wld_del_dt    DATE
);

-- 전시관 코멘트 테이블의 생성
DROP TABLE cmt_wld;
CREATE TABLE cmt_wld(
	  cmt_idx       SERIAL       PRIMARY KEY
	  wld_idx       INTEGER      REFERENCES wld(wld_idx) ON DELETE SET NULL
	, cmt_txt       TEXT         NOT NULL
	, cmt_pw        VARCHAR(50)
	, cmt_reg_id    VARCHAR(50)
	, cmt_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, cmt_chg_id    VARCHAR(50)
	, cmt_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, cmt_del_dt    DATE
);

-- 전시관 좋아요 테이블의 생성
DROP TABLE fav_wld;
CREATE TABLE fav_wld(
	  usr_idx       INTEGER      NOT NULL REFERENCES usr(usr_idx) ON DELETE CASCADE
	, wld_idx       INTEGER      NOT NULL REFERENCES wld(wld_idx) ON DELETE CASCADE
);



-- 구역 테이블의 생성
-- MAP은 Oracle DBMS에서 예약어로 쓰인다고 한다. 오라클을 사용할 거면 주의한다.
DROP TABLE map;
CREATE TABLE map(
      map_idx       SERIAL       PRIMARY KEY
    , wld_idx       INTEGER      REFERENCES wld(wld_idx) ON DELETE SET NULL
    , map_nm        VARCHAR(100) NOT NULL
    , map_reg_id    VARCHAR(50)
    , map_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , map_chg_id    VARCHAR(50)
    , map_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , map_del_dt    DATE
);

-- 구역 코멘트 테이블의 생성
DROP TABLE cmt_map;
CREATE TABLE cmt_map(
      cmt_idx       SERIAL       PRIMARY KEY
      map_idx       INTEGER      REFERENCES map(map_idx) ON DELETE SET NULL
    , cmt_txt       TEXT         NOT NULL
    , cmt_pw        VARCHAR(50)
    , cmt_reg_id    VARCHAR(50)
    , cmt_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , cmt_chg_id    VARCHAR(50)
    , cmt_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , cmt_del_dt    DATE
);



-- 지점 테이블의 생성
DROP TABLE spt;
CREATE TABLE spt(
      spt_idx       SERIAL       PRIMARY KEY
    , map_idx       INTEGER      REFERENCES map(map_idx) ON DELETE SET NULL
    , spt_nm        VARCHAR(100) NOT NULL
    , spt_x         INTEGER
    , spt_y         INTEGER
    , spt_reg_id    VARCHAR(50)
    , spt_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , spt_chg_id    VARCHAR(50)
    , spt_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , spt_del_dt    DATE
);

-- 지점 코멘트 테이블의 생성
DROP TABLE cmt_spt;
CREATE TABLE cmt_spt(
      cmt_idx       SERIAL       PRIMARY KEY
      spt_idx       INTEGER      REFERENCES spt(spt_idx) ON DELETE SET NULL
    , cmt_txt       TEXT         NOT NULL
    , cmt_pw        VARCHAR(50)
    , cmt_reg_id    VARCHAR(50)
    , cmt_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , cmt_chg_id    VARCHAR(50)
    , cmt_chg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , cmt_del_dt    DATE
);

-- 지점 좋아요 테이블의 생성
DROP TABLE fav_spt;
CREATE TABLE fav_spt(
      usr_idx       INTEGER      NOT NULL REFERENCES usr(usr_idx) ON DELETE CASCADE
    , spt_idx       INTEGER      NOT NULL REFERENCES spt(spt_idx) ON DELETE CASCADE
);



-- 사진 테이블의 생성
DROP TABLE pht;
CREATE TABLE pht(
      pht_idx       SERIAL       PRIMARY KEY
    , usr_idx       INTEGER      REFERENCES usr(usr_idx) ON DELETE SET NULL
    , spt_idx       INTEGER      REFERENCES spt(spt_idx) ON DELETE SET NULL
    , pht_upload_nm VARCHAR(256) NOT NULL
    , pht_save_nm   VARCHAR(256) NOT NULL
    , pht_path      VARCHAR(256) NOT NULL
    , pht_size      INTEGER      NOT NULL
    , pht_type      VARCHAR(256) NOT NULL
    , pht_sht_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , pht_angle     INTEGER
    , pht_reg_id    VARCHAR(50)
    , pht_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
    , pht_del_dt    DATE
);

-- 사진 좋아요 테이블의 생성
DROP TABLE fav_pht;
CREATE TABLE fav_pht(
      usr_idx       INTEGER      NOT NULL REFERENCES usr(usr_idx) ON DELETE CASCADE
    , pht_idx       INTEGER      NOT NULL REFERENCES pht(pht_idx) ON DELETE CASCADE
);
