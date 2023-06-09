--CREATE USER mini IDENTIFIED BY mini;
--GRANT CONNECT, RESOURCE TO mini;
--GRANT CREATE VIEW TO mini;
--GRANT CREATE SEQUENCE TO mini;
--GRANT CREATE TRIGGER TO mini;

DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE STUDENT_DEL CASCADE CONSTRAINTS;
DROP TABLE PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE LECTURE CASCADE CONSTRAINTS;
DROP TABLE ENROLLMENT CASCADE CONSTRAINTS;
DROP TABLE LECTURE_JUG CASCADE CONSTRAINTS;
DROP TABLE GRADE CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_STUDENT_NO;
DROP SEQUENCE SEQ_PROF_NO;
DROP SEQUENCE SEQ_ENROLL_NO;
DROP SEQUENCE SEQ_LECTURE_NO;
DROP SEQUENCE SEQ_LECTURE_JUG_NO;
DROP SEQUENCE SEQ_GRADE_NO;

CREATE TABLE DEPARTMENT
    (
    DEPT_CODE VARCHAR2(10) PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
    );
    
COMMENT ON COLUMN DEPARTMENT.DEPT_CODE IS '학과코드';
COMMENT ON COLUMN DEPARTMENT.DEPT_NAME IS '학과명';

CREATE TABLE STUDENT
    (
    STUDENT_NO NUMBER,
    DEPT_CODE VARCHAR2(10),
    STUDENT_ID VARCHAR2(20),
    STUDENT_PWD VARCHAR2(20) NOT NULL,
    STUDENT_NAME VARCHAR2(15) NOT NULL,
    ADDRESS VARCHAR2(100),
    STUDENT_TELNO VARCHAR2(15) NOT NULL,
    EMAIL VARCHAR2(100),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(2) DEFAULT 'N'
    );
    
COMMENT ON COLUMN STUDENT.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN STUDENT.DEPT_CODE IS '학과코드';
COMMENT ON COLUMN STUDENT.STUDENT_ID IS '학생아이디';
COMMENT ON COLUMN STUDENT.STUDENT_PWD IS '학생비밀번호';
COMMENT ON COLUMN STUDENT.STUDENT_NAME IS '학생이름';
COMMENT ON COLUMN STUDENT.ADDRESS IS '학생주소';
COMMENT ON COLUMN STUDENT.STUDENT_TELNO IS '학생전화번호';
COMMENT ON COLUMN STUDENT.EMAIL IS '학생이메일';
COMMENT ON COLUMN STUDENT.ENROLL_DATE IS '입학일';
COMMENT ON COLUMN STUDENT.STATUS IS '재학상태';

ALTER TABLE STUDENT ADD CONSTRAINT PK_STUDENT_NO PRIMARY KEY (STUDENT_NO);
ALTER TABLE STUDENT ADD CONSTRAINT UQ_STUDENT_ID UNIQUE (STUDENT_ID);
ALTER TABLE STUDENT ADD CONSTRAINT CK_STATUS_01 CHECK(STATUS IN('Y', 'N'));
ALTER TABLE STUDENT ADD CONSTRAINT FK_DEPT_01 FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE);

CREATE TABLE STUDENT_DEL
    (
    STUDENT_NO NUMBER,
    DEPT_CODE VARCHAR2(10),
    STUDENT_ID VARCHAR2(20),
    STUDENT_PWD VARCHAR2(20) NOT NULL,
    STUDENT_NAME VARCHAR2(15) NOT NULL,
    ADDRESS VARCHAR2(100),
    STUDENT_TELNO VARCHAR2(15) NOT NULL,
    EMAIL VARCHAR2(100),
    ENROLL_DATE DATE,
    DEL_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(2)
    );
    
