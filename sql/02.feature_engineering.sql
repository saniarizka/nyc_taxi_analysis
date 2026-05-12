-- Feature Engineering

CREATE OR REPLACE TABLE `my_project.my_dataset.cleaned_taxi_2016_v2` AS

SELECT *,

    -- distance conversion
    trip_distance * 1.60934 AS distance_km,

    -- pickup features
    DATE(pickup_datetime) AS pickup_date,
    EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,

    -- dropoff features
    DATE(dropoff_datetime) AS dropoff_date,
    EXTRACT(HOUR FROM dropoff_datetime) AS dropoff_hour,

    -- trip duration in minutes
    TIMESTAMP_DIFF(
        dropoff_datetime,
        pickup_datetime,
        SECOND
    ) / 60 AS trip_duration_minutes,

    -- estimated trip speed
    SAFE_DIVIDE(
        trip_distance * 1.60934,
        TIMESTAMP_DIFF(
            dropoff_datetime,
            pickup_datetime,
            SECOND
        ) / 3600
    ) AS speed_kmh

FROM `my_project.my_dataset.cleaned_taxi_2016`;