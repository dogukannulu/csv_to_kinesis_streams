#!/bin/bash

cd /data

# install pip3 and python3
sudo yum update
sudo yum install python3
sudo yum install python3-pip

# download the zip file
sudo curl -O https://github.com/dogukannulu/csv_to_kinesis_streams/blob/main/csv_to_kinesis.zip

# Unzip the files
sudo unzip csv_to_kinesis.zip

# Navigate to the extracted directory
cd csv_to_kinesis

# Install the required libraries
pip3 install -r requirements.txt

# Execute the Python script
sudo chmod +x csv_to_kinesis.py
python3 data_streams.py --stream_name streaming-ec2-csv --interval 2 --max_rows 60 --skip-header
