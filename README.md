# Global_Startup_Industry_Analysis
This project analyzes 5,000 startups across 10 countries to understand how different industries compare in terms of funding, revenue, valuation, workforce, customers, funding stages and startup outcomes.

The analysis was structured across Excel, MySQL, and Power BI. Excel was used for data quality checks and descriptive exploration while MySQL was used to answer deeper business questions through aggregation, ratios and ranking. Power BI was then used to bring the most relevant findings together into an interactive dashboard.

## Dataset

The dataset contains 5,000 startups across 10 countries and 12 key features:

Startup Name

Founded Year

Country

Industry

Funding Stage

Total Funding ($M)

Number of Employees

Annual Revenue ($M)

Valuation ($B)

Acquired

IPO

Customer Base (Millions)

## Tools Used
Excel - Data quality checks, exploration, PivotTables, PivotCharts and slicers

MySQL - Business-question-driven analysis, aggregations and rankings

Power BI - Interactive dashboard and visual analysis

### 1. Excel Analysis

I started by checking the dataset's quality before carrying out the analysis. This included checking for duplicate records, missing/null values, data types and general consistency of the dataset.

After the initial data checks, I used PivotTables and PivotCharts to explore the dataset from an industry perspective. The purpose of this stage was mainly descriptive: to understand the distribution of startups and how industries differ across key business measures.

The Excel analysis is shown in the dashboard below.

<img width="929" height="290" alt="Startup Analysis Excel Dashboard Image" src="https://github.com/user-attachments/assets/f7b7875d-37c9-4a8e-9a8a-dda75f1e3524" />

Key Excel Findings are; 

Tech has the largest number of startups in the dataset. Logistics has the highest average funding, indicating that the typical Logistics startup receives more funding than startups in other industries. FoodTech has the highest average annual revenue. AI has the highest average number of employees, indicating larger average workforce size. Energy has the highest average valuation. Gaming has the highest average customer base.

These results showed why looking at only one metric can give an incomplete picture. The industry leading in startup count was not necessarily the industry leading in funding, revenue, valuation, employees or customers.

### 2. MySQL Analysis

After the descriptive analysis in Excel, I moved to MySQL to investigate more specific business questions that required deeper aggregation, ratios and ranking.

The SQL analysis focused on:

Industry Financial Performance. Funding Efficiency including Revenue per $1M funding, Valuation per $1M funding, Customers per $1M funding. These measures were used to move beyond simply asking which industries receive the most funding and instead examine how efficiently industries translate funding into revenue, valuation and customer reach.

I then examined funding-stage concentration by industry to understand which industries are more concentrated in earlier versus later stages of development.

Then, I ranked countries within industries using Number of startups, Total funding, Total valuation
This made it possible to distinguish between startup presence, investment dominance, and valuation dominance. A country can have a large number of startups in an industry without necessarily leading that industry in funding or valuation.

Finally, I calculated, Acquisition and IPO rate by industry. This provided an outcome-oriented view of the industries and helped identify differences in exit activity.

### 3. Power BI Dashboard

The final Power BI dashboard brings together the most relevant findings from the analysis into a single interactive view.

The dashboard includes:

<img width="591" height="331" alt="Startup Analysis PowerBi Dashboard Image" src="https://github.com/user-attachments/assets/35f21368-9950-4f39-ad46-7148d8b7e36c" />