COMMENT ON COLUMN STUDENT_DEL.STUDENT_NO IS '학생번호';
COMMENT ON COLUMN STUDENT_DEL.DEPT_CODE IS '학과코드';
COMMENT ON COLUMN STUDENT_DEL.STUDENT_ID IS '학생아이디';
COMMENT ON COLUMN STUDENT_DEL.STUDENT_PWD IS '학생비밀번호';
COMMENT ON COLUMN STUDENT_DEL.STUDENT_NAME IS '학생이름';
COMMENT ON COLUMN STUDENT_DEL.ADDRESS IS '학생주소';
COMMENT ON COLUMN STUDENT_DEL.STUDENT_TELNO IS '학생전화번호';
COMMENT ON COLUMN STUDENT_DEL.EMAIL IS '학생이메일';
COMMENT ON COLUMN STUDENT_DEL.ENROLL_DATE IS '입학일';
COMMENT ON COLUMN STUDENT_DEL.DEL_DATE IS '탈퇴일';
COMMENT ON COLUMN STUDENT_DEL.STATUS IS '재학상태';

CREATE TABLE PROFESSOR
    (
    PROF_NO NUMBER,
    DEPT_CODE VARCHAR2(10),
    PROF_ID VARCHAR2(20),
    PROF_PWD VARCHAR2(20) NOT NULL,
    PROF_NAME VARCHAR2(15) NOT NULL,
    ADDRESS VARCHAR2(100),
    PROF_TELNO VARCHAR2(15) NOT NULL,
    EMAIL VARCHAR2(100),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(2) DEFAULT 'N'
    );
   
COMMENT ON COLUMN PROFESSOR.PROF_NO IS '교수번호';
COMMENT ON COLUMN PROFESSOR.DEPT_CODE IS '학과코드';
COMMENT ON COLUMN PROFESSOR.PROF_ID IS '교수아이디';
COMMENT ON COLUMN PROFESSOR.PROF_PWD IS '교수비밀번호';
COMMENT ON COLUMN PROFESSOR.PROF_NAME IS '교수이름';
COMMENT ON COLUMN PROFESSOR.ADDRESS IS '교수주소';
COMMENT ON COLUMN PROFESSOR.PROF_TELNO IS '교수전화번호';
COMMENT ON COLUMN PROFESSOR.EMAIL IS '교수이메일';
COMMENT ON COLUMN PROFESSOR.ENROLL_DATE IS '입사일';
COMMENT ON COLUMN PROFESSOR.STATUS IS '재직상태';

ALTER TABLE PROFESSOR ADD CONSTRAINT PK_PROF_NO PRIMARY KEY (PROF_NO);
ALTER TABLE PROFESSOR ADD CONSTRAINT UQ_PROF_ID UNIQUE (PROF_ID);
ALTER TABLE PROFESSOR ADD CONSTRAINT CK_STATUS_02 CHECK(STATUS IN('Y', 'N'));
ALTER TABLE PROFESSOR ADD CONSTRAINT FK_DEPT_02 FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE);

CREATE TABLE LECTURE (
    DEPT_CODE VARCHAR2(10),
    LECTURE_NO NUMBER,
    PROF_NO NUMBER,
    LECTURE_NAME VARCHAR2(30),
    CREDIT CHAR(1),
    CURR_NO NUMBER DEFAULT 0,
    FULL_NO NUMBER NOT NULL,
    "DAY" VARCHAR2(10) NOT NULL,
    "TIME" VARCHAR2(10) NOT NULL
    );

COMMENT ON COLUMN LECTURE.LECTURE_NO IS '강의번호';
COMMENT ON COLUMN LECTURE.DEPT_CODE IS '학과코드';
COMMENT ON COLUMN LECTURE.PROF_NO IS '교수번호';
COMMENT ON COLUMN LECTURE.LECTURE_NAME IS '강의명';
COMMENT ON COLUMN LECTURE.CREDIT IS '수강학점';
COMMENT ON COLUMN LECTURE.CURR_NO IS '수강인원';
COMMENT ON COLUMN LECTURE.FULL_NO IS '정원인원';
COMMENT ON COLUMN LECTURE."DAY" IS '요일';
COMMENT ON COLUMN LECTURE."TIME" IS '시간';

