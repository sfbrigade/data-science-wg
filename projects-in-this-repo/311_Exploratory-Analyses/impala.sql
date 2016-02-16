DROP TABLE IF EXISTS calls_txt;
CREATE EXTERNAL TABLE calls_txt (
  case_id INT, 
  opened BIGINT, 
  closed BIGINT, 
  updated BIGINT, 
  status STRING, 
  status_notes STRING, 
  responsible_agency STRING, 
  category STRING, 
  request_type STRING, 
  request_details STRING, 
  address STRING, 
  supervisor_district STRING, 
  neighborhood STRING, 
  lat DECIMAL(15,12),
  lon DECIMAL(15,12),
  source STRING, 
  media_url STRING) 
LOCATION '/user/cloudera/calls_txt';

DROP TABLE IF EXISTS calls;
CREATE TABLE calls 
STORED AS PARQUET 
AS 
SELECT 
case_id, 
cast(opened AS TIMESTAMP) AS opened, 
cast(closed AS TIMESTAMP) AS closed, 
cast(updated AS TIMESTAMP) AS updated, 
status, 
status_notes, 
responsible_agency, 
category, 
request_type, 
request_details, 
address, 
supervisor_district, 
neighborhood, 
lat, 
lon, 
source, 
media_url FROM calls_txt;

SELECT case_id, cast(opened AS TIMESTAMP) AS opened, request_type, lat, lon FROM calls_txt WHERE opened IS NOT NULL ORDER BY case_id DESC;
