/* PLZDAENGS_USER */
DROP TABLE PLZ_USER 
	CASCADE CONSTRAINTS;

/* GROUP */
DROP TABLE PLZ_GROUP 
	CASCADE CONSTRAINTS;

/* GROUP_MEMBER */
DROP TABLE PLZ_GROUP_MEMBER 
	CASCADE CONSTRAINTS;

/* GROUP_CHAT */
DROP TABLE PLZ_GROUP_CHAT 
	CASCADE CONSTRAINTS;

/* PLZ_PET */
DROP TABLE PLZ_PET 
	CASCADE CONSTRAINTS;

/* DIARY */
DROP TABLE PLZ_DIARY 
	CASCADE CONSTRAINTS;

/* PLZ_BREED */
DROP TABLE PLZ_BREED 
	CASCADE CONSTRAINTS;

/* PLZ_ANIMAL */
DROP TABLE PLZ_ANIMAL 
	CASCADE CONSTRAINTS;

/* VACCINATION */
DROP TABLE PLZ_VACCINATION 
	CASCADE CONSTRAINTS;

/* TAKEVACCIN */
DROP TABLE PLZ_TAKEVACCIN 
	CASCADE CONSTRAINTS;

/* GROUP_MEETING */
DROP TABLE PLZ_GROUP_MEETING 
	CASCADE CONSTRAINTS;

/* BOARD */
DROP TABLE PLZ_BOARD 
	CASCADE CONSTRAINTS;

/* USER_DETAIL */
DROP TABLE PLZ_USER_DETAIL 
	CASCADE CONSTRAINTS;

/* REPLY */
DROP TABLE PLZ_REPLY 
	CASCADE CONSTRAINTS;

/* BOARD_CATEGORY */
DROP TABLE PLZ_BOARD_CATEGORY 
	CASCADE CONSTRAINTS;

/* LIKES */
DROP TABLE PLZ_LIKES 
	CASCADE CONSTRAINTS;

/* DIARY_CATEGORY */
DROP TABLE PLZ_DIARY_CATEGORY 
	CASCADE CONSTRAINTS;

/* GROUP_TYPE */
DROP TABLE PLZ_GROUP_TYPE 
	CASCADE CONSTRAINTS;

/* MEETING_MEMBER */
DROP TABLE PLZ_MEETING_MEMBER 
	CASCADE CONSTRAINTS;

/* PLZDAENGS_USER */
CREATE TABLE PLZ_USER (
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	password VARCHAR2(32), /* 패스워드 */
	emailid VARCHAR2(32), /* 이메일ID */
	emaildomain VARCHAR2(64), /* 이메일DOMAIN */
	nickname VARCHAR2(64), /* 닉네임 */
	user_img VARCHAR2(128), /* 유저프로필 */
	authority VARCHAR2(1) /* 권한 */
);

COMMENT ON TABLE PLZ_USER IS 'PLZDAENGS_USER';

COMMENT ON COLUMN PLZ_USER.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_USER.password IS '패스워드';

COMMENT ON COLUMN PLZ_USER.emailid IS '이메일ID';

COMMENT ON COLUMN PLZ_USER.emaildomain IS '이메일DOMAIN';

COMMENT ON COLUMN PLZ_USER.nickname IS '닉네임';

COMMENT ON COLUMN PLZ_USER.user_img IS '유저프로필';

COMMENT ON COLUMN PLZ_USER.authority IS '권한';

/* GROUP */
CREATE TABLE PLZ_GROUP (
	group_id NUMBER NOT NULL, /* 그룹ID */
	group_category_id VARCHAR2(1), /* 그룹카테고리ID */
	group_category_input VARCHAR2(128), /* 그룹카테고리직접입력 */
	group_name VARCHAR2(64), /* 그룹이름 */
	description VARCHAR2(1024), /* 그룹설명 */
	group_img VARCHAR2(128), /* 그룹대표이미지 */
	address_sido VARCHAR2(32), /* 주소시도 */
	address_sigungu VARCHAR2(32) /* 주소시군구 */
);

COMMENT ON TABLE PLZ_GROUP IS 'GROUP';

COMMENT ON COLUMN PLZ_GROUP.group_id IS '그룹ID';

