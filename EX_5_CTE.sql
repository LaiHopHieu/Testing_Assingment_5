-- Câu 1: Tìm danh sách nhân viên thuộc phòng ban Sale sao cho fullname có độ dài lớn hơn độ dài TB Fullname của nhân viên phòng bn đó
WITH Acc_In_Sales as (SELECT 
    A.*
FROM
    `account` AS A
        JOIN
    Department D ON A.departmentid = D.Departmentid
WHERE
    D.DepartmentName = 'Sales'),
Trung_binh_do_dai_fullname_của_AccInSales as (SELECT avg(length(fullname)) as do_dai_trung_binh from Acc_In_Sales)
Select * from Acc_In_Sales where length(fullname) > (select do_dai_trung_binh from Trung_binh_do_dai_fullname_của_AccInSales);

-- Câu 2: 
WITH thong_tin_account_nhieu_group_nhat as (SELECT 
    A.*, COUNT(GA.AccountID) as So_luong_Group_ma_account_tham_gia
FROM
    `account` A
        JOIN
    `group account` GA ON A.Accountid = GA.Accountid
GROUP BY GA.AccountID), 
So_Group_nhieu_nhat_ma_acc_tham_gia as ( 
SELECT * from Thông_tin_account_va_so_group_tham_gia 
ORDER BY So_luong_Group_ma_account_tham_gia DESC);

-- Câu 3:
WITH So_cau_hoi_co_nhung_content_qua_dai as (SELECT 
    *
FROM
    question
WHERE
    LENGTH(content) > 10)
DELETE Questionid FROM question WHERE Questionid IN So_cau_hoi_co_nhung_content_qua_dai;

-- Câu 4:
CREATE OR REPLACE VIEW V_MaxNV AS
WITH CTE_Count_NV AS(
SELECT count(A1.DepartmentID) AS count_DEPID FROM account A1
GROUP BY A1.DepartmentID)

SELECT D.DepartmentName, count(A.DepartmentID) AS SL_NV
FROM account A
JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT max(count_DEPID) FROM CTE_Count_NV);
SELECT * FROM V_MaxNV;

-- Câu 5:
WITH CTE_Que5 AS(
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn'
)
SELECT * FROM cte_Que5;