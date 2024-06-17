/*
Goal: Find what skills are required for the top-paying data analyst jobs found in our query executed in 1top_paying_job_skills.sql
-Add the specific skills required for these roles
*/
WITH highest_data_analyst_jobs AS(
    SELECT
        job_posted_date,
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
highest_data_analyst_jobs.*,
skills_dim.skills
FROM highest_data_analyst_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = highest_data_analyst_jobs.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC