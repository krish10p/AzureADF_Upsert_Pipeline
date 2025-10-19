# AzureADF_Upsert_Pipeline

•	Pulled order data from a JSON file hosted on GitHub (Data is fetched from an API). The data represents customer orders and keeps growing over time as new orders are added.

•	Build a pipeline in Azure Data Factory (ADF) that fetches this JSON data and first loads it into a temporary table called temp_orders in Azure SQL Database.

•	This temp table is just a staging area. It holds the raw data before processing.

•	Use a stored procedure in SQL to compare the new data in temp_orders with the existing data in the main orders table. The stored procedure performs an upsert (insert + update): it adds new records that aren’t in Orders yet and updates existing ones if they have changed. Don’t reload everything - only the changes.

•	The JSON file path (GitHub raw URL) is used as the source dataset in ADF’s Copy Data activity, and the destination is the Azure SQL Database. 

•	The pipeline runs automatically or on schedule to keep the orders table always up to date with the latest API data.

•	Source = static JSON file (like https://raw.githubusercontent.com/.../orders.json)
•	ADF will just read that file - it only changes when you update and push new data to GitHub. Not for live or growing data.

•	Source = dynamic API (like https://api.company.com/orders)
•	ADF calls that API every time the pipeline runs.
•	If the API keeps adding new orders, ADF will always get the latest data automatically. Useful for  production or continuous data pipelines.
