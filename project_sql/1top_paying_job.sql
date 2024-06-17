/*
Goal: Find what are the top-paying data analyst jobs.
-Identify the top 10 highest-paying Data Analyst roles that are available remotely
*/

SELECT
    job_posted_date,
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
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
LIMIT 10;
