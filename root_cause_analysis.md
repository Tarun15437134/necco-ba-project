# Root Cause Analysis

**Project:** Child Welfare Program Performance — 2023 Analysis
**Prepared by:** [Your Name]
**Date:** February 2024

---

## Finding 1: West Virginia Has the Lowest Compliance Rate in the Organization

**Metric:** West Virginia overall compliance rate = **40%** vs. company average of **51%**

**Observation:**
West Virginia consistently underperforms across all four program types. The gap is not isolated to one program — it is systemic, which rules out a single program-level issue and points to state-level structural factors.

**Data Evidence:**
- WV Foster Care: 41.9% compliant
- WV Family Preservation: 35.7% compliant (lowest in organization)
- WV Residential: 42.1% compliant
- WV Therapeutic Foster Care: 40.0% compliant

**Root Causes Identified:**

1. **Caseload overload:** WV workers average 18–28 cases vs. 10–16 in Ohio. SQL analysis confirms workers with 18+ cases have compliance rates 15–20 points lower than those with under 12.
2. **Newer workforce:** WV hire dates skew 2021–2023. Workers with under 1 year of experience show the lowest compliance rates across all states.
3. **Geographic barriers:** West Virginia's rural geography increases travel time between visits, reducing daily capacity.

**Recommendation:**
- Cap WV caseloads at 15 per worker; hire 3–4 additional case managers
- Pair new WV hires with senior mentors for first 90 days
- Implement bi-weekly check-ins between regional supervisors and workers with compliance rates below 50%

---

## Finding 2: Family Preservation Has the Worst Compliance Across All States

**Metric:** Family Preservation compliance = **35.7% in WV**, lowest program type nationally

**Observation:**
Family Preservation requires more frequent in-home contact than other programs, creating higher visit volume with the same staffing levels. This program is structurally under-resourced relative to its demands.

**Data Evidence:**
- Family Preservation requires visits every 7–14 days (vs. 30 days for Residential)
- Workers managing Family Preservation cases have the highest average days-late variance
- Missed visit incidents are the #1 incident type (30% of all incidents)

**Root Causes Identified:**
1. Visit frequency requirements are not reflected in caseload caps
2. Documentation burden is high, reducing time available for actual visits
3. No automated reminders or visit-due alerts in the case management system

**Recommendation:**
- Adjust caseload formula to weight Family Preservation cases as 1.5x standard cases
- Explore automation of visit-due alerts in case management system (IT partnership required)
- Conduct a time-motion study on documentation burden to identify inefficiencies

---

## Finding 3: Incident Resolution Takes Significantly Longer in West Virginia

**Metric:** WV average days to resolve = **17.4 days** vs. 7.2 days in Ohio

**Observation:**
Not only do incidents occur more frequently in WV, they take more than twice as long to resolve. Slow resolution increases risk of escalation and re-occurrence.

**Data Evidence:**
- Critical and High severity incidents in WV average 22+ days to resolve
- 12 incidents in WV exceeded 7 days resolution time for Critical severity
- Near-miss rate peaks in Q3 (July–September) across all states

**Root Causes Identified:**
1. No clear incident response SOP with defined escalation timelines
2. Smaller WV compliance team handling higher volume
3. Communication gaps between front-line staff and compliance reviewers

**Recommendation:**
- Implement a tiered response SOP: Critical = 48-hour response, High = 5 days, Medium = 10 days
- Assign a dedicated compliance liaison to WV region
- Add incident resolution time as a KPI tracked monthly on the leadership dashboard

---

## Finding 4: Near-Miss Incidents Peak in Q3 (July–September)

**Metric:** Near-miss rate climbs 22% in Q3 compared to Q1 baseline

**Observation:**
There is a seasonal pattern in near-miss incidents that is consistent across all three states. This suggests an organizational or workload factor rather than a state-specific issue.

**Root Causes Identified:**
1. Summer months increase family instability (school transitions, financial strain, reduced community support)
2. Staff vacation coverage creates temporary caseload surges
3. New fiscal year often brings staff transitions and new hires who are not yet fully trained

**Recommendation:**
- Implement a Q3 surge staffing plan with temporary coverage protocol
- Require all new hires to complete compliance training before taking on cases independently
- Flag Q3 as high-alert in the dashboard with proactive check-in cadence

---

## Summary Table

| Finding | Compliance Impact | Priority | Owner |
|---|---|---|---|
| WV caseload overload | High | Critical | Regional Director, HR |
| Family Preservation visit frequency | High | High | Program Directors |
| WV incident resolution delays | Medium | High | Compliance Team |
| Q3 near-miss surge | Medium | Medium | All State Directors |