COMMENT ON COLUMN PLZ_GROUP.group_category_id IS '오프라인
온라인
산책
지식공유
직접입력
';

COMMENT ON COLUMN PLZ_GROUP.group_category_input IS '그룹카테고리직접입력';

COMMENT ON COLUMN PLZ_GROUP.group_name IS '그룹이름';

COMMENT ON COLUMN PLZ_GROUP.description IS '그룹설명';

COMMENT ON COLUMN PLZ_GROUP.group_img IS '그룹대표이미지';

COMMENT ON COLUMN PLZ_GROUP.address_sido IS '주소시도';

COMMENT ON COLUMN PLZ_GROUP.address_sigungu IS '주소시군구';

/* GROUP_MEMBER */
CREATE TABLE PLZ_GROUP_MEMBER (
	group_id NUMBER NOT NULL, /* 그룹ID */
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	member_status VARCHAR2(1) /* 멤버분류상태 */
);

COMMENT ON TABLE PLZ_GROUP_MEMBER IS 'GROUP_MEMBER';

COMMENT ON COLUMN PLZ_GROUP_MEMBER.group_id IS '그룹ID';

COMMENT ON COLUMN PLZ_GROUP_MEMBER.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_GROUP_MEMBER.member_status IS '대표        L
신청        A
가입완료  M
탈퇴        X
';

/* GROUP_CHAT */
CREATE TABLE PLZ_GROUP_CHAT (
	group_id NUMBER NOT NULL, /* 그룹ID */
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	chat_date DATE NOT NULL, /* 채팅날짜 */
	chat_contents VARCHAR2(256) /* 채팅내용 */
);

COMMENT ON TABLE PLZ_GROUP_CHAT IS 'GROUP_CHAT';

COMMENT ON COLUMN PLZ_GROUP_CHAT.group_id IS '그룹ID';

COMMENT ON COLUMN PLZ_GROUP_CHAT.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_GROUP_CHAT.chat_date IS '채팅날짜';

COMMENT ON COLUMN PLZ_GROUP_CHAT.chat_contents IS '채팅내용';

/* PLZ_PET */
CREATE TABLE PLZ_PET (
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	pet_name VARCHAR2(64) NOT NULL, /* 펫이름 */
	animal_code VARCHAR2(32) NOT NULL, /* 동물코드 */
	breed_code VARCHAR2(32), /* 품종코드 */
	pet_gender VARCHAR2(1), /* 펫성별 */
	birth_date DATE, /* 펫생일 */
	pet_type VARCHAR2(1), /* 펫대표여부 */
	pet_img VARCHAR2(128) /* 펫이미지 */
);

COMMENT ON TABLE PLZ_PET IS 'PLZ_PET';

COMMENT ON COLUMN PLZ_PET.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_PET.pet_name IS '펫이름';

COMMENT ON COLUMN PLZ_PET.animal_code IS '동물코드';

COMMENT ON COLUMN PLZ_PET.breed_code IS '품종코드';

COMMENT ON COLUMN PLZ_PET.pet_gender IS 'M
F';

COMMENT ON COLUMN PLZ_PET.birth_date IS '펫생일';

COMMENT ON COLUMN PLZ_PET.pet_type IS 'TRUE : 대표펫
T : 대표
F : 비대표
';

COMMENT ON COLUMN PLZ_PET.pet_img IS '펫이미지';

/* DIARY */
CREATE TABLE PLZ_DIARY (
	diary_number NUMBER NOT NULL, /* 다이어리번호 */
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	category_id2 VARCHAR2(32), /* 카테고리ID */
	category_id VARCHAR2(32), /* 다이어리타입 */
	diary_date DATE, /* 다이어리날짜 */
	diary_subject VARCHAR2(256), /* 다이어리제목 */
	hashtag VARCHAR2(1024), /* 해쉬태그 */
	diary_contents CLOB, /* 다이어리내용 */
	diary_img VARCHAR2(128), /* 다이어리이미지 */
	location_x VARCHAR2(64), /* x좌표 */
	location_y VARCHAR2(64), /* y좌표 */
	create_date DATE /* 다이어리생성일 */
);

COMMENT ON TABLE PLZ_DIARY IS 'DIARY';

