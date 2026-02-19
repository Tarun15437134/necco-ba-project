-- ============================================================
-- FILE: caseload_analysis.sql
-- PURPOSE: Analyze worker caseload distribution and its
--          correlation with compliance performance
-- ============================================================

-- 1. AVERAGE CASELOAD BY STATE
SELECT
    state,
    ROUND(AVG(caseload_count), 1) AS avg_caseload,
    MIN(caseload_count) AS min_caseload,
    MAX(caseload_count) AS max_caseload
FROM workers
GROUP BY state
ORDER BY avg_caseload DESC;


-- 2. AVERAGE CASELOAD BY STATE + PROGRAM
SELECT
    state,
    program_type,
    COUNT(*) AS worker_count,
    ROUND(AVG(caseload_count), 1) AS avg_caseload
FROM workers
GROUP BY state, program_type
ORDER BY avg_caseload DESC;


-- 3. CASELOAD vs COMPLIANCE CORRELATION
-- High caseload workers (>18) vs low caseload workers (<12)
SELECT
    CASE
        WHEN w.caseload_count >= 18 THEN 'High (18+)'
        WHEN w.caseload_count BETWEEN 12 AND 17 THEN 'Medium (12-17)'
        ELSE 'Low (<12)'
    END AS caseload_band,
    COUNT(c.case_id) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN c.compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases c
JOIN workers w ON c.worker_id = w.worker_id
GROUP BY caseload_band
ORDER BY compliance_rate_pct ASC;


-- 4. WORKER EXPERIENCE vs COMPLIANCE
SELECT
    CASE
        WHEN w.years_experience < 1 THEN 'New (<1 yr)'
        WHEN w.years_experience BETWEEN 1 AND 3 THEN 'Junior (1-3 yrs)'
        WHEN w.years_experience BETWEEN 3 AND 5 THEN 'Mid (3-5 yrs)'
        ELSE 'Senior (5+ yrs)'
    END AS experience_band,
    COUNT(c.case_id) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN c.compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases c
JOIN workers w ON c.worker_id = w.worker_id
GROUP BY experience_band
ORDER BY compliance_rate_pct ASC;
