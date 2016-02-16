#!/bin/bash -e

brew install apache-spark
cd /usr/local/Cellar/apache-spark/1.6.0/libexec/
./bin/pyspark --executor-memory 16G --conf spark.drive.memory=16G
