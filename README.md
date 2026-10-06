# customer-shopping-behavior-r


# Customer Shopping Behavior — Data Wrangling and Preprocessing Using R

## Overview

This project demonstrates a complete data wrangling and preprocessing workflow using R on a Customer Shopping Behavior dataset.

The main objective is to clean the raw dataset, assess data quality, transform the data, perform feature engineering, encode categorical variables, and scale numerical features to prepare the dataset for further analysis and machine learning.

## Dataset

The dataset contains customer shopping behavior information with 3,900 records and 18 original attributes.

### Main Attributes

| Attribute              | Description                  |
| ---------------------- | ---------------------------- |
| Customer.ID            | Unique customer identifier   |
| Age                    | Customer age                 |
| Gender                 | Customer gender              |
| Item.Purchased         | Product purchased            |
| Category               | Product category             |
| Purchase.Amount..USD.  | Purchase amount in USD       |
| Location               | Customer location            |
| Size                   | Product size                 |
| Color                  | Product color                |
| Season                 | Purchase season              |
| Review.Rating          | Customer review rating       |
| Subscription.Status    | Subscription status          |
| Shipping.Type          | Shipping method              |
| Discount.Applied       | Whether discount was applied |
| Promo.Code.Used        | Whether promo code was used  |
| Previous.Purchases     | Number of previous purchases |
| Payment.Method         | Payment method               |
| Frequency.of.Purchases | Purchase frequency           |

## Objectives

The project focuses on the following tasks:

* Understanding the dataset structure
* Assessing data quality
* Handling missing values
* Checking duplicate records
* Checking data consistency
* Detecting potential outliers
* Converting data types
* Performing feature engineering
* Encoding categorical variables
* Scaling numerical features
* Creating a final transformed dataset
* Maintaining a reproducible preprocessing workflow

## Data Quality Assessment

### Missing Values

The initial dataset contained missing values in the `Review.Rating` column.

A total of 37 missing values were identified.

The median review rating was calculated as 3.8 and used to replace the missing values.

```r
median(data$Review.Rating, na.rm = TRUE)

data$Review.Rating[is.na(data$Review.Rating)] <- 3.8
```

After imputation, no missing values remained.

### Duplicate Records

Duplicate records were checked using:

```r
sum(duplicated(data))
```

No duplicate records were found.

### Outlier Analysis

Numerical variables were examined using boxplots and the Interquartile Range (IQR) method.

The following variables were assessed:

* Age
* Purchase Amount
* Review Rating
* Previous Purchases

No meaningful outliers requiring removal were identified.

## Data Cleaning

The following cleaning steps were performed:

1. Missing values were identified and treated.
2. Duplicate records were checked.
3. Categorical variables were inspected for inconsistent values.
4. Numerical ranges were checked for invalid values.
5. Appropriate data types were assigned to categorical variables.

## Feature Engineering

### Age Group

A new `Age.Group` feature was created from the customer's age.

The age ranges were divided into:

* Young Adult
* Adult
* Middle Age
* Senior

```r
data$Age.Group <- cut(
  data$Age,
  breaks = c(17, 25, 35, 50, Inf),
  labels = c(
    "Young Adult",
    "Adult",
    "Middle Age",
    "Senior"
  )
)
```

This feature provides a more meaningful categorical representation of customer age.

## Categorical Encoding

Different encoding techniques were selected based on the nature of each categorical variable.

### Binary Encoding

The following variables were converted into binary values:

* Gender
* Subscription.Status
* Discount.Applied
* Promo.Code.Used

Example:

```text
Female = 0
Male = 1
```

### Ordinal Encoding

`Size` was encoded according to its natural order:

```text
S  = 1
M  = 2
L  = 3
XL = 4
```

This was appropriate because product sizes have a meaningful order.

### One-Hot Encoding

One-hot encoding was applied to nominal categorical variables where there was no meaningful numerical order.

Variables include:

* Category
* Season
* Shipping.Type
* Payment.Method
* Frequency.of.Purchases

Example:

```r
payment_encoded <- model.matrix(
  ~ Payment.Method - 1,
  data = data
)
```

One-hot encoding converts categorical values into separate binary columns containing 0 and 1.

## Feature Scaling

Min-Max scaling was applied to numerical features:

* Age
* Purchase Amount
* Review Rating
* Previous Purchases

The Min-Max scaling formula is:

```text
Scaled Value = (x - minimum) / (maximum - minimum)
```

R implementation:

```r
numeric_cols <- c(
  "Age",
  "Purchase.Amount..USD.",
  "Review.Rating",
  "Previous.Purchases"
)

data_scaled <- data

data_scaled[numeric_cols] <- lapply(
  data_scaled[numeric_cols],
  function(x) {
    (x - min(x)) / (max(x) - min(x))
  }
)
```

After scaling, the selected numerical features are represented on a 0–1 scale.

`Customer.ID` was not scaled because it is an identifier rather than a meaningful numerical measurement.

## Final Dataset

The final transformed dataset contains:

* Cleaned data
* Imputed review ratings
* Engineered age groups
* Binary encoded variables
* Ordinal encoded size
* One-hot encoded categorical variables
* Min-Max scaled numerical features

The processed dataset is exported as:

```text
customer_shopping_behavior_transformed.csv
```

## Project Structure

```text
Customer-Shopping-Behavior-R/
│
├── data/
│   └── customer_shopping_behavior.csv
│
├── R/
│   └── data_wrangling.R
│
├── plots/
│   └── customer_age_boxplot.png
│
├── output/
│   └── customer_shopping_behavior_transformed.csv
│
├── report/
│   └── Data_Wrangling_Report.docx
│
└── README.md
```

## Tools and Technologies

* R
* RStudio
* Base R
* `model.matrix()`
* Data Wrangling
* Data Cleaning
* Feature Engineering
* Categorical Encoding
* Min-Max Scaling
* Exploratory Data Analysis

## How to Run

### 1. Clone the repository

```bash
git clone <repository-url>
```

### 2. Open the R script

Open:

```text
R/data_wrangling.R
```

in RStudio.

### 3. Update the dataset path

Set the path to the location of the dataset on your computer.

```r
data <- read.csv("path/to/customer_shopping_behavior.csv")
```

### 4. Run the preprocessing workflow

Execute the R script to perform:

* Data loading
* Data quality assessment
* Missing value treatment
* Duplicate checking
* Feature engineering
* Categorical encoding
* Feature scaling
* Final dataset generation

### 5. Check the output

The transformed dataset will be generated as:

```text
output/customer_shopping_behavior_transformed.csv
```

## Reproducibility

The preprocessing workflow is implemented in R so that the same operations can be reproduced on the original dataset.

The workflow follows:

```text
Raw Dataset
     |
     v
Data Quality Assessment
     |
     v
Data Cleaning
     |
     v
Feature Engineering
     |
     v
Categorical Encoding
     |
     v
Feature Scaling
     |
     v
Final Transformed Dataset
```

## Results

The project successfully transformed the raw customer shopping dataset into a cleaner and machine-learning-ready representation.

Key preprocessing results:

* 3,900 customer records processed
* 37 missing review ratings treated
* No duplicate records found
* Numerical features checked for outliers
* Age Group feature created
* Binary encoding performed
* Ordinal encoding performed
* One-hot encoding performed
* Numerical features scaled to a 0–1 range
* Final transformed CSV generated

## Conclusion

This project demonstrates how raw customer shopping data can be systematically cleaned, transformed, and prepared for further analysis and machine learning.

The preprocessing workflow improves data quality and converts categorical and numerical variables into formats that can be more effectively used in statistical analysis and machine learning models.
