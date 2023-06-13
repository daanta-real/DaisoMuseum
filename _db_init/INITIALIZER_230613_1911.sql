-- 다이소 전시관 프로젝트 관련 DDL 정리

-- 회원등급 테이블의 생성
DROP TABLE grd;
DROP SEQUENCE seq_grd_idx;
CREATE SEQUENCE seq_grd_idx START 1;
CREATE TABLE grd(
	  grd_idx    INT         NOT NULL DEFAULT NEXTVAL('seq_grd_idx')
	, grd_nm     VARCHAR(50) NOT NULL
	, grd_adm    BOOLEAN     NOT NULL
	, grd_wld    BOOLEAN     NOT NULL
	, grd_map    BOOLEAN     NOT NULL
	, grd_spt    BOOLEAN     NOT NULL
	, grd_pht    BOOLEAN     NOT NULL
	, CONSTRAINT pk_grd PRIMARY KEY(grd_idx) 
);

-- 회원 테이블의 생성
DROP TABLE usr;
DROP SEQUENCE seq_usr_idx;
CREATE SEQUENCE seq_usr_idx START 1;
CREATE TABLE usr(
	  usr_idx    INT          NOT NULL DEFAULT NEXTVAL('seq_usr_idx')
	, grd_idx    INT
	, usr_id     VARCHAR(50)  NOT NULL
	, usr_mail   VARCHAR(100)
	, usr_pw     VARCHAR(255)
	, usr_nm     VARCHAR(50)
	, usr_reg_dt DATE         NOT NULL DEFAULT CURRENT_DATE
	, usr_chg_dt DATE         NOT NULL DEFAULT CURRENT_DATE
	, usr_del_dt DATE
	, CONSTRAINT pk_usr PRIMARY KEY(usr_idx)
	, CONSTRAINT fk_grd FOREIGN KEY(grd_idx) REFERENCES grd(grd_idx) ON DELETE SET NULL
);

-- 회원사진 테이블의 생성
DROP TABLE uph;
DROP SEQUENCE seq_uph_idx;
CREATE SEQUENCE seq_uph_idx START 1;
CREATE TABLE uph(
	  uph_idx       INT          NOT NULL DEFAULT NEXTVAL('seq_uph_idx')
	, usr_idx       INT
	, uph_upload_nm VARCHAR(256) NOT NULL
	, uph_save_nm   VARCHAR(256) NOT NULL
	, uph_reg_dt    DATE         NOT NULL DEFAULT CURRENT_DATE
	, uph_size      INT          NOT NULL
	, uph_type      VARCHAR(256) NOT NULL
	, uph_del       BOOLEAN
);

-- 전시관 테이블의 생성
DROP TABLE wld;