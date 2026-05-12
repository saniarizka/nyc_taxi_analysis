-- Final Cleaned Dataset
-- Outlier filtering based on distribution thresholds

CREATE OR REPLACE TABLE `my_project.my_dataset.my_table` AS

SELECT *
FROM `my_project.my_dataset.cleaned_taxi_2016_v3`

WHERE
    trip_duration_minutes BETWEEN 1 AND 60
    AND speed_kmh BETWEEN 0.2 AND 72
    AND distance_km <= 30

    AND fare_amount BETWEEN 2.5 AND 55
    AND extra <= 1
    AND mta_tax <= 0.5
    AND tip_amount <= 12
    AND tolls_amount <= 6;

-- Final dataset validation
SELECT
    COUNT(*) AS total_rows
FROM `my_project.my_dataset.cleaned_taxi_2016_v4`;

-- Duplicate Check

SELECT

    pickup_datetime,
    dropoff_datetime,

    pickup_latitude,
    pickup_longitude,

    dropoff_latitude,
    dropoff_longitude,

    distance_km,
    total_amount,

    COUNT(*) AS total_duplicate

FROM `my_project._my_dataset.my_table`

GROUP BY

    pickup_datetime,
    dropoff_datetime,

    pickup_latitude,
    pickup_longitude,

    dropoff_latitude,
    dropoff_longitude,

    distance_km,
    total_amount

HAVING COUNT(*) > 1

ORDER BY total_duplicate DESC;