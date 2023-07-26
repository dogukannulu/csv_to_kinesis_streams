# Overview

This repo will be streaming the `iris.csv` file row by row into Amazon Kinesis Data Streams.

### Assuming you are working in a Linux distribution

1. Create necessary directory inside the EC2 instance:
````
sudo mkdir /data
cd /data
````

2. Download `setup.sh` into your instance (/data)
````
sudo curl -O https://raw.githubusercontent.com/dogukannulu/csv_to_kinesis_streams/main/setup.sh
````

3. Make `setup.sh` executable and run.

````
sudo chmod +x setup.sh
./setup.sh
````

It will get the machine ready first. Then, download the zip file, install necessary libraries and run the Python script.
CSV data will be streaming to Kinesis Data Streams in the end

Note: zip file includes `iris.csv`, `data_streams.py` and `requirements.txt`
