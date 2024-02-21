## Data Cleaning in SQL Project

### Overview
This project focuses on cleaning the Nashville Housing Dataset using SQL queries. The primary objectives were to utilize Common Table Expressions (CTEs), the PARSENAME command, and CHARINDEX function to perform various data cleaning tasks. 🛠️

### Tasks Completed
1. **Adding a New Column (`SaleDateConverted`)**: A new column was created to convert the `SaleDate` column into a date format for better readability and analysis. 📅

2. **Populating Property Address Data**: Property address data was populated by identifying rows with the same `ParcelID` and assigning the same property address to them. 🏠

3. **Breaking Down Property Address**: The property address was split into individual columns for `Address` and `City` to facilitate easier analysis and querying. 🏙️

4. **Breaking Down Owner Address**: Similar to the property address, the owner address was separated into individual columns for `Address`, `City`, and `State`. 🏠🌆

5. **Standardizing `Sold as Vacant` Field**: Values of `Y` and `N` in the `Sold as Vacant` field were converted to `Yes` and `No`, respectively, for consistency and clarity. ✅❌

6. **Removing Duplicates**: Duplicate entries were removed from the dataset to ensure data integrity and accuracy. 🚫

7. **Unused Columns Removed**: Several columns deemed unnecessary for analysis were removed from the dataset. 

### GitHub Repository
The SQL script used for data cleaning can be found in this [GitHub repository](SQLQuery_CleaningProject.sql). Feel free to explore the scripts and dataset for further insights. 🔗
