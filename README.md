# NYC Taxi Trip Analysis

This project analyzes NYC Taxi Trip data from 2016 using SQL, Python, and statistical analysis techniques to identify travel patterns and factors affecting driver revenue.

## Data Source

Dataset was obtained from the official NYC Taxi website using sampled 2016 trip data (not full population data).

## Project Workflow

### 1. Data Extraction & Cleaning (BigQuery)

The initial data processing was performed in BigQuery by filtering and validating the raw dataset.

Data preparation steps included:

* Removing invalid numeric values (< 0)
* Checking missing values in numeric columns
* Checking duplicate records
* Creating new derived columns such as:
  * pickup hour
  * pickup date
  * weekday/weekend classification
  * distance (km) and speed (km/h)

### 2. Exploratory Data Analysis (Python)

Further analysis was conducted using Python libraries such as Pandas, Matplotlib, and Seaborn.

EDA activities included:

* Distribution visualization
* Histogram analysis to identify skewed data
* Correlation analysis
* Trip pattern exploration based on time and payment behavior

### 3. Statistical Testing

Statistical tests were performed to validate differences and relationships between variables, including:

* Comparison between weekday and weekend trip behavior
* Payment type behavior analysis
* Relationship analysis between trip variables and revenue

### 4. Regression Modeling

A regression model was developed to identify variables that significantly influence driver revenue (`total_amount`).

To avoid data leakage, monetary-related columns such as:

* `fare_amount`
* `tip_amount`
* `tolls_amount`
* `extra`
* `mta_tax`
* `imp_surcharge`
* `total_amount

were excluded from the modeling process.

The model focuses on operational and trip-related variables to better understand factors contributing to revenue optimization.

## Tools & Technologies

* Google BigQuery
* Python
* Pandas
* Matplotlib
* Scikit-learn
* Statistical Testing

## Project Objective

The main objective of this project is to analyze taxi trip behavior and identify operational factors that contribute to higher driver revenue.