COMMENT ON COLUMN PLZ_DIARY.diary_number IS '다이어리번호';

COMMENT ON COLUMN PLZ_DIARY.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_DIARY.category_id2 IS '카테고리ID';

COMMENT ON COLUMN PLZ_DIARY.category_id IS '다이어리타입';

COMMENT ON COLUMN PLZ_DIARY.diary_date IS '달력에 표시되는 기준날짜';

COMMENT ON COLUMN PLZ_DIARY.diary_subject IS '다이어리제목';

COMMENT ON COLUMN PLZ_DIARY.hashtag IS '해쉬태그';

COMMENT ON COLUMN PLZ_DIARY.diary_contents IS '다이어리내용';

COMMENT ON COLUMN PLZ_DIARY.diary_img IS '다이어리이미지';

COMMENT ON COLUMN PLZ_DIARY.location_x IS 'x좌표';

COMMENT ON COLUMN PLZ_DIARY.location_y IS 'y좌표';

COMMENT ON COLUMN PLZ_DIARY.create_date IS '다이어리생성일';

/* PLZ_BREED */
CREATE TABLE PLZ_BREED (
	animal_code VARCHAR2(32) NOT NULL, /* 동물코드 */
	breed_code VARCHAR2(32) NOT NULL, /* 품종코드 */
	breed_name VARCHAR2(64) /* 품종이름 */
);

COMMENT ON TABLE PLZ_BREED IS 'PLZ_BREED';

COMMENT ON COLUMN PLZ_BREED.animal_code IS '동물코드';

COMMENT ON COLUMN PLZ_BREED.breed_code IS '품종코드';

COMMENT ON COLUMN PLZ_BREED.breed_name IS '품종이름';

/* PLZ_ANIMAL */
CREATE TABLE PLZ_ANIMAL (
	animal_code VARCHAR2(32) NOT NULL, /* 동물코드 */
	animal_name VARCHAR2(64) /* 동물종이름 */
);

COMMENT ON TABLE PLZ_ANIMAL IS 'PLZ_ANIMAL';

COMMENT ON COLUMN PLZ_ANIMAL.animal_code IS '동물코드';

COMMENT ON COLUMN PLZ_ANIMAL.animal_name IS '동물종이름';

/* VACCINATION */
CREATE TABLE PLZ_VACCINATION (
	vaccin_code VARCHAR2(32) NOT NULL, /* 백신코드 */
	vaccin_name VARCHAR2(64), /* 백신이름 */
	animal_code VARCHAR2(32), /* 동물코드 */
	vaccin_cycle NUMBER /* 접종주기 */
);

COMMENT ON TABLE PLZ_VACCINATION IS 'VACCINATION';

COMMENT ON COLUMN PLZ_VACCINATION.vaccin_code IS '백신코드';

COMMENT ON COLUMN PLZ_VACCINATION.vaccin_name IS '백신이름';

COMMENT ON COLUMN PLZ_VACCINATION.animal_code IS '동물코드';

COMMENT ON COLUMN PLZ_VACCINATION.vaccin_cycle IS '일단위로 저장함';

/* TAKEVACCIN */
CREATE TABLE PLZ_TAKEVACCIN (
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	pet_name VARCHAR2(64) NOT NULL, /* 펫이름 */
	vaccin_code VARCHAR2(32) NOT NULL /* 백신코드 */
);

COMMENT ON TABLE PLZ_TAKEVACCIN IS 'TAKEVACCIN';

COMMENT ON COLUMN PLZ_TAKEVACCIN.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_TAKEVACCIN.pet_name IS '펫이름';

COMMENT ON COLUMN PLZ_TAKEVACCIN.vaccin_code IS '백신코드';

/* GROUP_MEETING */
CREATE TABLE PLZ_GROUP_MEETING (
	meeting_id NUMBER NOT NULL, /* 미팅ID */
	group_id NUMBER, /* 그룹ID */
	meeting_title VARCHAR2(128), /* 미팅제목 */
	meeting_description VARCHAR2(256), /* 미팅설명 */
	meeting_date DATE, /* 미팅할날짜 */
	location_x VARCHAR2(128), /* 미팅장소X좌표 */
	location_y VARCHAR2(128) /* 미팅장소Y좌표 */
);

