#!/bin/bash

# install pip3 and python3
sudo yum update
sudo yum install python3
sudo yum install python3-pip

# download the zip file
cd /data
sudo curl -O https://github.com/dogukannulu/csv_to_kinesis_streams/raw/main/csv_to_kinesis.zip

# Unzip the files
cd /data
sudo unzip csv_to_kinesis.zip

# Navigate to the extracted directory
cd /data/csv_to_kinesis

# Install the required libraries
cd /data/csv_to_kinesis
pip3 install -r requirements.txt

# Execute the Python script
cd /data/csv_to_kinesis
sudo chmod +x csv_to_kinesis.py
python3 data_streams.py --stream_name streaming-ec2-csv --interval 2 --max_rows 60 --skip-header
