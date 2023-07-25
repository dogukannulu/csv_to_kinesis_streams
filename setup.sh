#!/bin/bash

# install pip3 and python3
sudo yum update
sudo yum install python3
sudo yum install python3-pip

# download the zip file
curl -O https://github.com/dogukannulu/csv_to_kinesis_streams/blob/main/csv_to_kinesis.zip

# Unzip the files
unzip csv_to_kinesis.zip

# Navigate to the extracted directory
cd csv_to_kinesis

# Install the required libraries
pip3 install -r requirements.txt

# Execute the Python script
python3 data_streams.py --stream_name <kinesis_stream_name> --interval 2 --max_rows 60 --skip-header