ALTER TABLE LECTURE ADD CONSTRAINT PK_LECTURE PRIMARY KEY (LECTURE_NO);
ALTER TABLE LECTURE ADD CONSTRAINT CK_CREDIT CHECK(CREDIT BETWEEN 1 AND 3);
ALTER TABLE LECTURE ADD CONSTRAINT CK_CURR_NO CHECK(CURR_NO <= FULL_NO);
ALTER TABLE LECTURE ADD CONSTRAINT FK_DEPT_03 FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE);
ALTER TABLE LECTURE ADD CONSTRAINT FK_PROF_01 FOREIGN KEY (PROF_NO) REFERENCES PROFESSOR(PROF_NO);

CREATE TABLE ENROLLMENT(
    ENROLL_ID NUMBER,
    STUDENT_NO NUMBER,
    LECTURE_NO NUMBER
    );
    
COMMENT ON COLUMN ENROLLMENT.ENROLL_ID IS '수강신청번호';
COMMENT ON COLUMN ENROLLMENT.STUDENT_NO IS '학번';
COMMENT ON COLUMN ENROLLMENT.LECTURE_NO IS '강의번호';
    
ALTER TABLE ENROLLMENT ADD CONSTRAINT PK_ENROLLMENT PRIMARY KEY (ENROLL_ID);
ALTER TABLE ENROLLMENT ADD CONSTRAINT FK_STUDENT_NO_01 FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(STUDENT_NO) ON DELETE CASCADE;
ALTER TABLE ENROLLMENT ADD CONSTRAINT FK_LECT_01 FOREIGN KEY (LECTURE_NO) REFERENCES LECTURE(LECTURE_NO);   
    
CREATE TABLE LECTURE_JUG (
    JUDGEMENT_NO NUMBER,
    LECTURE_NO NUMBER,
    STUDENT_NO NUMBER,
    PROF_NO NUMBER(10),
    STU_JUG_SCORE NUMBER, -- CHECK (STU_JUG_SCORE BETWEEN 1 AND 5),
    STU_ONE_JUG VARCHAR2(100)
    );

COMMENT ON COLUMN LECTURE_JUG.JUDGEMENT_NO IS '강의 평가 번호';
COMMENT ON COLUMN LECTURE_JUG.LECTURE_NO IS '강의 번호';
COMMENT ON COLUMN LECTURE_JUG.STUDENT_NO IS '학번';
COMMENT ON COLUMN LECTURE_JUG.PROF_NO IS '교수 번호';
COMMENT ON COLUMN LECTURE_JUG.STU_JUG_SCORE IS '학생 만족도 점수';
COMMENT ON COLUMN LECTURE_JUG.STU_ONE_JUG IS '학생 한줄 평가';

ALTER TABLE LECTURE_JUG ADD CONSTRAINT PK_LECTURE_JUG PRIMARY KEY (JUDGEMENT_NO);
ALTER TABLE LECTURE_JUG ADD CONSTRAINT FK_STUDENT_NO_02  FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(STUDENT_NO) ON DELETE CASCADE;
ALTER TABLE LECTURE_JUG ADD CONSTRAINT FK_LECT_02 FOREIGN KEY (LECTURE_NO) REFERENCES LECTURE(LECTURE_NO);   
ALTER TABLE LECTURE_JUG ADD CONSTRAINT FK_PROF_02 FOREIGN KEY (PROF_NO) REFERENCES PROFESSOR(PROF_NO);   

