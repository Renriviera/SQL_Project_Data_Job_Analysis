/*
Goal: Find what are the most highest paying skills for data-analyst roles.
-Identify the top 25 highest paying skills for data analyst positions
-Remove outliers with less than 10 postings
*/
WITH highest_paying_skills AS (
    SELECT 
        skills_dim.skills AS skill_names,
        ROUND(AVG(salary_year_avg),0) AS skill_salary_avg,
        COUNT(job_postings_fact.job_id) AS skill_number
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
    GROUP BY skill_names
    ORDER BY skill_salary_avg DESC
)
SELECT *
FROM highest_paying_skills
WHERE skill_number >= 10
ORDER BY skill_salary_avg DESC
LIMIT 25;