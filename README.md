# Overview

This repo will be streaming the iris.csv file row by row into Amazon Kinesis Data Streams.

### Assuming you are working in a Linux distribution

1. 
````
curl -O https://raw.githubusercontent.com/dogukannulu/csv_to_kinesis_streams/main/setup.sh
````
This will download the sh script into your machine

2. Then only run

````
./setup.sh
````
It will get the machine ready first. Then, download the zip file, install necessary libraries and run the Python script.
CSV data will be streaming to Kinesis Data Streams