COMMENT ON TABLE PLZ_GROUP_MEETING IS 'GROUP_MEETING';

COMMENT ON COLUMN PLZ_GROUP_MEETING.meeting_id IS '미팅ID';

COMMENT ON COLUMN PLZ_GROUP_MEETING.group_id IS '그룹ID';

COMMENT ON COLUMN PLZ_GROUP_MEETING.meeting_title IS '미팅제목';

COMMENT ON COLUMN PLZ_GROUP_MEETING.meeting_description IS '미팅설명';

COMMENT ON COLUMN PLZ_GROUP_MEETING.meeting_date IS '미팅할날짜';

COMMENT ON COLUMN PLZ_GROUP_MEETING.location_x IS '미팅장소X좌표';

COMMENT ON COLUMN PLZ_GROUP_MEETING.location_y IS '미팅장소Y좌표';

/* BOARD */
CREATE TABLE PLZ_BOARD (
	post_id NUMBER NOT NULL, /* 글번호 */
	board_category_id VARCHAR2(1) NOT NULL, /* 보드카테고리ID */
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	post_subject VARCHAR2(256), /* 글제목 */
	post_contents CLOB, /* 글본문 */
	creat_date DATE, /* 생성일 */
	img_id VARCHAR2(32), /* 이미지ID */
	views NUMBER, /* 조회수 */
	group_id VARCHAR2(32) /* 그룹ID */
);

COMMENT ON TABLE PLZ_BOARD IS 'BOARD';

COMMENT ON COLUMN PLZ_BOARD.post_id IS '글번호';

COMMENT ON COLUMN PLZ_BOARD.board_category_id IS '사진3, 나눔2, 통합1 or g통합4, g사진5
';

COMMENT ON COLUMN PLZ_BOARD.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_BOARD.post_subject IS '글제목';

COMMENT ON COLUMN PLZ_BOARD.post_contents IS '글본문';

COMMENT ON COLUMN PLZ_BOARD.creat_date IS '생성일';

COMMENT ON COLUMN PLZ_BOARD.img_id IS '이미지ID';

COMMENT ON COLUMN PLZ_BOARD.views IS '조회수';

COMMENT ON COLUMN PLZ_BOARD.group_id IS '그룹ID';

/* USER_DETAIL */
CREATE TABLE PLZ_USER_DETAIL (
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	tel1 VARCHAR2(4), /* 전화번호1 */
	tel2 VARCHAR2(4), /* 전화번호2 */
	tel3 VARCHAR2(4), /* 전화번호3 */
	gender VARCHAR2(1), /* 성별 */
	zipcode VARCHAR2(5), /* 우편번호 */
	address VARCHAR2(128), /* 주소 */
	address_detail VARCHAR2(128) /* 상세주소 */
);

COMMENT ON TABLE PLZ_USER_DETAIL IS 'USER_DETAIL';

COMMENT ON COLUMN PLZ_USER_DETAIL.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_USER_DETAIL.tel1 IS '전화번호1';

COMMENT ON COLUMN PLZ_USER_DETAIL.tel2 IS '전화번호2';

COMMENT ON COLUMN PLZ_USER_DETAIL.tel3 IS '전화번호3';

COMMENT ON COLUMN PLZ_USER_DETAIL.gender IS '남자 : M
여자 : F';

COMMENT ON COLUMN PLZ_USER_DETAIL.zipcode IS '우편번호';

COMMENT ON COLUMN PLZ_USER_DETAIL.address IS '주소';

COMMENT ON COLUMN PLZ_USER_DETAIL.address_detail IS '상세주소';

/* REPLY */
CREATE TABLE PLZ_REPLY (
	reply_id NUMBER NOT NULL, /* 리플ID */
	post_id NUMBER NOT NULL, /* 글번호 */
	board_category_id VARCHAR2(1) NOT NULL, /* 게시글카테고리 */
	user_id VARCHAR2(32), /* 유저ID */
	reply_contents VARCHAR2(1024), /* 리플내용 */
	creat_date DATE /* 리플생성일 */
);

COMMENT ON TABLE PLZ_REPLY IS 'REPLY';

