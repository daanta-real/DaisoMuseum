-- 다이소 전시관 프로젝트 관련 DDL 정리

-- 테이블 전체 삭제 구문, 구성 역순
-- 좋아요들
DROP TABLE fav_pht;
DROP TABLE fav_spt;
DROP TABLE fav_wld;

-- 코멘트들
DROP TABLE cmt_spt;
DROP TABLE cmt_map;
DROP TABLE cmt_wld;

-- 데이터테이블
DROP TABLE pht;
DROP TABLE spt;
DROP TABLE map;
DROP TABLE wld;
DROP TABLE uph;
DROP TABLE usr;
DROP TABLE grd;



-- 테이블 전체 생성 구문, 구성 정순
-- 회원등급 테이블의 생성
CREATE TABLE grd(
      idx     SERIAL          PRIMARY KEY
    , nm      VARCHAR(50)     NOT NULL
    , adm     BOOLEAN         NOT NULL
    , wld     BOOLEAN         NOT NULL
    , map     BOOLEAN         NOT NULL
    , spt     BOOLEAN         NOT NULL
    , pht     BOOLEAN         NOT NULL
);
COMMENT ON TABLE  grd     IS '회원-등급';
COMMENT ON COLUMN grd.idx IS '권한 idx';
COMMENT ON COLUMN grd.nm  IS '권한 명';
COMMENT ON COLUMN grd.adm IS '권한 운영자';
COMMENT ON COLUMN grd.wld IS '권한 전시관';
COMMENT ON COLUMN grd.map IS '권한 구역';
COMMENT ON COLUMN grd.spt IS '권한 지점';
COMMENT ON COLUMN grd.pht IS '권한 사진';

