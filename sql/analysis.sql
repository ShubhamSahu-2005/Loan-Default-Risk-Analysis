CREATE DATABASE IF NOT EXISTS loan_risk;
USE loan_risk;


SELECT COUNT(*) FROM borrower_profiles;
SELECT COUNT(*) FROM loan_applications;

-- SECTION 1: Overall Default Rate
SELECT COUNT(*) as total_loans,
SUM(defaulted) as total_defaulted,
ROUND(SUM(defaulted)*100/COUNT(*),2) as default_pct,
12.00 as internal_target,
ROUND(SUM(defaulted)*100/COUNT(*)-12,2)as gap_above_target
FROM loan_applications;

-- SECTION 2: Default Rate by Credit Score Bucket
SELECT
    CASE
        WHEN b.credit_score BETWEEN 520 AND 599 THEN '520-599'
        WHEN b.credit_score BETWEEN 600 AND 649 THEN '600-649'
        WHEN b.credit_score BETWEEN 650 AND 699 THEN '650-699'
        WHEN b.credit_score BETWEEN 700 AND 749 THEN '700-749'
        WHEN b.credit_score >= 750             THEN '750+'
    END                                                         AS credit_score_bucket,
    COUNT(*)                                                    AS total_loans,
    SUM(l.defaulted)                                           AS total_defaults,
    ROUND(SUM(l.defaulted) * 100.0 / COUNT(*), 2)            AS default_rate_pct,
    ROUND(AVG(b.credit_score), 0)                             AS avg_credit_score,
    ROUND(AVG(l.loan_amount), 2)                              AS avg_loan_amount
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id = b.borrower_id
GROUP BY credit_score_bucket
ORDER BY default_rate_pct DESC;

-- SECTION 3: DTI Ratio vs Default Rate
SELECT
    CASE
        WHEN l.dti_ratio < 20              THEN 'Below 20%'
        WHEN l.dti_ratio BETWEEN 20 AND 35 THEN '20-35%'
        WHEN l.dti_ratio BETWEEN 35 AND 50 THEN '35-50%'
        WHEN l.dti_ratio > 50              THEN 'Above 50%'
    END                                                         AS dti_bucket,
    COUNT(*)                                                    AS total_loans,
    SUM(l.defaulted)                                           AS total_defaults,
    ROUND(SUM(l.defaulted) * 100.0 / COUNT(*), 2)            AS default_rate_pct,
    ROUND(AVG(l.dti_ratio), 2)                                AS avg_dti,
    ROUND(AVG(b.credit_score), 0)                             AS avg_credit_score
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id = b.borrower_id
GROUP BY dti_bucket
ORDER BY default_rate_pct DESC;


-- Section 4- Loan Purpose Vs Default Rate

select loan_purpose,COUNT(*) As total_loans,
SUM(defaulted) as Total_defaults,
ROUND(SUM(defaulted)*100.0/COUNT(*),2) as default_pct,
Round(AVG(CASE WHEN defaulted=1 THEN loan_amount END),2) as avg_defaulted_loan_amount,
ROUND(AVG(CASE WHEN defaulted=0 THEN loan_amount END),2) as avg_undefaulted_laon_amount
FROM loan_applications 
GROUP BY loan_purpose
ORDER BY default_pct DESC;

-- SECTION 5- Employment Status Vs Default rate

SELECT b.employment_status as Borrower_employment_status,
COUNT(*) as total_loans,
SUM(l.defaulted) as total_defaulted,
ROUND(SUM(l.defaulted)*100.0/COUNT(*),2) as default_rate_pct,
ROUND(avg(b.annual_income),2) as avg_income,
ROUND(avg(b.credit_score),0) as avg_credit_score
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id=b.borrower_id
GROUP BY b.employment_status
ORDER BY default_rate_pct desc;

-- Years Employment Buckets

SELECT 
CASE
WHEN b.years_employed < 2 THEN 'Under 2 Years'
WHEn b.years_employed BETWEEN 2 and 5 THEN '2-5 Years'
WHEN b.years_employed >5 THEN 'Above 5 Years'
END as 'experience_buckets',
COUNT(*) as total_loans,
SUM(l.defaulted) as total_defaults,
ROUND(SUM(l.defaulted)*100.0/COUNT(*),2) as default_pct,
ROUND(AVG(b.annual_income)) as avg_annual_income,
ROUND(AVG(b.credit_score)) as avg_credit_score
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id=b.borrower_id
group by experience_buckets
ORDER BY default_pct DESC;

-- SECTION : Borrowers with Multiple Loans
SELECT
    b.borrower_id,
    b.credit_score,
    b.employment_status,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.defaulted)  AS total_defaults,
    ROUND(AVG(l.dti_ratio), 2) AS avg_dti,
    ROUND(SUM(l.loan_amount), 2)AS total_borrowed
FROM borrower_profiles b
JOIN loan_applications l ON b.borrower_id = l.borrower_id
GROUP BY b.borrower_id, b.credit_score, b.employment_status
HAVING COUNT(l.loan_id) > 1
ORDER BY total_defaults DESC, total_borrowed DESC
LIMIT 20;


-- Safe Borrower Profile

SELECT
    CASE
        WHEN b.credit_score >= 750             THEN '750+'
        WHEN b.credit_score BETWEEN 700 AND 749 THEN '700-749'
        ELSE 'Below 700'
    END                                                         AS score_bucket,
    CASE
        WHEN l.dti_ratio BETWEEN 20 AND 35     THEN '20-35% (Sweet Spot)'
        ELSE 'Outside Sweet Spot'
    END                                                         AS dti_category,
    COUNT(*)                                                    AS total_loans,
    SUM(l.defaulted)                                           AS defaults,
    ROUND(SUM(l.defaulted) * 100.0 / COUNT(*), 2)            AS default_rate_pct
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id = b.borrower_id
GROUP BY score_bucket, dti_category
ORDER BY default_rate_pct ASC;
