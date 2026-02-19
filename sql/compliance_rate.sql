-- ============================================================
-- FILE: compliance_rate.sql
-- PURPOSE: Measure on-time visit compliance across states
--          and programs to identify underperforming areas
-- ============================================================

-- 1. OVERALL COMPLIANCE RATE
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS overall_compliance_rate_pct
FROM cases;


-- 2. COMPLIANCE RATE BY STATE
SELECT
    state,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) AS compliant_cases,
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases
GROUP BY state
ORDER BY compliance_rate_pct ASC;


-- 3. COMPLIANCE RATE BY STATE + PROGRAM TYPE
SELECT
    state,
    program_type,
    COUNT(*) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases
GROUP BY state, program_type
ORDER BY compliance_rate_pct ASC;


-- 4. MONTH-OVER-MONTH COMPLIANCE TREND
SELECT
    month,
    COUNT(*) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases
GROUP BY month
ORDER BY month;


-- 5. TOP 10 WORKERS BY COMPLIANCE SCORE
SELECT
    c.worker_id,
    w.state,
    w.program_type,
    w.caseload_count,
    COUNT(*) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases c
JOIN workers w ON c.worker_id = w.worker_id
GROUP BY c.worker_id, w.state, w.program_type, w.caseload_count
HAVING COUNT(*) >= 5
ORDER BY compliance_rate_pct DESC
LIMIT 10;


-- 6. BOTTOM 10 WORKERS BY COMPLIANCE SCORE
SELECT
    c.worker_id,
    w.state,
    w.program_type,
    w.caseload_count,
    w.years_experience,
    COUNT(*) AS total_cases,
    ROUND(
        100.0 * SUM(CASE WHEN compliance_flag = 'Compliant' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS compliance_rate_pct
FROM cases c
JOIN workers w ON c.worker_id = w.worker_id
GROUP BY c.worker_id, w.state, w.program_type, w.caseload_count, w.years_experience
HAVING COUNT(*) >= 5
ORDER BY compliance_rate_pct ASC
LIMIT 10;


-- 7. AVERAGE DAYS LATE FOR NON-COMPLIANT VISITS
SELECT
    state,
    program_type,
    ROUND(AVG(days_variance), 1) AS avg_days_late
FROM cases
WHERE compliance_flag = 'Non-Compliant'
GROUP BY state, program_type
ORDER BY avg_days_late DESC;
