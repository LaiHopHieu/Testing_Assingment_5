-- Ex5:
-- Ques1:
CREATE view V_Sale as
SELECT 
   *
FROM
    `account` AS A
WHERE DepartmentID IN (SELECT 
            Departmentid
        FROM
            department AS D
        WHERE
            DepartmentName = 'Sales');
-- Ques2:
CREATE VIEW V_AccinGroup as
-- Subquery:
SELECT 
    A.*,
    COUNT(GA.Accountid) AS `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia`
FROM
    `Account` AS A
        LEFT JOIN
    `group account` AS GA ON A.Accountid = GA.AccountID
GROUP BY GA.AccountID Order by `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia` DESC Limit 1;
-- Offical:
SELECT 
    A.*,
    COUNT(GA.Accountid) AS `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia`
FROM
    `Account` AS A
        LEFT JOIN
    `group account` AS GA ON A.Accountid = GA.AccountID
GROUP BY GA.AccountID Having `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia` = (SELECT 
    COUNT(GA.Accountid) AS `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia`
FROM
    `Account` AS A
        LEFT JOIN
    `group account` AS GA ON A.Accountid = GA.AccountID
GROUP BY GA.AccountID Order by `So_Luong_Group_Ma_Nhan_Vien_Tham_Gia` DESC Limit 1);

-- Ques3: 
CREATE or REPLACE VIEW V_QuesContent as
-- Subquery:
SELECT 
    *
FROM
    question
WHERE
    LENGTH(Content) < 300;
-- Offical:
SELECT * from V_QuesContent;
DELETE FROM V_QuesContent;

-- Ques4:
CREATE or REPLACE VIEW V_Max_NV as
-- Subquery:
SELECT 
    MAX(Count_DepID) AS maxDEP_ID
FROM
    (SELECT 
        COUNT(A.DepartmentID) AS COUNT_DEPID
    FROM
        `account` AS A
    GROUP BY A.DepartmentID) AS TB_COUNT_DEPID;
-- Offical:
SELECT 
    D.DepartmentName, COUNT(A.DepartmentID)
FROM
    `account` AS A
        JOIN
    department AS d ON A.DepartmentID = D.DepartmentId
GROUP BY A.DepartmentID
HAVING COUNT(A.departmentID) = (SELECT 
        MAX(Count_DepID) AS maxDEP_ID
    FROM
        (SELECT 
            COUNT(A.DepartmentID) AS COUNT_DEPID
        FROM
            `account` AS A
        GROUP BY A.DepartmentID) AS TB_COUNT_DEPID);

-- Ques5:
CREATE or REPLACE VIEW V_Nguyen as
SELECT 
    Q.CategoryID, Q.Content, A.Fullname
FROM
    question AS Q
        JOIN
    `account` AS A ON A.AccountID = Q.CreatorID