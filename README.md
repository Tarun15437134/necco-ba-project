# 📊 Child Welfare Program Performance Tracker
### A Business Analyst Case Study — Compliance, Incidents & Operational Improvement

---

## 🧩 The Problem

A multi-state child welfare organization operating across **Ohio, Kentucky, and West Virginia** had no centralized way to monitor case manager compliance, track incident patterns, or identify which programs were falling behind — until a state audit flagged growing non-compliance rates.

Leadership needed answers to three questions:
- **Which states and programs are underperforming, and why?**
- **Is this a caseload problem, an experience problem, or a process problem?**
- **What specific actions will move the needle the fastest?**

---

## 🎯 My Role (BA Approach)

I approached this as a full-cycle Business Analyst engagement:

1. Defined the problem and identified stakeholders
2. Designed the data model (cases, workers, incidents)
3. Conducted SQL-based analysis to surface trends and root causes
4. Built an executive dashboard in Power BI for leadership visibility
5. Delivered actionable recommendations in a structured memo
6. Created a Standard Operating Procedure (SOP) to prevent future data quality issues

---

## 📁 Project Structure

```
necco-ba-project/
│
├── problem_statement.md        ← Business problem, stakeholders, scope
├── root_cause_analysis.md      ← 4 key findings with evidence & recommendations
│
├── data/
│   ├── cases.csv               ← 500 cases across 3 states, 4 programs
│   ├── workers.csv             ← 50 workers with caseload and experience data
│   └── incidents.csv           ← 150 incidents with severity and resolution time
│
├── sql/
│   ├── compliance_rate.sql     ← Compliance by state, program, worker, month
│   ├── caseload_analysis.sql   ← Caseload vs. compliance correlation
│   └── incident_trends.sql     ← Near-miss trends, resolution time, severity
│
├── python/
│   └── generate_data.py        ← Reproducible dataset generation script
│
├── dashboard/
│   └── dashboard_screenshot.png ← Power BI dashboard preview
│
└── docs/
    ├── executive_memo.md       ← 1-page recommendation memo to VP of Programs
    └── SOP_data_entry_compliance.md ← Standard operating procedure for data entry
```

---

## 🔍 Key Findings

### 1. West Virginia Compliance Rate = 40% (vs. 51% company average)
All four program types in WV fall below 42% compliance. Root cause: caseloads averaging **18–28 cases** per worker (vs. 10–16 in Ohio) combined with a predominantly junior workforce.

### 2. Family Preservation is the Highest-Risk Program
With mandatory visits every 7–14 days and no adjusted caseload formula, Family Preservation workers are structurally set up to miss deadlines. **Missed visits = 30% of all incidents.**

### 3. WV Incident Resolution Time = 22+ Days for Critical Cases
Ohio resolves critical incidents in an average of 7 days. West Virginia takes **3x longer**, creating serious legal and safety exposure.

### 4. Near-Miss Incidents Peak Every Q3 (July–September)
A consistent seasonal pattern across all states, driven by summer workload surges and new hire transitions.

---

## 💡 Top Recommendations

| Action | Expected Impact | Timeline |
|---|---|---|
| Cap WV caseloads at 15; hire 3–4 new workers | +12–18 pt compliance improvement | 6 months |
| Weight Family Preservation cases at 1.5x in caseload formula | +8–10 pt improvement | 45 days |
| Implement Incident Response SOP with mandatory timelines | Reduce WV resolution time to <7 days | 30 days |
| Deploy leadership dashboard for monthly monitoring | Real-time visibility, proactive decision-making | 60 days |

---

## 🛠️ Tools Used

- **Python (pandas, numpy)** — Data generation and preprocessing
- **SQL (SQLite)** — Analysis and KPI calculation
- **Power BI** — Executive dashboard and data visualization
- **Markdown** — Documentation, SOP, and memo writing

---

## 📄 Key Deliverables

- [Problem Statement](./problem_statement.md)
- [Root Cause Analysis](./root_cause_analysis.md)
- [Executive Recommendation Memo](./docs/executive_memo.md)
- [Data Entry SOP](./docs/SOP_data_entry_compliance.md)
- [Compliance Rate SQL](./sql/compliance_rate.sql)
- [Caseload Analysis SQL](./sql/caseload_analysis.sql)
- [Incident Trends SQL](./sql/incident_trends.sql)

---

## 🚀 How to Run the Data

```bash
# Clone the repo
git clone https://github.com/yourusername/necco-ba-project.git
cd necco-ba-project

# Install dependencies
pip install pandas numpy

# Generate the datasets
python python/generate_data.py

# Datasets will appear in /data folder, ready for SQL or Power BI import
```

---

*This is a simulated case study built to demonstrate end-to-end Business Analyst skills including data analysis, root cause identification, stakeholder communication, SOP development, and dashboard reporting. All data is fictional.*
