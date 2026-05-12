-- Payment Behavior Summary

CREATE OR REPLACE TABLE `my_project.my_dataset.payment_behavior_summary` AS

SELECT

    payment_type,
    vendor_id,

    FORMAT_DATE('%A', pickup_date) AS day_name,

    MOD(EXTRACT(DAYOFWEEK FROM pickup_datetime) + 5, 7) + 1 AS day_num,

    CASE
        WHEN FORMAT_DATE('%A', pickup_date) IN ('Saturday', 'Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    CASE
        WHEN payment_type = '1' THEN 'Credit Card'
        WHEN payment_type = '2' THEN 'Cash'
        WHEN payment_type = '3' THEN 'No Charge'
        WHEN payment_type = '4' THEN 'Dispute'
        WHEN payment_type = '5' THEN 'Unknown'
        WHEN payment_type = '6' THEN 'Voided Trip'
        ELSE 'Other'
    END AS payment_name,

    ROUND(SUM(total_amount), 2) AS total_revenue,

    ROUND(AVG(tip_amount), 2) AS avg_tip,
    ROUND(AVG(fare_amount), 2) AS avg_fare,

    COUNT(*) AS total_trip,

    ROUND(AVG(distance_km), 2) AS avg_distance,
    ROUND(AVG(trip_duration_minutes), 2) AS avg_duration,

    ROUND(SUM(tip_amount), 2) AS total_tip,

    ROUND(AVG(speed_kmh), 2) AS avg_speed,

    ROUND(SUM(passenger_count), 2) AS total_passenger,
    ROUND(AVG(passenger_count), 2) AS avg_passenger

FROM `my_project.my_dataset.my_table`

GROUP BY
    payment_type,
    payment_name,
    day_name,
    day_num,
    day_type,
    vendor_id;