CREATE TABLE GRADE (
    GRADE_NO NUMBER,
    LECTURE_NO NUMBER,
    PROF_NO NUMBER,
    STUDENT_NO NUMBER,
    ATT_SCORE NUMBER DEFAULT 0,
    ASS_SCORE NUMBER DEFAULT 0,
    MID_SCORE NUMBER DEFAULT 0,
    FIN_SCORE NUMBER DEFAULT 0,
    GRADE VARCHAR2(5) DEFAULT 'N'
    );
    
COMMENT ON COLUMN GRADE.GRADE_NO IS '학점 번호';
COMMENT ON COLUMN GRADE.LECTURE_NO IS '강의 번호';
COMMENT ON COLUMN GRADE.PROF_NO IS '교수 번호';
COMMENT ON COLUMN GRADE.STUDENT_NO IS '학번';
COMMENT ON COLUMN GRADE.ATT_SCORE IS '출석점수';
COMMENT ON COLUMN GRADE.ASS_SCORE IS '과제점수';
COMMENT ON COLUMN GRADE.MID_SCORE IS '중간점수';
COMMENT ON COLUMN GRADE.FIN_SCORE IS '기말점수';
COMMENT ON COLUMN GRADE.GRADE IS '학번';
    
ALTER TABLE GRADE ADD CONSTRAINT PK_GRADE_NO PRIMARY KEY (GRADE_NO);
ALTER TABLE GRADE ADD CONSTRAINT FK_STUDENT_NO_03  FOREIGN KEY (STUDENT_NO) REFERENCES STUDENT(STUDENT_NO) ON DELETE CASCADE;
ALTER TABLE GRADE ADD CONSTRAINT FK_LECT_03 FOREIGN KEY (LECTURE_NO) REFERENCES LECTURE(LECTURE_NO);   
ALTER TABLE GRADE ADD CONSTRAINT FK_PROF_03 FOREIGN KEY (PROF_NO) REFERENCES PROFESSOR(PROF_NO); 
ALTER TABLE GRADE ADD CONSTRAINT CK_SCORE_01 CHECK(ATT_SCORE BETWEEN 0 AND 10);
ALTER TABLE GRADE ADD CONSTRAINT CK_SCORE_02 CHECK (ASS_SCORE BETWEEN 0 AND 30);
ALTER TABLE GRADE ADD CONSTRAINT CK_SCORE_03 CHECK (MID_SCORE BETWEEN 0 AND 30);
ALTER TABLE GRADE ADD CONSTRAINT CK_SCORE_04 CHECK (FIN_SCORE BETWEEN 0 AND 30);
    
CREATE SEQUENCE SEQ_STUDENT_NO
START WITH 20220001
INCREMENT BY 1
MAXVALUE 20229999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_PROF_NO
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_ENROLL_NO
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_LECTURE_NO
START WITH 100
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_LECTURE_JUG_NO
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_GRADE_NO
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE OR REPLACE VIEW VIEW_GRADE_CHECK
AS
SELECT
       A.GRADE_NO GRADE_NO,
       D.LECTURE_NAME LECTURE_NAME,
       B.PROF_NAME PROF_NAME,
       A.STUDENT_NO STUDENT_NO,
       C.STUDENT_NAME STUDENT_NAME,
       A.ATT_SCORE ATT_SCORE,
       A.ASS_SCORE ASS_SCORE,
       A.MID_SCORE MID_SCORE,
       A.FIN_SCORE FIN_SCORE,
       A.GRADE GRADE
  FROM GRADE A
  JOIN PROFESSOR B
    ON A.PROF_NO = B.PROF_NO
  JOIN STUDENT C
    ON A.STUDENT_NO = C.STUDENT_NO
  JOIN LECTURE D
    ON A.LECTURE_NO = D.LECTURE_NO;
    
CREATE OR REPLACE VIEW VIEW_ENROLLMENT_LECTURE
(ENROLL_ID, STUDENT_NO, LECTURE_NO, DAY, FIRST_CLASS, SECOND_CLASS, CREDIT)
AS
SELECT 
    A.ENROLL_ID
    , A.STUDENT_NO
    , A.LECTURE_NO
