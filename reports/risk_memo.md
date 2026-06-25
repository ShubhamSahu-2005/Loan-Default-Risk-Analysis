# Loan Default Risk Analysis — Executive Memo
**Prepared by:** Shubham Sahu
**Date:** June 2025  
**Company:** Horizon Financial Group  
**Submitted to:** VP of Risk  

---

## Executive Summary

Horizon Financial Group's personal loan portfolio is experiencing a 
default rate of **24.3%** across 601 loans issued in 2024–2025 — 
more than **double the 12% internal target**. This analysis examined 
borrower demographics, loan characteristics, and repayment outcomes 
across 10 loan purposes, 5 employment categories, and 5 credit score 
brackets to identify the root causes of this elevated default rate.

**Bottom line:** The default crisis is not caused by any single 
factor. It is driven by a combination of low credit scores, high 
DTI ratios, and early payment delinquency — three variables that 
compound each other's risk when present together.

---

## The Numbers at a Glance

| Metric | Value |
|---|---|
| Total Loans Analyzed | 601 |
| Total Defaults | ~146 |
| Current Default Rate | 24.3% |
| Company Target | 12.0% |
| Gap Above Target | +12.3 percentage points |
| Highest Risk Segment | Credit Score 520–599 (49.14%) |
| Safest Segment | Credit Score 750+ (11.69%) |
| Strongest Default Predictor | Days Delinquent (r = 0.88) |

---

## Finding 1 — Credit Score is the Most Controllable Risk Factor

**Default rate by credit score bucket:**

| Credit Score | Default Rate | vs Target |
|---|---|---|
| 520–599 | 49.14% | +37.14 pts 🔴 |
| 600–649 | 29.03% | +17.03 pts 🔴 |
| 650–699 | 28.00% | +16.00 pts 🟠 |
| 700–749 | 16.28% | +4.28 pts 🟠 |
| 750+    | 11.69% | -0.31 pts ✅ |

There is a clear, consistent inverse relationship between credit 
score and default rate — no exceptions across any bucket. Borrowers 
below 650 default at nearly **2x the company average**. The 520–599 
bucket alone defaults at 49.14%, meaning **1 in 2 borrowers in this 
range fail to repay.**

Only the 750+ bracket meets the 12% target.

**Implication:** Credit score is the single most actionable 
underwriting lever available. Raising the minimum approval threshold 
directly eliminates the highest-risk segments.

---

## Finding 2 — DTI Ratio Has a Clear Risk Threshold at 35%

**Default rate by DTI range:**

| DTI Range | Default Rate | vs Target |
|---|---|---|
| Below 20% | 16.67% | +4.67 pts 🟠 |
| 20–35%    | 10.53% | -1.47 pts ✅ |
| 35–50%    | 20.67% | +8.67 pts 🟠 |
| Above 50% | 34.27% | +22.27 pts 🔴 |

The 20–35% DTI range is the only bracket meeting the 12% target 
at 10.53%. Defaults nearly double once DTI crosses 35%, and reach 
34.27% above 50% DTI.

**Notable anomaly:** Borrowers with DTI below 20% default at 
16.67% — higher than the 20–35% group. Investigation confirmed 
these borrowers carry lower credit scores, proving that DTI and 
credit score must always be evaluated together. A low DTI does 
not compensate for a poor credit history.

**Implication:** Set 35% as the hard DTI cutoff. Borrowers in 
the 20–35% range with strong credit scores represent the 
lowest-risk approval profile.

---

## Finding 3 — No Loan Purpose Meets the 12% Target

**Default rate by loan purpose (sorted by risk):**

| Loan Purpose | Default Rate | Avg Loan Amount |
|---|---|---|
| Wedding | 32.14% 🔴 | $21,893 |
| Home Improvement | 28.57% 🔴 | $23,407 |
| Auto Loan | 27.12% 🔴 | $19,554 |
| Business Loan | 24.14% 🟠 | $21,014 |
| Education | 22.64% 🟠 | $19,847 |
| Vacation | 22.58% 🟠 | $24,477 |
| Major Purchase | 22.06% 🟠 | $23,165 |
| Debt Consolidation | 21.57% 🟠 | $22,757 |
| Moving | 21.43% 🟠 | $21,300 |
| Medical Expenses | 20.59% 🟠 | $23,176 |

The fact that **zero loan purposes meet the 12% target** is the 
most critical finding in this section. This is not a purpose-specific 
problem — it is a systemic underwriting problem.

**Key paradox:** Vacation loans carry the highest average loan 
amount ($24,477) but default at only 22.58%, while Auto loans 
have the lowest average amount ($19,554) but default at 27.12%. 
Loan size does not determine default risk — borrower profile does.

