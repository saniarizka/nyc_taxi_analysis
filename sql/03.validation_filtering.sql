-- Data Validation & Outlier Handling

-- Check invalid trip duration
SELECT
    trip_duration_minutes
FROM `my_project.my_dataset.cleaned_taxi_2016_v2`
WHERE trip_duration_minutes < 0;

-- Explore short trip duration distribution
SELECT
    COUNT(*) AS total_short_trip
FROM `my_project.my_dataset.cleaned_taxi_2016_v2`
WHERE trip_duration_minutes < 1;

-- Descriptive statistics
SELECT
    MAX(distance_km) AS max_distance_km,
    MIN(distance_km) AS min_distance_km,
    AVG(distance_km) AS avg_distance_km,

    MAX(trip_duration_minutes) AS max_duration_minutes,
    MIN(trip_duration_minutes) AS min_duration_minutes,
    AVG(trip_duration_minutes) AS avg_duration_minutes

FROM `my_project.my_dataset.cleaned_taxi_2016_v2`;

-- Speed validation
SELECT
    MAX(speed_kmh) AS max_speed,
    MIN(speed_kmh) AS min_speed,
    AVG(speed_kmh) AS avg_speed
FROM `my_project.my_dataset.cleaned_taxi_2016_v2`;

-- Speed Categorization Analysis

WITH raw AS (

    SELECT *,

        CASE
            WHEN speed_kmh < 0 THEN 'invalid'
            WHEN speed_kmh >= 0 AND speed_kmh < 5 THEN 'severe_congestion'
            WHEN speed_kmh >= 5 AND speed_kmh < 10 THEN 'moderate_congestion'
            WHEN speed_kmh >= 10 AND speed_kmh < 60 THEN 'normal'
            WHEN speed_kmh >= 60 AND speed_kmh <= 120 THEN 'extreme'
            ELSE 'suspicious_speed'
        END AS speed_category

    FROM `my_project.my_dataset.cleaned_taxi_2016_v2`
)

SELECT
    speed_category,
    COUNT(*) AS total_trip,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS pct_total

FROM raw

GROUP BY speed_category
ORDER BY total_trip DESC;

-- Filter Invalid & Extreme Records

CREATE OR REPLACE TABLE `my_project.my_dataset.cleaned_taxi_2016_v3` AS

SELECT *,

    CASE
        WHEN speed_kmh >= 0 AND speed_kmh < 5 THEN 'severe_congestion'
        WHEN speed_kmh >= 5 AND speed_kmh < 10 THEN 'moderate_congestion'
        WHEN speed_kmh >= 10 AND speed_kmh < 60 THEN 'normal'
        WHEN speed_kmh >= 60 AND speed_kmh <= 120 THEN 'extreme'
        ELSE 'unknown'
    END AS speed_category

FROM `my_project.my_dataset.cleaned_taxi_2016_v2`

WHERE
    speed_kmh >= 0
    AND speed_kmh <= 120
    AND trip_duration_minutes > 0;

-- Validation row count
SELECT
    COUNT(*) AS total_rows
FROM `my_project.my_dataset.cleaned_taxi_2016_v3`;

-- Revenue Aggregation Exploration

SELECT
    vendor_id,
    pickup_date,
    pickup_hour,
    payment_type,
    store_and_fwd_flag,
    rate_code,

    AVG(total_amount) AS avg_revenue,
    SUM(total_amount) AS total_revenue

FROM `my_project.my_dataset.cleaned_taxi_2016_v3`

GROUP BY
    vendor_id,
    pickup_date,
    pickup_hour,
    payment_type,
    store_and_fwd_flag,
    rate_code;

-- Additional charge analysis
SELECT
    vendor_id,
    pickup_hour,
    AVG(extra) AS avg_extra_charge

FROM `my_project.my_dataset.cleaned_taxi_2016_v3`

WHERE extra != 0

GROUP BY
    vendor_id,
    pickup_hour

ORDER BY pickup_hour;