--    , B.DAY
    , DECODE(SUBSTR(B.DAY, 1, 1), '월', 0, '화', 1, '수', 2, '목', 3, '금', 4 )
    , (SUBSTR(B.TIME, 1, 1) - 1)
    , (SUBSTR(B.TIME, 4, 1) - 1)
    , B.CREDIT
FROM ENROLLMENT A    
LEFT JOIN LECTURE B ON A.LECTURE_NO = B.LECTURE_NO;
    
CREATE OR REPLACE TRIGGER TRG_STUDENT_DEL_01
    BEFORE DELETE ON STUDENT
    FOR EACH ROW
BEGIN
    INSERT INTO STUDENT_DEL
    VALUES(:OLD.STUDENT_NO, :OLD.DEPT_CODE, :OLD.STUDENT_ID, :OLD.STUDENT_PWD, :OLD.STUDENT_NAME, :OLD.ADDRESS, 
    :OLD.STUDENT_TELNO, :OLD.EMAIL, :OLD.ENROLL_DATE, DEFAULT, 'Y');
END;
/

CREATE OR REPLACE TRIGGER TRG_ENROLL
    AFTER INSERT ON ENROLLMENT
    FOR EACH ROW
BEGIN
    UPDATE LECTURE
       SET CURR_NO = CURR_NO + 1
     WHERE LECTURE_NO = :NEW.LECTURE_NO;
END;
/

CREATE OR REPLACE TRIGGER TRH_CANCEL_ENROLL
    AFTER DELETE ON ENROLLMENT
    FOR EACH ROW
BEGIN
    UPDATE LECTURE
       SET CURR_NO = CURR_NO - 1
     WHERE LECTURE_NO = :NEW.LECTURE_NO;
END;
/

INSERT INTO DEPARTMENT VALUES ('PSY', '심리학과');
INSERT INTO DEPARTMENT VALUES ('CHE', '화학공학과');
INSERT INTO DEPARTMENT VALUES ('CSE', '컴퓨터공학과');
INSERT INTO DEPARTMENT VALUES ('ELE', '전기공학과');
INSERT INTO DEPARTMENT VALUES ('ENG', '영어영문학과');
INSERT INTO DEPARTMENT VALUES ('ECO', '경제학과');
INSERT INTO DEPARTMENT VALUES ('PHY', '체육학과');
INSERT INTO DEPARTMENT VALUES ('BUS', '경영학과');
INSERT INTO DEPARTMENT VALUES ('GEC', '교양학부');

INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PSY', 'user00', 'user00', '확인용', NULL, '01011112222', NULL, DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CHE', 'user01', 'user01', '김수영', '경기도 시흥시', '01011113333', 'ksy01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ELE', 'user02', 'user02', '서진수', '서울시 강동구', '01011114444', 'sjs01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CHE', 'user03', 'user03', '오수재', '서울시 영등포구', '01011115555', 'osj35@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CSE', 'user04', 'user04', '이정호', '경기도 구리', '01011116666', 'ljh01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ECO', 'user05', 'user05', '유지석', '서울시 강남구', '01011117777', 'yjs01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PHY', 'user06', 'user06', '이호리', '제주도 서귀포시', '01011118888', 'lhr01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'BUS', 'user07', 'user07', '정중앙', '서울시 강서구', '01011119999', 'jja01@hanmail.net', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PSY', 'user08', 'user08', '하동운', '서울시 강북구', '01022229999', 'hdw01@hanmail.net', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ECO', 'user09', 'user09', '길성주', '서울시 양천구', '01022228888', 'gsj01@hotmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CHE', 'user10', 'user10', '손지동', '서울시 금천구', '01022227777', 'sjd01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ELE', 'user11', 'user11', '구운모', '서울시 노원구', '01022226666', 'gwm01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PSY', 'user12', 'user12', '김태연', '충청도 태안', '01022225555', 'kty01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ENG', 'user13', 'user13', '정근오', '경기도 일산', '01022224444', 'jgh01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'ENG', 'user14', 'user14', '김철수', '경기도 파주', '01022223333', 'kcs01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PHY', 'user15', 'user15', '박경운', '강원도 강릉 ', '01022222222', 'pkw01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PHY', 'user16', 'user16', '박진서', '서울시 동작구 ', '01022221111', 'pjs01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CSE', 'user17', 'user17', '강지녕', '울산시 남구', '01033331111', 'kjs01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'BUS', 'user18', 'user18', '김창운', '전라남도 순천시', '01033332222', 'kcw01@gmail.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CHE', 'user19', 'user19', '엄태연', '서울시 관악구', '01033333333', 'uth01@naver.com', DEFAULT, DEFAULT);
INSERT INTO STUDENT VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'CHE', 'user20', 'user20', '유군오', '서울시 은평구', '01033334444', 'ygh01@naver.com', DEFAULT, DEFAULT);

INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'PSY', 'prof01', 'prof01', '오심리', '서울시 동작구', '01011112222', 'osl01@naver.com', '01/01/01', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'CHE', 'prof02', 'prof02', '김화공', '경기도 시흥시', '01077778888', 'ksy85@gmail.com', '14/07/26', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'CSE', 'prof03', 'prof03', '이컴공', '서울시 신길동', '01044445555', 'ljh02@gmail.com', '15/02/04', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'ELE', 'prof04', 'prof04', '서전기', '서울시 강동구', '01066669999', 'sjs03@yahoo.com', '10/07/07', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'ENG', 'prof05', 'prof05', '최영어', '대구시 경산시', '01088882222', 'cis88@gmail.com', '15/07/20', DEFAULT);
INSERT INTO PROFESSOR VALUES
(SEQ_PROF_NO.NEXTVAL, 'ECO', 'prof06', 'prof06', '한경제', '강원도 속초시', '01012342222', 'hgj99@gmail.com', '20/01/20', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'PHY', 'prof07', 'prof07', '공체육', '경기도 용인시', '01012347777', 'gcy12@gmail.com', '21/01/20', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'BUS', 'prof08', 'prof08', '하경영', '서울시 경복궁', '01099999999', 'hgy12@gmail.com', '03/12/29', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'GEC', 'prof09', 'prof09', '허수학', '인천시 가좌동', '01000009999', 'hsh44@gmail.com', '09/11/29', DEFAULT);
INSERT INTO PROFESSOR VALUES 
(SEQ_PROF_NO.NEXTVAL, 'GEC', 'prof10', 'prof10', '정과학', '시흥시 거모동', '0112457464', 'jgh77@gmail.com', '07/07/07', DEFAULT);

--DEPT_CODE LECTURE_NO PROF_NO LECTURE_NAME CREDIT CURR_NO FULL_NO DAY TIME
INSERT INTO LECTURE VALUES
('PSY', SEQ_LECTURE_NO.NEXTVAL, 1, '일반심리학', '3', DEFAULT, 20, '목', '8, 9');

INSERT INTO LECTURE VALUES
('PSY', SEQ_LECTURE_NO.NEXTVAL, 1, '발달심리학', '3', DEFAULT, 20, '수', '2, 3');

INSERT INTO LECTURE VALUES
('PSY', SEQ_LECTURE_NO.NEXTVAL, 1, '인지심리학', '3', DEFAULT, 20, '월', '5, 6');

INSERT INTO LECTURE VALUES
('PSY', SEQ_LECTURE_NO.NEXTVAL, 1, '상담심리학', '3', DEFAULT, 20, '금', '1, 2');

INSERT INTO LECTURE VALUES
('PSY', SEQ_LECTURE_NO.NEXTVAL, 1, '학습심리학', '3', DEFAULT, 20, '화', '4, 5');

