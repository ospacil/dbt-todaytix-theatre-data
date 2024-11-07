SELECT showId AS show_id,
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
       discountAvailable AS discount_available
  FROM {{ source("todaytix_api_raw", "show_availability") }}
 ORDER BY request_timestamp, show_id, performance_timestamp
