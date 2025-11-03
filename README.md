# bank_analytics_data_project
This project focuses on analyzing and visualizing banking operations using structured SQL queries in MySQL Workbench. The database created for this project is named BANK_ANALYTICS, containing a primary table called banking_data, which stores real-world loan and transaction-related information imported from Excel. The objective is to generate key performance indicators (KPIs) that provide meaningful insights into loan performance, customer behavior, and overall financial trends.

A total of 18 KPIs were developed for the Bank Analytics module and 7 KPIs for the Debit–Credit module.

The Bank Analytics KPIs include metrics such as Total Loan Amount Funded, Total Loans, Total Collection, and Total Interest, which reflect overall lending volume, disbursement efficiency, and repayment trends. Branch-wise, state-wise, religion-wise, and product group-wise analyses were conducted to assess performance across regions, demographics, and loan categories. The Disbursement Trend query tracks yearly loan issuance growth, while Grade-Wise Loan examines borrower risk categories.

Further KPIs such as Default Loan Count, Delinquent Client Count, and Default Loan Rate provide insights into loan defaults and repayment challenges. Queries like Loan Maturity analyze loan term durations, while Unverified Loan Count identifies data integrity gaps. Each SQL query uses aggregation, grouping, and filtering functions to summarize data effectively for reporting and dashboard purposes.

The Debit–Credit Analysis part includes 7 KPIs, focusing on financial transactions. These include Total Credit Amount, Total Debit Amount, Credit-to-Debit Ratio, Net Transaction Amount, and Transactions per Month, which help monitor account inflows and outflows, customer activity levels, and branch-wise transaction volumes.

By executing these queries in MySQL, valuable insights are obtained about overall banking efficiency, risk exposure, and customer transaction behavior. This analysis supports data-driven decisions and can be used to design business dashboards for financial institutions, improving performance tracking and transparency.
