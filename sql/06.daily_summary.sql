-- Daily Summary

CREATE OR REPLACE TABLE `my_project.my_dataset.daily_summary` AS

WITH temp AS (

    SELECT

        vendor_id,
        pickup_date,

        MOD(EXTRACT(DAYOFWEEK FROM pickup_datetime) + 5, 7) + 1 AS day_num,

        FORMAT_DATE('%A', pickup_date) AS day_name,

        ROUND(AVG(distance_km), 2) AS avg_distance,
        ROUND(AVG(fare_amount), 2) AS avg_fare,
        ROUND(AVG(tip_amount), 2) AS avg_tip,

        ROUND(SUM(trip_duration_minutes), 2) AS total_duration_minutes,
        ROUND(AVG(trip_duration_minutes), 2) AS avg_duration_minutes,

        ROUND(AVG(speed_kmh), 2) AS avg_speed_kmh,

        ROUND(SUM(passenger_count), 2) AS total_passenger,
        ROUND(AVG(passenger_count), 2) AS avg_passenger,

        COUNT(*) AS total_trip,

        ROUND(SUM(total_amount), 2) AS total_revenue,

        ROUND(MIN(total_amount), 2) AS min_transaction,
        ROUND(MAX(total_amount), 2) AS max_transaction,

        ROUND(STDDEV(total_amount), 2) AS std_transaction

    FROM `my_project.my_dataset.my_table`

    GROUP BY
        vendor_id,
        pickup_date,
        day_name,
        day_num
)

SELECT *,

    CASE
        WHEN day_name IN ('Saturday', 'Sunday') THEN 1
        ELSE 0
    END AS is_weekend

FROM temp;