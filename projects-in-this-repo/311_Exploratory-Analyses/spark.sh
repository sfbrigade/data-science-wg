#!/bin/bash -e

brew install apache-spark
sudo mkdir /user
sudo chown `whoami` /user
mkdir -p /user/hive/warehouse
spark-sql --packages com.databricks:spark-csv_2.11:1.3.0 -v -f spark.sql