INSERT INTO LECTURE VALUES
('CHE', SEQ_LECTURE_NO.NEXTVAL, 2, '응용생물학', '3', DEFAULT, 20, '수', '6, 7');

INSERT INTO LECTURE VALUES
('CHE', SEQ_LECTURE_NO.NEXTVAL, 2, '응용생화학', '3', DEFAULT, 20, '월', '2, 3');

INSERT INTO LECTURE VALUES
('CHE', SEQ_LECTURE_NO.NEXTVAL, 2, '생명공학실험', '3', DEFAULT, 20, '금', '1, 2');

INSERT INTO LECTURE VALUES
('CHE', SEQ_LECTURE_NO.NEXTVAL, 2, '화공열역학', '3', DEFAULT, 20, '화', '4, 5');

INSERT INTO LECTURE VALUES
('CHE', SEQ_LECTURE_NO.NEXTVAL, 2, '화공유체역학', '3', DEFAULT, 20, '목', '8, 9');

INSERT INTO LECTURE VALUES
('CSE', SEQ_LECTURE_NO.NEXTVAL, 3, '컴퓨터프로그래밍', '3', DEFAULT, 20, '화', '8, 9');

INSERT INTO LECTURE VALUES
('CSE', SEQ_LECTURE_NO.NEXTVAL, 3, '디지털회로개론', '3', DEFAULT, 20, '월', '2, 3');

INSERT INTO LECTURE VALUES
('CSE', SEQ_LECTURE_NO.NEXTVAL, 3, '컴퓨터공학실험', '3', DEFAULT, 20, '목', '6, 7');

INSERT INTO LECTURE VALUES
('CSE', SEQ_LECTURE_NO.NEXTVAL, 3, '자바언어', '3', DEFAULT, 20, '금', '3, 4');

INSERT INTO LECTURE VALUES
('CSE', SEQ_LECTURE_NO.NEXTVAL, 3, '운영체제', '3', DEFAULT, 20, '수', '4, 5');

INSERT INTO LECTURE VALUES
('ELE', SEQ_LECTURE_NO.NEXTVAL, 4, '회로이론', '3', DEFAULT, 20, '월', '1, 2');

INSERT INTO LECTURE VALUES
('ELE', SEQ_LECTURE_NO.NEXTVAL, 4, '전자기학', '3', DEFAULT, 20, '화', '3, 4');

INSERT INTO LECTURE VALUES
('ELE', SEQ_LECTURE_NO.NEXTVAL, 4, '공학수학', '3', DEFAULT, 20, '수', '5, 6');

INSERT INTO LECTURE VALUES
('ELE', SEQ_LECTURE_NO.NEXTVAL, 4, '전력공학', '3', DEFAULT, 20, '목', '7, 8');

INSERT INTO LECTURE VALUES
('ELE', SEQ_LECTURE_NO.NEXTVAL, 4, '전력설비', '3', DEFAULT, 20, '금', '4, 5');

INSERT INTO LECTURE VALUES
('ENG', SEQ_LECTURE_NO.NEXTVAL, 5, '영문학개론', '3', DEFAULT, 20, '목', '5, 6');

INSERT INTO LECTURE VALUES
('ENG', SEQ_LECTURE_NO.NEXTVAL, 5, '영미수필', '3', DEFAULT, 20, '금', '8, 9');

INSERT INTO LECTURE VALUES
('ENG', SEQ_LECTURE_NO.NEXTVAL, 5, '영문학작문', '3', DEFAULT, 20, '월', '1, 2');

INSERT INTO LECTURE VALUES
('ENG', SEQ_LECTURE_NO.NEXTVAL, 5, '셰익스피어', '3', DEFAULT, 20, '화', '2, 3');

INSERT INTO LECTURE VALUES
('ENG', SEQ_LECTURE_NO.NEXTVAL, 5, '현대미국소설', '3', DEFAULT, 20, '수', '7, 8');

