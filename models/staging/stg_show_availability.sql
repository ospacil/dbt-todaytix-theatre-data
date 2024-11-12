WITH SHOW_METADATA
  AS (
    SELECT CAST(show_id AS STRING) AS show_id,
           show_name,
           starting_date,
           closing_date,
           CAST(venue_id AS STRING) AS venue_id,
           venue_name
      FROM {{ ref("show_metadata") }}
  )

SELECT showId AS show_id,
       B.show_name,
       B.starting_date,
       B.closing_date,
       requestTime AS request_timestamp,
       DATE(requestTime) AS request_date,
       TIME(requestTime) AS request_time,
       DATE_DIFF(performanceTime, requestTime, DAY) AS days_till_performance,
       performanceTime AS performance_timestamp,
       DATE(performanceTime) AS performance_date,
       TIME(performanceTime) AS performance_time,
       performanceType AS performance_type,
       availableSeatCount AS available_seat_count,
       largestLumpOfTickets AS largest_lump_of_tickets,
       minPrice / 100 AS min_price,
       maxPrice / 100 AS max_price,
       currency,
       discountAvailable AS discount_available,
       B.venue_id,
       B.venue_name
  FROM {{ source("todaytix_api_raw", "show_availability") }} AS A
  LEFT JOIN SHOW_METADATA AS B
    ON A.showId = B.show_id
 ORDER BY request_timestamp, show_id, performance_timestamp
