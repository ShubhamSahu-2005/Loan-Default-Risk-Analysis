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