-- 회원 테이블의 생성
CREATE TABLE usr(
      idx     SERIAL          PRIMARY KEY
    , grd_idx INTEGER         REFERENCES grd(idx) ON DELETE SET NULL
    , id      VARCHAR(50)     NOT NULL
    , mail    VARCHAR(100)
    , pw      VARCHAR(255)
    , nm      VARCHAR(50)
    , reg_dt  DATE            NOT NULL DEFAULT CURRENT_DATE
    , chg_dt  DATE            NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  usr         IS '회원';
COMMENT ON COLUMN usr.idx     IS '회원 idx';
COMMENT ON COLUMN usr.grd_idx IS '회원 등급';
COMMENT ON COLUMN usr.id      IS '회원 이메일';
COMMENT ON COLUMN usr.mail    IS '회원 ID';
COMMENT ON COLUMN usr.pw      IS '회원 비밀번호';
COMMENT ON COLUMN usr.nm      IS '회원 명';
COMMENT ON COLUMN usr.reg_dt  IS '회원 생성일';
COMMENT ON COLUMN usr.chg_dt  IS '회원 변경일';
COMMENT ON COLUMN usr.del_dt  IS '회원 삭제일(NULL 아닐 시 삭제된 레코드임)';


-- 회원사진 테이블의 생성
CREATE TABLE uph(
      idx     SERIAL       PRIMARY KEY
    , usr_idx INTEGER      NOT NULL REFERENCES usr(idx) ON DELETE CASCADE
    , upld_nm VARCHAR(256) NOT NULL
    , save_nm VARCHAR(256) NOT NULL
    , path    VARCHAR(256) NOT NULL
    , size    INTEGER      NOT NULL
    , type    VARCHAR(256) NOT NULL
    , reg_dt  DATE         NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  uph         IS '회원-사진';
COMMENT ON COLUMN uph.idx     IS '회원사진 idx';
COMMENT ON COLUMN uph.usr_idx IS '회원 idx';
COMMENT ON COLUMN uph.upld_nm IS '회원사진 파일명(사용자측)';
COMMENT ON COLUMN uph.save_nm IS '회원사진 파일명(서버측)';
COMMENT ON COLUMN uph.path    IS '회원사진 파일경로';
COMMENT ON COLUMN uph.size    IS '회원사진 파일크기';
COMMENT ON COLUMN uph.type    IS '회원사진 파일유형';
COMMENT ON COLUMN uph.reg_dt  IS '회원사진 생성일';
COMMENT ON COLUMN uph.del_dt  IS '회원사진 삭제일(NULL 아닐 시 삭제된 레코드임)';


-- 전시관 테이블의 생성
CREATE TABLE wld(
      idx     SERIAL           PRIMARY KEY
    , nm      VARCHAR(100)     NOT NULL
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  wld        IS '전시관';
COMMENT ON COLUMN wld.idx    IS '전시관 idx';
COMMENT ON COLUMN wld.nm     IS '전시관 명';
COMMENT ON COLUMN wld.reg_id IS '전시관 생성자';
COMMENT ON COLUMN wld.reg_dt IS '전시관 생성일';
COMMENT ON COLUMN wld.chg_id IS '전시관 변경자';
COMMENT ON COLUMN wld.chg_dt IS '전시관 변경일';
COMMENT ON COLUMN wld.del_dt IS '전시관 삭제일(NULL 아닐 시 삭제된 레코드임)';

-- 전시관 코멘트 테이블의 생성
CREATE TABLE cmt_wld(
      idx     SERIAL           PRIMARY KEY
    , wld_idx INTEGER          REFERENCES wld(idx) ON DELETE SET NULL
    , txt     TEXT             NOT NULL
    , pw      VARCHAR(50)
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  cmt_wld         IS '전시관-코멘트';
COMMENT ON COLUMN cmt_wld.idx     IS '전시관-코멘트 idx';
COMMENT ON COLUMN cmt_wld.wld_idx IS '전시관 idx';
COMMENT ON COLUMN cmt_wld.txt     IS '전시관-코멘트 내용';
COMMENT ON COLUMN cmt_wld.pw      IS '전시관-코멘트 암호';
COMMENT ON COLUMN cmt_wld.reg_id  IS '전시관-코멘트 생성자';
COMMENT ON COLUMN cmt_wld.reg_dt  IS '전시관-코멘트 생성일';
COMMENT ON COLUMN cmt_wld.chg_id  IS '전시관-코멘트 변경자';
COMMENT ON COLUMN cmt_wld.chg_dt  IS '전시관-코멘트 변경일';
COMMENT ON COLUMN cmt_wld.del_dt  IS '전시관-코멘트 삭제일(NULL 아닐 시 삭제된 레코드임)';

-- 전시관 좋아요 테이블의 생성
CREATE TABLE fav_wld(
      usr_idx INTEGER     NOT NULL REFERENCES usr(idx) ON DELETE CASCADE
    , wld_idx INTEGER     NOT NULL REFERENCES wld(idx) ON DELETE CASCADE
);
COMMENT ON TABLE  fav_wld         IS '전시관-좋아요';
COMMENT ON COLUMN fav_wld.usr_idx IS '회원 idx';
COMMENT ON COLUMN fav_wld.wld_idx IS '전시관 idx';



-- 구역 테이블의 생성
-- MAP은 Oracle DBMS에서 예약어로 쓰인다고 한다. 오라클을 사용할 거면 주의한다.
CREATE TABLE map(
      idx     SERIAL           PRIMARY KEY
    , wld_idx INTEGER          REFERENCES wld(idx) ON DELETE SET NULL
    , nm      VARCHAR(100)     NOT NULL
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  map         IS '구역';
COMMENT ON COLUMN map.idx     IS '구역 idx';
COMMENT ON COLUMN map.wld_idx IS '전시관 idx';
COMMENT ON COLUMN map.nm      IS '구역 명';
COMMENT ON COLUMN map.reg_id  IS '구역 생성자';
COMMENT ON COLUMN map.reg_dt  IS '구역 생성일';
COMMENT ON COLUMN map.chg_id  IS '구역 변경자';
COMMENT ON COLUMN map.chg_dt  IS '구역 변경일';
COMMENT ON COLUMN map.del_dt  IS '구역 삭제일(NULL 아닐 시 삭제된 레코드임)';

-- 구역 코멘트 테이블의 생성
CREATE TABLE cmt_map(
      idx     SERIAL           PRIMARY KEY
    , map_idx INTEGER          REFERENCES map(idx) ON DELETE SET NULL
    , txt     TEXT             NOT NULL
    , pw      VARCHAR(50)
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  cmt_map         IS '구역-코멘트';
COMMENT ON COLUMN cmt_map.idx     IS '구역-코멘트 idx';
COMMENT ON COLUMN cmt_map.map_idx IS '구역 idx';
COMMENT ON COLUMN cmt_map.txt     IS '구역-코멘트 내용';
COMMENT ON COLUMN cmt_map.pw      IS '구역-코멘트 암호';
COMMENT ON COLUMN cmt_map.reg_id  IS '구역-코멘트 생성자';
COMMENT ON COLUMN cmt_map.reg_dt  IS '구역-코멘트 생성일';
COMMENT ON COLUMN cmt_map.chg_id  IS '구역-코멘트 변경자';
COMMENT ON COLUMN cmt_map.chg_dt  IS '구역-코멘트 변경일';
COMMENT ON COLUMN cmt_map.del_dt  IS '구역-코멘트 삭제일(NULL 아닐 시 삭제된 레코드임)';



-- 지점 테이블의 생성
CREATE TABLE spt(
      idx     SERIAL           PRIMARY KEY
    , map_idx INTEGER          REFERENCES map(idx) ON DELETE SET NULL
    , nm      VARCHAR(100)     NOT NULL
    , x       INTEGER
    , y       INTEGER
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  spt         IS '지점';
COMMENT ON COLUMN spt.idx     IS '지점 idx';
COMMENT ON COLUMN spt.map_idx IS '구역 idx';
COMMENT ON COLUMN spt.nm      IS '지점 명';
COMMENT ON COLUMN spt.x       IS '지점 좌표 X';
COMMENT ON COLUMN spt.y       IS '지점 좌표 Y';
COMMENT ON COLUMN spt.reg_id  IS '지점 생성자';
COMMENT ON COLUMN spt.reg_dt  IS '지점 생성일';
COMMENT ON COLUMN spt.chg_id  IS '지점 변경자';
COMMENT ON COLUMN spt.chg_dt  IS '지점 변경일';
COMMENT ON COLUMN spt.del_dt  IS '지점 삭제일(NULL 아닐 시 삭제된 레코드임)';

-- 지점 코멘트 테이블의 생성
CREATE TABLE cmt_spt(
      idx     SERIAL           PRIMARY KEY
    , spt_idx INTEGER          REFERENCES spt(idx) ON DELETE SET NULL
    , txt     TEXT             NOT NULL
    , pw      VARCHAR(50)
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , chg_id  VARCHAR(50)
    , chg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  cmt_spt         IS '지점-코멘트';
COMMENT ON COLUMN cmt_spt.idx     IS '지점-코멘트 idx';
COMMENT ON COLUMN cmt_spt.spt_idx IS '지점 idx';
COMMENT ON COLUMN cmt_spt.txt     IS '지점-코멘트 내용';
COMMENT ON COLUMN cmt_spt.pw      IS '지점-코멘트 암호';
COMMENT ON COLUMN cmt_spt.reg_id  IS '지점-코멘트 생성자';
COMMENT ON COLUMN cmt_spt.reg_dt  IS '지점-코멘트 생성일';
COMMENT ON COLUMN cmt_spt.chg_id  IS '지점-코멘트 변경자';
COMMENT ON COLUMN cmt_spt.chg_dt  IS '지점-코멘트 변경일';
COMMENT ON COLUMN cmt_spt.del_dt  IS '지점-코멘트 삭제일(NULL 아닐 시 삭제된 레코드임)';


-- 지점 좋아요 테이블의 생성
CREATE TABLE fav_spt(
      usr_idx     INTEGER      NOT NULL REFERENCES usr(idx) ON DELETE CASCADE
    , spt_idx     INTEGER      NOT NULL REFERENCES spt(idx) ON DELETE CASCADE
);
COMMENT ON TABLE  fav_spt         IS '지점-좋아요';
COMMENT ON COLUMN fav_spt.usr_idx IS '회원 idx';
COMMENT ON COLUMN fav_spt.spt_idx IS '지점 idx';


-- 사진 테이블의 생성
CREATE TABLE pht(
      idx     SERIAL           PRIMARY KEY
    , usr_idx INTEGER          REFERENCES usr(idx) ON DELETE SET NULL
    , spt_idx INTEGER          REFERENCES spt(idx) ON DELETE SET NULL
    , upld_nm VARCHAR(256)     NOT NULL
    , save_nm VARCHAR(256)     NOT NULL
    , path    VARCHAR(256)     NOT NULL
    , size    INTEGER          NOT NULL
    , type    VARCHAR(256)     NOT NULL
    , sht_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , angle   INTEGER
    , reg_id  VARCHAR(50)
    , reg_dt  DATE             NOT NULL DEFAULT CURRENT_DATE
    , del_dt  DATE
);
COMMENT ON TABLE  pht         IS '사진';
COMMENT ON COLUMN pht.idx     IS '사진 idx';
COMMENT ON COLUMN pht.usr_idx IS '회원 idx';
COMMENT ON COLUMN pht.spt_idx IS '지점 idx';
COMMENT ON COLUMN pht.upld_nm IS '사진 파일명(사용자측)';
COMMENT ON COLUMN pht.save_nm IS '사진 파일명(서버측)';
COMMENT ON COLUMN pht.path    IS '사진 저장경로';
COMMENT ON COLUMN pht.size    IS '사진 파일크기';
COMMENT ON COLUMN pht.type    IS '사진 파일유형';
COMMENT ON COLUMN pht.sht_dt  IS '사진 촬영일';
COMMENT ON COLUMN pht.angle   IS '사진 Z각도';
COMMENT ON COLUMN pht.reg_id  IS '사진 생성자';
COMMENT ON COLUMN pht.reg_dt  IS '사진 생성일';
COMMENT ON COLUMN pht.del_dt  IS '사진 삭제일(NULL 아닐 시 삭제된 레코드임)';

-- 사진 좋아요 테이블의 생성
CREATE TABLE fav_pht(
      usr_idx INTEGER          NOT NULL REFERENCES usr(idx) ON DELETE CASCADE
    , pht_idx INTEGER          NOT NULL REFERENCES pht(idx) ON DELETE CASCADE 
);
COMMENT ON TABLE  fav_pht         IS '사진-좋아요';
COMMENT ON COLUMN fav_pht.usr_idx IS '회원 idx';
COMMENT ON COLUMN fav_pht.pht_idx IS '사진 idx';
