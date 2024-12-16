/* The couple (show_id, performance_timestamp) identifies a single performance of the show.
We expect a single row for each request_date.
*/
SELECT show_id,
       performance_timestamp,
       request_date,
       COUNT(*) AS num_of_rows
  FROM {{ ref("stg_show_availability") }}
 GROUP BY 1,2,3
HAVING COUNT(*) > 1