COMMENT ON COLUMN PLZ_REPLY.reply_id IS '리플ID';

COMMENT ON COLUMN PLZ_REPLY.post_id IS '글번호';

COMMENT ON COLUMN PLZ_REPLY.board_category_id IS '게시글카테고리';

COMMENT ON COLUMN PLZ_REPLY.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_REPLY.reply_contents IS '리플내용';

COMMENT ON COLUMN PLZ_REPLY.creat_date IS '리플생성일';

/* BOARD_CATEGORY */
CREATE TABLE PLZ_BOARD_CATEGORY (
	board_category_id VARCHAR2(1) NOT NULL, /* 보드카테고리ID */
	board_category_name VARCHAR2(64), /* 보드카테고리이름 */
	board_category_descripton VARCHAR2(1024) /* 보드카테고리설명 */
);

COMMENT ON TABLE PLZ_BOARD_CATEGORY IS 'BOARD_CATEGORY';

COMMENT ON COLUMN PLZ_BOARD_CATEGORY.board_category_id IS '보드카테고리ID';

COMMENT ON COLUMN PLZ_BOARD_CATEGORY.board_category_name IS '보드카테고리이름';

COMMENT ON COLUMN PLZ_BOARD_CATEGORY.board_category_descripton IS '보드카테고리설명';

/* LIKES */
CREATE TABLE PLZ_LIKES (
	user_id VARCHAR2(32) NOT NULL, /* 유저ID */
	post_id NUMBER NOT NULL, /* 글번호 */
	board_category_id VARCHAR2(1) NOT NULL /* 보드카테고리ID */
);

COMMENT ON TABLE PLZ_LIKES IS 'LIKES';

COMMENT ON COLUMN PLZ_LIKES.user_id IS '유저ID';

COMMENT ON COLUMN PLZ_LIKES.post_id IS '글번호';

COMMENT ON COLUMN PLZ_LIKES.board_category_id IS '보드카테고리ID';

/* DIARY_CATEGORY */
CREATE TABLE PLZ_DIARY_CATEGORY (
	category_id VARCHAR2(32) NOT NULL, /* 카테고리ID */
	category_name VARCHAR2(64), /* 카테고리이름 */
	category_description VARCHAR2(1024) /* 카테고리설명 */
);

COMMENT ON TABLE PLZ_DIARY_CATEGORY IS 'DIARY_CATEGORY';

COMMENT ON COLUMN PLZ_DIARY_CATEGORY.category_id IS '카테고리ID';

COMMENT ON COLUMN PLZ_DIARY_CATEGORY.category_name IS '카테고리이름';

COMMENT ON COLUMN PLZ_DIARY_CATEGORY.category_description IS '카테고리설명';

/* GROUP_TYPE */
CREATE TABLE PLZ_GROUP_TYPE (
	group_category_id VARCHAR2(1) NOT NULL, /* 그룹카테고리ID */
	group_category_name VARCHAR2(64), /* 그룹카테고리이름 */
	group_category_description VARCHAR2(1024) /* 그룹카테고리설명 */
);

COMMENT ON TABLE PLZ_GROUP_TYPE IS 'GROUP_TYPE';

COMMENT ON COLUMN PLZ_GROUP_TYPE.group_category__id IS '그룹카테고리ID';

COMMENT ON COLUMN PLZ_GROUP_TYPE.group_category__name IS '그룹카테고리이름';

COMMENT ON COLUMN PLZ_GROUP_TYPE.group_category__description IS '그룹카테고리설명';

/* MEETING_MEMBER */
CREATE TABLE PLZ_MEETING_MEMBER (
	meeting_id NUMBER NOT NULL, /* 미팅ID */
	group_id NUMBER NOT NULL, /* 그룹ID */
	user_id VARCHAR2(32) NOT NULL /* 유저ID */
);

COMMENT ON TABLE PLZ_MEETING_MEMBER IS 'MEETING_MEMBER';

COMMENT ON COLUMN PLZ_MEETING_MEMBER.meeting_id IS '미팅ID';

COMMENT ON COLUMN PLZ_MEETING_MEMBER.group_id IS '그룹ID';

COMMENT ON COLUMN PLZ_MEETING_MEMBER.user_id IS '유저ID';