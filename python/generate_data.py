import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import os

np.random.seed(42)
random.seed(42)

# ─────────────────────────────────────────
# CONFIG
# ─────────────────────────────────────────
STATES = ["Ohio", "Kentucky", "West Virginia"]
PROGRAMS = ["Foster Care", "Family Preservation", "Residential", "Therapeutic Foster Care"]
OUTCOMES = ["Reunification", "Adoption", "Guardianship", "Aging Out", "Ongoing"]
CASE_STATUSES = ["Open", "Closed", "Under Review"]
INCIDENT_TYPES = ["Missed Visit", "Safety Concern", "Documentation Gap", "Policy Violation", "Near Miss"]
SEVERITIES = ["Low", "Medium", "High", "Critical"]

START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2023, 12, 31)

def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

def date_str(d):
    return d.strftime("%Y-%m-%d")

# ─────────────────────────────────────────
# WORKERS TABLE (50 workers)
# ─────────────────────────────────────────
worker_ids = [f"W{str(i).zfill(3)}" for i in range(1, 51)]
worker_data = []

state_worker_map = {}
for i, wid in enumerate(worker_ids):
    state = STATES[i % 3]
    program = PROGRAMS[i % 4]
    hire_date = random_date(datetime(2018, 1, 1), datetime(2023, 6, 1))

    # West Virginia workers are newer and have higher caseloads (to simulate the problem)
    if state == "West Virginia":
        caseload = random.randint(18, 28)
        hire_date = random_date(datetime(2021, 1, 1), datetime(2023, 6, 1))
    elif state == "Kentucky":
        caseload = random.randint(12, 20)
    else:
        caseload = random.randint(10, 16)

    worker_data.append({
        "worker_id": wid,
        "worker_name": f"Worker_{wid}",
        "state": state,
        "region": f"{state} Region {(i % 3) + 1}",
        "program_type": program,
        "caseload_count": caseload,
        "hire_date": date_str(hire_date),
        "years_experience": round((datetime(2023, 12, 31) - hire_date).days / 365, 1)
    })
    state_worker_map.setdefault(state, []).append(wid)

workers_df = pd.DataFrame(worker_data)

# ─────────────────────────────────────────
# CASES TABLE (500 rows)
# ─────────────────────────────────────────
cases = []
for i in range(1, 501):
    state = random.choices(STATES, weights=[0.45, 0.35, 0.20])[0]
    program = random.choice(PROGRAMS)
    worker_id = random.choice(state_worker_map[state])
    open_date = random_date(START_DATE, datetime(2023, 10, 1))
    required_visit = open_date + timedelta(days=random.choice([7, 14, 30]))

    # Compliance logic: WV Family Preservation has worst compliance (~61%)
    if state == "West Virginia" and program == "Family Preservation":
        compliant = random.random() < 0.61
    elif state == "West Virginia":
        compliant = random.random() < 0.72
    elif state == "Kentucky":
        compliant = random.random() < 0.80
    else:
        compliant = random.random() < 0.88

    if compliant:
        delay = random.randint(-3, 2)  # on time or early
    else:
        delay = random.randint(3, 21)  # late

    actual_visit = required_visit + timedelta(days=delay)
    if actual_visit > END_DATE:
        actual_visit = END_DATE

    compliance_flag = "Compliant" if actual_visit <= required_visit else "Non-Compliant"
    status = random.choices(CASE_STATUSES, weights=[0.55, 0.35, 0.10])[0]
    outcome = random.choice(OUTCOMES) if status == "Closed" else "N/A"

    cases.append({
        "case_id": f"C{str(i).zfill(4)}",
        "worker_id": worker_id,
        "program_type": program,
        "state": state,
        "open_date": date_str(open_date),
        "required_visit_date": date_str(required_visit),
        "actual_visit_date": date_str(actual_visit),
        "days_variance": delay,
        "compliance_flag": compliance_flag,
        "case_status": status,
        "outcome": outcome,
        "month": open_date.strftime("%Y-%m")
    })

cases_df = pd.DataFrame(cases)

# ─────────────────────────────────────────
# INCIDENTS TABLE (150 rows)
# ─────────────────────────────────────────
incidents = []
case_ids = cases_df["case_id"].tolist()

for i in range(1, 151):
    case_id = random.choice(case_ids)
    case_row = cases_df[cases_df["case_id"] == case_id].iloc[0]
    state = case_row["state"]

    incident_type = random.choices(
        INCIDENT_TYPES,
        weights=[0.30, 0.25, 0.20, 0.15, 0.10]
    )[0]

    severity = random.choices(
        SEVERITIES,
        weights=[0.40, 0.30, 0.20, 0.10]
    )[0]

    reported = random_date(START_DATE, datetime(2023, 11, 30))

    # WV takes longer to resolve
    if state == "West Virginia":
        resolution_days = random.randint(5, 30)
    else:
        resolution_days = random.randint(1, 14)

    resolved = reported + timedelta(days=resolution_days)
    near_miss = "Yes" if incident_type == "Near Miss" or (severity == "Critical" and random.random() < 0.4) else "No"

    incidents.append({
        "incident_id": f"I{str(i).zfill(3)}",
        "case_id": case_id,
        "state": state,
        "incident_type": incident_type,
        "severity": severity,
        "reported_date": date_str(reported),
        "resolved_date": date_str(resolved),
        "days_to_resolve": resolution_days,
        "near_miss_flag": near_miss,
        "month": reported.strftime("%Y-%m")
    })

incidents_df = pd.DataFrame(incidents)

# ─────────────────────────────────────────
# SAVE TO CSV
# ─────────────────────────────────────────
out_dir = os.path.join(os.path.dirname(__file__), "../data")
os.makedirs(out_dir, exist_ok=True)

cases_df.to_csv(f"{out_dir}/cases.csv", index=False)
workers_df.to_csv(f"{out_dir}/workers.csv", index=False)
incidents_df.to_csv(f"{out_dir}/incidents.csv", index=False)

print("✅ Data generated successfully!")
print(f"   cases.csv      → {len(cases_df)} rows")
print(f"   workers.csv    → {len(workers_df)} rows")
print(f"   incidents.csv  → {len(incidents_df)} rows")

# ─────────────────────────────────────────
# QUICK SUMMARY STATS
# ─────────────────────────────────────────
print("\n📊 Compliance Rate by State:")
print(cases_df.groupby("state")["compliance_flag"].apply(lambda x: (x == "Compliant").mean()).round(2))

print("\n📊 Compliance Rate by State + Program (WV Family Preservation):")
pivot = cases_df.groupby(["state","program_type"])["compliance_flag"].apply(
    lambda x: round((x=="Compliant").mean()*100,1)
).reset_index()
pivot.columns = ["state","program_type","compliance_rate_%"]
print(pivot[pivot["state"]=="West Virginia"])