**Implication:** Do not use loan purpose as a primary risk filter. 
Focus underwriting tightening on credit score and DTI thresholds 
across all purposes. Flag Wedding, Home Improvement, and Auto Loan 
applications for additional scrutiny given their above-average 
default rates.

---

## Finding 4 — Employment Tenure Has a Surprising U-Shape Pattern

**Default rate by years employed:**

| Experience | Default Rate | vs Target |
|---|---|---|
| Under 2 yrs | 31.11% | +19.11 pts 🔴 |
| 2–5 yrs     | 11.58% | -0.42 pts ✅ |
| Above 5 yrs | 25.07% | +13.07 pts 🔴 |

The 2–5 year employment group is the safest at 11.58% — meeting 
the 12% target. However, borrowers with above 5 years of employment 
default at 25.07%, which is worse than expected and higher than 
mid-tenure borrowers.

**Root cause identified:** The Above 5 yrs group carries:
- Average credit score of **700** vs **721** in the 2–5 yr group
- Average DTI of **48.82%** vs **46.03%** in the 2–5 yr group

These compounding risk factors override the stability signal 
of longer employment. Years employed is not a reliable standalone 
safety indicator.

**Implication:** Do not use long employment tenure as a compensating 
factor for weak credit scores or high DTI. Always cross-evaluate 
all three variables together.

---

## Finding 5 — Days Delinquent is the Strongest Default Predictor

**Correlation with default (from correlation matrix):**

| Variable | Correlation with Default |
|---|---|
| days_delinquent | **+0.88** 🔴 |
| interest_rate | +0.20 |
| dti_ratio | +0.19 |
| credit_score | -0.29 |
| loan_amount | +0.02 ⚪ |
| annual_income | -0.08 ⚪ |

Days delinquent has a near-perfect 0.88 correlation with default — 
by far the strongest signal in the dataset. Borrowers who miss even 
early payments are almost certain to default.

**Critical insight:** Loan amount has a 0.02 correlation with 
default — essentially zero. Income shows only -0.08. This confirms 
that how much someone earns or borrows is far less important than 
their credit behaviour and debt burden.

---

## Top 3 Recommendations

### Recommendation 1 — Raise Minimum Credit Score to 700
Immediately stop approving borrowers below 650. Set 700 as the 
minimum threshold for auto-approval. Borrowers between 650–699 
should go through manual underwriting review with additional 
income and employment verification.

**Expected impact:** Eliminates the three highest-risk credit 
buckets (520–599, 600–649, 650–699) which account for the 
majority of defaults above the 12% target.

---

### Recommendation 2 — Cap DTI at 35% for Auto-Approval
Reject all applications with DTI above 50%. Place applications 
in the 35–50% range in a manual review queue requiring additional 
documentation. Fast-track the 20–35% DTI segment with strong 
credit scores (700+) as the lowest-risk approval profile.

**Expected impact:** The 20–35% DTI + 700+ credit score 
combination represents the only borrower profile consistently 
meeting the 12% target across both dimensions.

---

### Recommendation 3 — Build an Early Delinquency Alert System
Given the 0.88 correlation between days delinquent and default, 
implement an automated flag for any borrower missing a payment 
by more than 15 days. Trigger immediate outreach — payment 
restructuring or hardship plans at this stage could prevent 
formal default.

**Expected impact:** Early intervention on delinquent accounts 
could prevent a significant share of defaults given the near-
perfect predictive relationship between early delinquency and 
eventual default.

---

## Risk Matrix Summary

| Risk Factor | Weight | Current State | Recommended Threshold |
|---|---|---|---|
| Credit Score | High | No minimum enforced | Minimum 700 |
| DTI Ratio | High | No cap enforced | Maximum 35% |
| Days Delinquent | Critical | No alert system | Flag at 15 days |
| Loan Purpose | Low | No restrictions | Flag Wedding/Auto/Home |
| Employment Tenure | Low | Used as safety signal | Do not use in isolation |
| Loan Amount | None | Used in decisions | Remove from model |
| Annual Income | Low | Used in decisions | Use only alongside DTI |

---

## Conclusion

The 24.3% default rate at Horizon Financial Group is not 
an anomaly — it is the predictable outcome of approving 
borrowers without enforcing minimum credit score and DTI 
thresholds. The data is clear: **borrowers with credit 
scores above 700 and DTI between 20–35% default at rates 
near or below the 12% target.**

Implementing the three recommendations above — minimum 
credit score of 700, DTI cap at 35%, and an early 
delinquency alert system — would directly address the 
root causes identified in this analysis and bring the 
default rate substantially closer to the 12% target.

---
*Analysis conducted using Python (pandas, matplotlib, seaborn), 
MySQL, and Power BI. Dataset: 601 loans, Horizon Financial Group, 
2024–2025.*