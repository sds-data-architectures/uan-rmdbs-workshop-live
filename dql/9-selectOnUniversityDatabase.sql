SET search_path = courses;

SELECT * FROM  advisor;
SELECT * FROM instructor;


SELECT name FROM instructor WHERE dept_name = 'Comp. Sci.' and salary > 70000;
SELECT * FROM instructor, department WHERE instructor.dept_name = department.dept_name;

SELECT instructor_id, count(section_id) as Number_of_setions
FROM instructor NATURAL LEFT OUTER JOIN teaches
group by instructor_id;
