#!/bin/bash

# install pip3, python3, wget
sudo yum update
sudo yum install python3
sudo yum install python3-pip
sudo yum install wget

# download the zip file
cd /data
sudo wget https://github.com/dogukannulu/csv_to_kinesis_streams/raw/main/csv_to_kinesis.zip

# Unzip the files
sudo unzip -d csv_to_kinesis.zip csv_to_kinesis

# Navigate to the extracted directory
cd csv_to_kinesis

# Install the required libraries
pip3 install -r requirements.txt

# Execute the Python script
sudo chmod +x csv_to_kinesis.py
python3 data_streams.py --stream_name streaming-ec2-csv --interval 2 --max_rows 60 --skip-header
