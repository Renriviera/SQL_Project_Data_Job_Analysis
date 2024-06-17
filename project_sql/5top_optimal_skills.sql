/*
Goal: Find what are the most optimal skills for Data Analyst roles in terms of both demand and avergae salary.
-Identify the top 25 highest-paying Data Analyst skills asked for in remote data analyst listings
*/

SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS number_of_skills,
    AVG(salary_year_avg) AS avg_salary_skill
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE AND
    job_title_short = 'Data Analyst'
GROUP BY
    skills
HAVING 
    COUNT(job_postings_fact.job_id) >= 10
ORDER BY 
    avg_salary_skill DESC
LIMIT 50;

