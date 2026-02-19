-- ============================================================
-- FILE: incident_trends.sql
-- PURPOSE: Track incident patterns, near misses, and
--          resolution efficiency across programs and states
-- ============================================================

-- 1. TOTAL INCIDENTS BY STATE
SELECT
    state,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN near_miss_flag = 'Yes' THEN 1 ELSE 0 END) AS near_misses
FROM incidents
GROUP BY state
ORDER BY total_incidents DESC;


-- 2. INCIDENT TYPE BREAKDOWN
SELECT
    incident_type,
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct_of_total
FROM incidents
GROUP BY incident_type
ORDER BY count DESC;


-- 3. SEVERITY DISTRIBUTION BY STATE
SELECT
    state,
    severity,
    COUNT(*) AS incident_count
FROM incidents
GROUP BY state, severity
ORDER BY state, incident_count DESC;


-- 4. MONTH-OVER-MONTH NEAR MISS TREND
SELECT
    month,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN near_miss_flag = 'Yes' THEN 1 ELSE 0 END) AS near_misses,
    ROUND(
        100.0 * SUM(CASE WHEN near_miss_flag = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS near_miss_rate_pct
FROM incidents
GROUP BY month
ORDER BY month;


-- 5. AVERAGE DAYS TO RESOLVE BY SEVERITY AND STATE
SELECT
    state,
    severity,
    COUNT(*) AS incident_count,
    ROUND(AVG(days_to_resolve), 1) AS avg_days_to_resolve,
    MAX(days_to_resolve) AS max_days_to_resolve
FROM incidents
GROUP BY state, severity
ORDER BY avg_days_to_resolve DESC;


-- 6. UNRESOLVED OR SLOW CRITICAL INCIDENTS (>7 days)
SELECT
    incident_id,
    case_id,
    state,
    incident_type,
    severity,
    reported_date,
    days_to_resolve
FROM incidents
WHERE severity IN ('Critical', 'High')
    AND days_to_resolve > 7
ORDER BY days_to_resolve DESC;
