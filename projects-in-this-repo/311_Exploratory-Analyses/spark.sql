DROP TABLE IF EXISTS calls_strings;
CREATE TABLE calls_strings (case_id string, opened string, closed string, updated string, status string, status_notes string, responsible_agency string, category string, request_type string, request_details string, address string, supervisor_district string, neighborhood string, point string, source string, media_url string) 
USING com.databricks.spark.csv
OPTIONS (path "Case_Data_from_San_Francisco_311__SF311_.csv", header "true", mode "DROPMALFORMED"); -- some rows have the newline character character in the middle of the quoted free form text fields, which the Spark CSV plugin isn't able to handle at this time

SELECT count(*) FROM calls_strings;

SELECT request_type, count(*) AS total FROM calls_strings GROUP BY request_type ORDER BY total DESC;
