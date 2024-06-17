/*
Goal: Find what are the most in-demand skills for data-analyst roles.
-Look at the top 5 skills for remote data analyst positions
*/
WITH skill_count AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_amount
    FROM
        skills_job_dim
    LEFT JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
    GROUP BY 
        skill_id
    ORDER BY
        skill_amount DESC
)
SELECT
    skill_count.skill_id,
    skill_amount,
    skills_dim.skills
FROM 
    skill_count
INNER JOIN skills_dim ON skills_dim.skill_id = skill_count.skill_id
ORDER BY
    skill_amount DESC
LIMIT 5
