-- Initial Data Extraction & Cleaning
-- NYC Yellow Taxi Trip Data (2016 Sample)

CREATE OR REPLACE TABLE `my_project.my_dataset.cleaned_taxi_2016` AS

SELECT *
FROM `public_dataset.source_table`

WHERE
    pickup_datetime BETWEEN '2016-01-01' AND '2016-12-31'

    -- random sampling
    AND RAND() < 0.1

    -- valid numeric values
    AND trip_distance > 0
    AND fare_amount > 0
    AND total_amount > 0
    AND passenger_count > 0

    -- remove missing coordinates
    AND pickup_longitude IS NOT NULL
    AND pickup_latitude IS NOT NULL
    AND dropoff_longitude IS NOT NULL
    AND dropoff_latitude IS NOT NULL

    -- remove invalid coordinates
    AND pickup_longitude != 0
    AND pickup_latitude != 0
;