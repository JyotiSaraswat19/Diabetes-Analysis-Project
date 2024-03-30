Create database diabetes;

use diabetes;

SELECT * FROM  diabetes;

-- Ques) Retrieve the Patient_id and ages of all patients.
   
SELECT 
EmployeeName,
TIMESTAMPDIFF(YEAR, STR_TO_DATE(`D.O.B`, '%m/%d/%Y'), CURDATE()) AS Age
FROM 
diabetes;
    
    
-- QUES) Select all female patients who are older than 40.

select EmployeeName ,gender, Age from 
(SELECT EmployeeName ,gender,TIMESTAMPDIFF(YEAR, STR_TO_DATE(`D.O.B`, '%m/%d/%Y'), CURDATE()) AS Age
from diabetes) A
where gender="Female" and age>40;


-- Alternate method
    

SELECT EmployeeName, Patient_id, gender, `D.O.B`
FROM  diabetes
WHERE gender = 'female' and TIMESTAMPDIFF(YEAR, STR_TO_DATE(`D.O.B`, '%m/%d/%Y'), CURDATE()) > 40;



-- Ques) Calculate the average BMI of patients.


Select round(avg(bmi) ,2) as avg_bmi
from
diabetes ;


-- Ques) List patients in descending order of blood glucose levels.

Select EmployeeName , Patient_id , gender , `D.O.B` , blood_glucose_level
from diabetes
order by blood_glucose_level desc;


-- Ques) Find patients who have hypertension and diabetes.

Select EmployeeName , Patient_id , gender , `D.O.B` , hypertension , diabetes
from diabetes 
where hypertension=1 and diabetes=1;


-- Ques) Determine the number of patients with heart disease.

Select count(*) as no_of_patients_with_heart_disease
from diabetes
where heart_disease=1;


-- Ques) Group patients by smoking history and count how many smokers and non-smokers there are.


select smoking_history ,count(*) as no_of_patients
from diabetes
group by smoking_history;



-- Ques) Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.


SELECT Patient_id, bmi
FROM diabetes
WHERE bmi > (SELECT AVG(bmi) FROM diabetes);





-- Ques) Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.



select EmployeeName , Patient_id , HbA1c_level from diabetes
where HbA1c_level = (SELECT max(HbA1c_level) FROM diabetes as high_HbA1c)
union
select EmployeeName , Patient_id , HbA1c_level from diabetes
where HbA1c_level = (SELECT min(HbA1c_level) FROM diabetes as high_HbA1c);



-- Ques) Calculate the age of patients in years (assuming the current date as of now).

select EmployeeName , Patient_id , 
(timestampdiff( Year ,str_to_date(`D.O.B` , "%m/%d/%Y" ), CURDATE())) As age
from diabetes
order by age asc;


-- Ques) Rank patients by blood glucose level within each gender group

select EmployeeName , gender ,blood_glucose_level, 
dense_rank() over (partition by gender order by blood_glucose_level) as rank_of_pateints
from diabetes;



-- Ques) Update the smoking history of patients who are older than 50 to "Ex-smoker."


alter table diabetes;

update diabetes set smoking_history= "Ex-smoker" where 
(select timestampdiff( Year ,str_to_date(`D.O.B` , "%m/%d/%Y" ), CURDATE()) >50);





-- Ques) Insert a new patient into the database with sample data.

insert into diabetes values
("Aman" , "PT150" , "Male" , "11/09/1991" , 0 , 1 , "never" , 23.45 , 4.8 , 134 , 0);


select * from diabetes 
where employeename="Aman";




-- Ques) Delete all patients with heart disease from the database.

delete 
from diabetes
where "heart_disease" = 1;


-- Ques) Find patients who have hypertension but not diabetes using the EXCEPT operator.

select * from diabetes where hypertension=1 
except
select * from diabetes where diabetes=1;



-- Ques)  Define a unique constraint on the "patient_id" column to ensure its values are unique.

ALTER TABLE diabetes
add constraint Unique_constraints
Unique (patient_id(255));



-- Ques) Create a view that displays the Patient_ids, ages, and BMI of patients

Create view patient_details_view  as 
select Patient_id , TIMESTAMPDIFF(YEAR, STR_TO_DATE(`D.O.B`, '%m/%d/%Y'), CURDATE()) AS Age , bmi
from diabetes;


select * from patient_details_view;









