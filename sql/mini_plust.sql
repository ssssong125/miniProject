DROP VIEW VIEW_GRADE_CHECK;
DROP SEQUENCE SEQ_STUDENT_NO;

CREATE SEQUENCE SEQ_STUDENT_NO
START WITH 20220001
INCREMENT BY 1
MAXVALUE 20229999
NOCYCLE
NOCACHE;

CREATE VIEW VIEW_GRADE_CHECK
AS
SELECT
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

INSERT INTO DEPARTMENT
VALUES
('PSY', '심리학과');

INSERT INTO STUDENT
VALUES
(SEQ_STUDENT_NO.NEXTVAL, 'PSY', 'USER11', 'USER11', '확인용', NULL, '01011112222', NULL, DEFAULT, DEFAULT);

