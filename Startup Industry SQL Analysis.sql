-- Business Analysis--

-- Total Funding by Industry; 

SELECT industry,
    SUM(`total_funding ($M)`) AS total_funding
FROM startup_dataset
GROUP BY industry
ORDER BY total_funding DESC;

-- Total Revenue by Industry;

SELECT industry,
    SUM(`annual_revenue ($M)`) AS total_revenue
FROM startup_dataset
GROUP BY industry
ORDER BY total_revenue DESC;

-- Total valuation by Industry;

SELECT industry,
    ROUND(SUM(`valuation ($B)`), 2) AS total_valuation
FROM startup_dataset
GROUP BY industry
ORDER BY total_valuation DESC;

-- Industry Efficiency; 

-- Revenue per $1M funding;

SELECT industry,
    ROUND(SUM(`annual_revenue ($M)`) / SUM(`total_funding ($M)`), 2) AS revenue_per_1m_funding
FROM startup_dataset
GROUP BY industry
ORDER BY revenue_per_1m_funding DESC;

-- Valuation per $1M funding;

SELECT industry,
    ROUND(SUM(`valuation ($B)` * 1000 ) / SUM(`total_funding ($M)`), 2) AS valuation_per_1m_funding
FROM startup_dataset
GROUP BY industry
ORDER BY valuation_per_1m_funding DESC;

-- Customers per $1M funding;

SELECT industry, 
    ROUND(SUM(`customer_base (M)`) / SUM(`total_funding ($M)`), 2) AS customers_per_1m_funding
FROM startup_dataset
GROUP BY industry
ORDER BY customers_per_1m_funding DESC;

-- Revenue per Employee;

SELECT industry,
    ROUND(SUM(`annual_revenue ($M)`) / SUM(employees), 2) AS revenue_per_employee
FROM startup_dataset
GROUP BY industry
ORDER BY revenue_per_employee DESC;

-- Revenue per Customer;
SELECT industry,
    ROUND(SUM(`annual_revenue ($M)`) / SUM(`customer_base (M)`), 2) AS revenue_per_customer
FROM startup_dataset
GROUP BY industry
ORDER BY revenue_per_customer DESC;

-- Total Funding in Seed, Series A/B/C, IPO Funding Stages by Industry 

SELECT industry,
    SUM(CASE WHEN funding_stage = 'Seed'
        THEN `total_funding ($M)` Else 0 END) AS seed_funding,
    SUM(CASE WHEN funding_stage = 'Series A'
             THEN `total_funding ($M)` ELSE 0 END) AS series_A_funding,
    SUM(CASE WHEN funding_stage = 'Series B'
             THEN `total_funding ($M)` ELSE 0 END) AS series_B_funding,
    SUM(CASE WHEN funding_stage = 'Series C'
             THEN `total_funding ($M)` ELSE 0 END) AS series_C_funding,
	SUM(CASE WHEN funding_stage = 'IPO'
             THEN `total_funding ($M)` ELSE 0 END) AS IPO_funding       
FROM startup_dataset
GROUP BY industry
ORDER BY industry;

-- Industry/Startups concentration in Funding Stages:

-- Early stage Startups:

SELECT industry,
    COUNT(*) AS total_startups,
    SUM(CASE WHEN funding_stage IN ('Seed', 'Series A') THEN 1 ELSE 0 END) AS early_stage_startups,
    ROUND(SUM(CASE WHEN funding_stage IN ('Seed', 'Series A') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS early_stage_percentage
FROM startup_dataset
GROUP BY industry
ORDER BY early_stage_percentage DESC;

-- MidGrowth Stage Startups

SELECT industry,
    COUNT(*) AS total_startups,
    SUM(CASE WHEN funding_stage IN ('Series B') THEN 1 ELSE 0 END) AS mid_stage_startups,
    ROUND(SUM(CASE WHEN funding_stage IN ('Series B') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS mid_stage_percentage
FROM startup_dataset
GROUP BY industry
ORDER BY mid_stage_percentage DESC;

-- Late Stage Startups 
SELECT industry,
    COUNT(*) AS total_startups,
    SUM(CASE WHEN funding_stage IN ('Series C', 'IPO') THEN 1
	    ELSE 0 END) AS late_stage_startups,
    ROUND(SUM(CASE WHEN funding_stage IN ('Series C', 'IPO') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS late_stage_percentage
FROM startup_dataset
GROUP BY industry
ORDER BY late_stage_percentage DESC;

-- Acquisition rate by Industry;

SELECT industry,
    COUNT(*) AS total_startups,
    SUM(CASE WHEN acquired = 'Yes' THEN 1 ELSE 0 END) AS acquired_startups,
    ROUND(SUM(CASE WHEN acquired = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS acquisition_rate
FROM startup_dataset
GROUP BY industry
ORDER BY acquisition_rate DESC;

-- IPO rate by Industry;

SELECT industry,
    COUNT(*) AS total_startups,
    SUM(CASE WHEN IPO = 'Yes' THEN 1 ELSE 0 END) AS ipo_startups,
    ROUND(SUM(CASE WHEN IPO = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS ipo_rate
FROM startup_dataset
GROUP BY industry
ORDER BY ipo_rate DESC;

-- Countries-Industries Rank in Startup Count, Funding and Valuation;

WITH country_industry AS (
    SELECT industry, country,
        COUNT(*) AS startup_count,
        SUM(`total_funding ($M)`) AS total_funding,
        ROUND(SUM(`valuation ($B)`), 2) AS total_valuation
    FROM startup_dataset
    GROUP BY industry, country
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY industry
            ORDER BY startup_count DESC) AS startup_rank,
        RANK() OVER (
            PARTITION BY industry
            ORDER BY total_funding DESC) AS funding_rank,
        RANK() OVER (
			PARTITION BY industry
            ORDER BY total_valuation DESC) AS valuation_rank
    FROM country_industry
)
SELECT
    industry,
    country,
    startup_count,
    total_funding,
    total_valuation,
    startup_rank,
    funding_rank,
    valuation_rank
FROM ranked
ORDER BY startup_rank, funding_rank, valuation_rank;
