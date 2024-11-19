
# Airbnb Listings Analysis: A Comprehensive Report on Property Trends, Pricing, and Availability in Sydney

We conducted an in-depth analysis of Airbnb listings in Sydney to uncover trends in property types, pricing, ratings, and availability. This report highlights the performance of Airbnb properties across different neighborhoods, room types, and host performances, providing valuable insights for making informed decisions in investment and marketing strategies. The goal is to offer actionable insights into the most profitable locations and property types to optimize returns and guide future business decisions.


## Objective

The primary objective of this analysis is to:

* Identify the most profitable neighborhoods and property types in Sydney.
* Provide an understanding of the pricing trends and how they vary across different areas.
* Evaluate the performance of hosts and listings based on reviews, ratings, and listing characteristics.
* Offer recommendations for investment strategies based on data-driven insights.
## Data source

* What data is needed to achieve our objective?
To achieve the objective of identifying top-performing Airbnb listings across NSW, we need the following data:

* Airbnb property names
* Average price per listing
* Ratings for each listing
* Number of reviews
* Room type (e.g., entire home, private room, shared room)
Where is the data coming from?
The data is sourced directly from the [Airbnb website](https://insideairbnb.com/get-the-data/), which provides up-to-date details on listings across New South Wales (NSW). This includes pricing, reviews, ratings, and room types for each listing available on the platform.
## Tools

| **Tool**      | **Purpose**                                      | **Details**                                              |
|---------------|--------------------------------------------------|----------------------------------------------------------|
| **Excel**     | Exploring the raw data                           | Used to load and explore the raw data to understand its structure. |
| **Python**    | Data cleaning                                    | Used for cleaning tasks like removing null values, dropping irrelevant columns, and filtering data (e.g., after 2024-01-01). |
| **MySQL**     | Data analysis                                    | Data is uploaded into MySQL for more advanced analysis, queries, and aggregations (e.g., calculating averages, identifying trends). |


## Data Exploration

- **Data Import & Inspection**:
  - Imported Airbnb dataset using pandas (`pd.read_csv`).
  - Performed initial inspection with `df.head()`, `df.info()`, and `df.describe()`.

- **Missing Values Handling**:
  - Identified missing values in the following columns: `neighbourhood_group`, `price`, `last_review`, `reviews_per_month`, and `license`.
  - Dropped `neighbourhood_group` column (entirely null).
  - Replaced missing `last_review` with "No Reviews" and `reviews_per_month` with 0.
  - Filled missing `license` values with "Pending" (assumed new or pending licenses).

- **Price Column Handling**:
  - Imputed missing `price` values with the median price based on the `room_type`.

- **Column Name Standardization**:
  - Converted all column names to lowercase for consistency.

- **Data Upload**:
  - Uploaded the cleaned data to MySQL for further analysis using `df.to_sql()`.

## Data Quality Check

### Data Validation Summary

- **Missing Values**:
  - Checked for missing values in the dataset, and the following columns had missing data:
    - `last_review` (2987 missing values)
    - No missing values were found in other columns.

- **Handling `last_review`**:
  - Left `last_review` as `null` to account for new listings that haven’t received reviews yet.

- **Other Missing Data**:
  - Handled other missing data in columns (`reviews_per_month`, `license`, `price`, etc.) during the data cleaning process as detailed previously.



## Analysis

### Findings


* What is the average price of listings for the top 10 hosts with the most listings?

| Host ID      | Host Name                         | Number of Listings | Average Price (AUD) |
|--------------|-----------------------------------|--------------------|---------------------|
| 279001183    | MadeComfy                         | 176                | 244.49              |
| 288743418    | Ken                               | 134                | 76.18               |
| 91961414     | Kimi                              | 93                 | 169.75              |
| 7409213      | L'Abode Accommodation Specialist  | 90                 | 372.80              |
| 15739069     | Apartment Service                 | 77                 | 182.66              |
| 301753450    | Tim                               | 77                 | 237.58              |
| 2450066      | Hotelesque                        | 72                 | 364.79              |
| 5215877      | Milan                             | 55                 | 301.18              |
| 101139031    | Gabriel HH                        | 55                 | 243.04              |
| 108083073    | Urban Stays                       | 53                 | 224.32              |

* What are the 15 neighborhoods with the highest average prices, and how many listings are there in each of these areas?

| Location            | Average Price | Count |
|---------------------|---------------|-------|
| Pittwater           | 563.52        | 485   |
| Mosman              | 380.05        | 130   |
| Sutherland Shire    | 369.12        | 316   |
| Warringah           | 351.21        | 479   |
| Manly               | 349.49        | 519   |
| Woollahra           | 349.15        | 318   |
| Waverley            | 320.68        | 1000  |
| Randwick            | 284.88        | 588   |
| City Of Kogarah     | 272.55        | 58    |
| Hornsby             | 267.13        | 240   |
| North Sydney        | 259.67        | 456   |
| Sydney              | 252.55        | 2716  |
| Leichhardt          | 245.12        | 276   |
| Willoughby          | 243.47        | 188   |
| Penrith             | 233.41        | 126   |

* Which room types have the highest average ratings?
| Property Type     | Count | Average Price |
|-------------------|-------|---------------|
| Entire home/apt   | 9251  | 303.32        |
| Private room      | 1866  | 102.61        |
| Hotel room        | 64    | 201.31        |
| Shared room       | 25    | 100.64        |


* What is the relationship between average price and average availability across locations?


| Location         |  Average Availability |Average Price ($) |
|----------------------|-----------------------|---------------------------------|
| Pittwater            | 198.30                | 563.52                          |
| Mosman               | 173.36                | 380.05                          |
| Sutherland Shire     | 176.31                | 369.12                          |
| Warringah            | 150.75                | 351.21                          |
| Manly                | 146.41                | 349.49                          |
| Woollahra            | 150.84                | 349.15                          |
| Waverley             | 146.73                | 320.68                          |
| Randwick             | 163.18                | 284.88                          |
| City of Kogarah      | 179.52                | 272.55                          |
| Hornsby              | 172.05                | 267.13                          |
| North Sydney         | 160.16                | 259.67                          |
| Sydney               | 144.90                | 252.55                          |
| Leichhardt           | 132.67                | 245.12                          |
| Willoughby           | 122.77                | 243.47                          |
| Penrith              | 194.40                | 233.41                          |

## Findings

1. **High Price Variability Across Locations**  
   There is a significant range in average prices across neighborhoods, with **Pittwater** having the highest average price at **$563.52**, while **Penrith** has the lowest at **$233.41**. This suggests that pricing in different areas of the city varies widely, potentially reflecting the desirability or exclusivity of the neighborhoods.

2. **Room Type Pricing and Count**  
   The **"Entire home/apt"** room type has the highest average price at **$303.32** and also the highest count of listings (**9251**), indicating it is the most common and potentially the most expensive property type. Meanwhile, **Private rooms** are more affordable at **$102.61**, but they are also significantly more numerous than hotel or shared rooms.

3. **No Clear Correlation Between Price and Availability**  
   While there are variations in average prices and availability across neighborhoods, the data does not show a direct relationship between the two. For example, **Pittwater** has a high price and availability, whereas **Penrith** has a lower price and availability, suggesting factors other than price might influence listing availability in different areas.

## Conclusion

This analysis has provided valuable insights into the relationship between average prices, availability, and various factors such as host listings, neighborhoods, and property types across the dataset. The key findings reveal distinct trends:

1. **Host Listings and Price**: Hosts with the most listings tend to have a varied pricing range, with some having significantly higher average prices, such as L'Abode Accommodation Specialist at $372.80 per night. This highlights that larger hosts may offer premium options, or have a greater presence in higher-priced neighborhoods.

2. **Neighborhood Pricing**: The analysis of neighborhoods reveals that areas like Pittwater, Mosman, and Sutherland Shire have the highest average prices, suggesting they are premium locations with higher demand and possibly a more affluent customer base.

3. **Room Type Performance**: "Entire home/apt" listings dominate in terms of quantity and average price, reflecting a strong demand for private, whole-property accommodations. In contrast, shared rooms and private rooms are priced significantly lower, appealing to budget-conscious guests.

Overall, this analysis offers key insights into pricing trends and availability across various property types and locations. The relationship between average price and availability also underscores potential areas for pricing strategy optimization.
