# Loan Default Risk Analysis
### Horizon Financial Group | 2024–2025

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![Excel](https://img.shields.io/badge/Excel-Cleaning-green?logo=microsoftexcel)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## Business Problem

Horizon Financial Group has issued over 600 personal loans across 
2024–2025. The company's default rate has risen to **24.3%** — more 
than double the internal target of 12%. The VP of Risk requested a 
full data analysis to identify the root causes and recommend specific 
changes to the underwriting process.

> *"Which borrowers are defaulting, why are they defaulting, 
> and what thresholds should we set to fix it?"*

---

## Project Structure
loan-default-analysis/

├── data/

│  ├── borrower_profiles.csv          ← raw borrower data

│   ├── loan_applications.csv          ← raw loan data

│   ├── borrower_profiles_clean.csv    ← cleaned borrower data

│   ├── loan_applications_clean.csv    ← cleaned loan data

│   └── merged_loan_data.csv           ← final merged dataset

├── notebooks/

│   ├── data_cleaning.ipynb            ← data validation + cleaning

│   └── eda_analysis.ipynb             ← EDA + all 5 charts

├── sql/

│   └── analysis.sql                   ← 6 sections of SQL analysis

├── reports/

│   ├── loan_default_analysis.pbix     ← Power BI source file

│   ├── dashboard_export.pdf           ← Power BI PDF export

│   ├── risk_memo.md                   ← Executive summary for VP of Risk

│   └── charts/                        ← All Python chart exports

│       ├── chart1_credit_score_default.png

│       ├── chart2_dti_analysis.png

│       ├── chart3_loan_purpose.png

│       ├── chart4_employment.png

│       └── chart5_correlation_heatmap.png

└── README.md
---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python (pandas, matplotlib, seaborn) | Data cleaning, EDA, visualization |
| MySQL | Structured analysis, advanced queries |
| Power BI | Interactive 3-page business dashboard |
| Excel | Data exploration |
| GitHub | Version control + project documentation |

---

## Dataset

- **Source:** Analyst Builder — Loan Default Risk Analysis Project
- **Size:** 601 loans, 500 unique borrowers
- **Period:** January 2024 — June 2025
- **Files:** `borrower_profiles.csv` + `loan_applications.csv`
- **Key columns:** credit_score, dti_ratio, loan_purpose, 
  employment_status, years_employed, defaulted, days_delinquent

---

## Key Findings

### 1. Overall Default Rate: 24.3% vs 12% Target

The portfolio is defaulting at more than double the target rate
across all loan purposes, employment types, and education levels —
indicating a systemic underwriting problem.

### 2. Credit Score is the Strongest Controllable Risk Factor

| Credit Score | Default Rate |
|---|---|
| 520–599 | 49.14% 🔴 |
| 600–649 | 29.03% 🔴 |
| 650–699 | 28.00% 🔴 |
| 700–749 | 16.28% 🟠 |
| 750+ | 11.69% ✅ |

Only the 750+ bracket meets the 12% target. Borrowers below 
650 default at nearly 2x the company average.

### 3. DTI Has a Clear Threshold at 35%

| DTI Range | Default Rate |
|---|---|
| Below 20% | 16.67% 🟠 |
| 20–35% | 10.53% ✅ |
| 35–50% | 20.67% 🟠 |
| Above 50% | 34.27% 🔴 |

The 20–35% DTI range is the only bracket meeting the 12% target.
Defaults nearly double once DTI crosses 35%.

### 4. No Loan Purpose Meets the 12% Target

Wedding loans carry the highest default rate (32.14%) while 
Medical Expenses is the safest (20.59%) — but every single 
category exceeds the 12% target. This is a systemic issue, 
not a purpose-specific one.

### 5. Days Delinquent is the #1 Default Predictor (r = 0.88)

Near-perfect correlation between early payment delays and 
eventual default. An early intervention system triggered at 
15+ days delinquent could prevent a significant share of defaults.

### 6. Home Ownership is a Strong Secondary Signal

| Ownership | Default Rate |
|---|---|
| Rent | ~35% 🔴 |
| Mortgage | ~19% 🟠 |
| Own | ~14% 🟠 |

Renters default at 2.5x the rate of homeowners.

---

## Recommendations

| # | Recommendation | Expected Impact |
|---|---|---|
| 1 | Set minimum credit score at **700** | Eliminates highest-risk buckets |
| 2 | Cap DTI at **35%** for auto-approval | Keeps defaults near 10.53% |
| 3 | Build early delinquency alert at **15 days** | Prevents defaults before they occur |

---

## Power BI Dashboard

3-page interactive dashboard covering:
- **Page 1 — Executive Overview:** KPI cards, monthly trend, 
  repayment breakdown, default rate by state
- **Page 2 — Risk Breakdown:** Credit score, DTI, loan purpose, 
  employment analysis + cross matrix
- **Page 3 — Borrower Profile:** Education, home ownership, 
  experience, risk segmentation scatter plot

📄 See `reports/dashboard_export.pdf` for full dashboard preview

---

## SQL Analysis Highlights

6 sections covering all 4 business questions plus advanced queries:

```sql
-- Rolling 3-month default rate trend (window function)
SELECT
    DATE_FORMAT(application_date, '%Y-%m') AS month,
    ROUND(AVG(SUM(defaulted) * 100.0 / COUNT(*))
          OVER (ORDER BY DATE_FORMAT(application_date, '%Y-%m')
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2)
    AS rolling_3m_avg
FROM loan_applications
GROUP BY month;
```

Full query file: `sql/analysis.sql`

---

## How to Run

**Python Notebooks:**
```bash
git clone https://github.com/ShubhamSahu-2005/loan-default-analysis
cd loan-default-analysis
pip install pandas matplotlib seaborn jupyter
jupyter notebook
```

**MySQL:**
```bash
# Import clean CSVs using MySQL Workbench Table Import Wizard
# Run sql/analysis.sql in MySQL Workbench
```

**Power BI:**
```bash
# Open reports/loan_default_analysis.pbix in Power BI Desktop

OR

 # Open reports/dashboard_export.pdf for preview
```
---

## Project Outcome

This analysis identified three actionable underwriting thresholds 
that — if implemented — would bring Horizon Financial Group's 
default rate from 24.3% significantly closer to the 12% target 
by filtering out the highest-risk borrower profiles before 
loan approval.

---

*Analyst: Shubham Sahu | June 2026*  
*Dataset: Analyst Builder — Loan Default Risk Analysis*