INSERT INTO LECTURE VALUES
('ECO', SEQ_LECTURE_NO.NEXTVAL, 6, '경제학원론', '3', DEFAULT, 20, '금', '8, 9');

INSERT INTO LECTURE VALUES
('ECO', SEQ_LECTURE_NO.NEXTVAL, 6, '경제통계학', '3', DEFAULT, 20, '목', '6, 7');

INSERT INTO LECTURE VALUES
('ECO', SEQ_LECTURE_NO.NEXTVAL, 6, '미시경제학', '3', DEFAULT, 20, '수', '4, 5');

INSERT INTO LECTURE VALUES
('ECO', SEQ_LECTURE_NO.NEXTVAL, 6, '거시경제학', '3', DEFAULT, 20, '화', '2, 3');

INSERT INTO LECTURE VALUES
('ECO', SEQ_LECTURE_NO.NEXTVAL, 6, '계량경제학', '3', DEFAULT, 20, '월', '1, 2');

INSERT INTO LECTURE VALUES
('PHY', SEQ_LECTURE_NO.NEXTVAL, 7, '축구학', '3', DEFAULT, 20, '목', '5, 6');

INSERT INTO LECTURE VALUES
('PHY', SEQ_LECTURE_NO.NEXTVAL, 7, '농구학', '3', DEFAULT, 20, '월', '7, 8');

INSERT INTO LECTURE VALUES
('PHY', SEQ_LECTURE_NO.NEXTVAL, 7, '야구학', '3', DEFAULT, 20, '화', '3, 4');

INSERT INTO LECTURE VALUES
('PHY', SEQ_LECTURE_NO.NEXTVAL, 7, '배구학', '3', DEFAULT, 20, '금', '1, 2');

INSERT INTO LECTURE VALUES
('PHY', SEQ_LECTURE_NO.NEXTVAL, 7, '탁구학', '3', DEFAULT, 20, '수', '8, 9');

INSERT INTO LECTURE VALUES
('BUS', SEQ_LECTURE_NO.NEXTVAL, 8, '관리회계', '3', DEFAULT, 20, '화', '1, 2');

INSERT INTO LECTURE VALUES
('BUS', SEQ_LECTURE_NO.NEXTVAL, 8, '경영통계학', '3', DEFAULT, 20, '수', '4, 5');

INSERT INTO LECTURE VALUES
('BUS', SEQ_LECTURE_NO.NEXTVAL, 8, '회계학원론', '3', DEFAULT, 20, '목', '6, 7');

INSERT INTO LECTURE VALUES
('BUS', SEQ_LECTURE_NO.NEXTVAL, 8, '재무관리', '3', DEFAULT, 20, '금', '1, 2');

INSERT INTO LECTURE VALUES
('BUS', SEQ_LECTURE_NO.NEXTVAL, 8, '경영전략', '3', DEFAULT, 20, '월', '7, 8');

INSERT INTO LECTURE VALUES
('GEC', SEQ_LECTURE_NO.NEXTVAL, 8, '경제의정석', '3', DEFAULT, 20, '금', '1, 2');

INSERT INTO LECTURE VALUES
('GEC', SEQ_LECTURE_NO.NEXTVAL, 9, '수학의정석', '3', DEFAULT, 20, '월', '2, 3');

INSERT INTO LECTURE VALUES
('GEC', SEQ_LECTURE_NO.NEXTVAL, 10, '과학의정석', '3', DEFAULT, 20, '수', '4, 5');

INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220001, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220001, 101);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220001, 102);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220001, 103);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220003, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220004, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220005, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220006, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220007, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220008, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220009, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220010, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220011, 100);
INSERT INTO ENROLLMENT VALUES (SEQ_ENROLL_NO.NEXTVAL, 20220012, 100);

-- 확인용
--DELETE FROM STUDENT WHERE STUDENT_NO = 20220001;

COMMIT;
--ROLLBACK;
