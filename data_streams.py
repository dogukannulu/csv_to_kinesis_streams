import boto3
import csv
import time
import logging
import argparse

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s:%(funcName)s:%(levelname)s:%(message)s')
logger = logging.getLogger("CSV file to Kinesis Data Streams")


class GlobalVariables():
    csv_file_path = './iris.csv'


def define_arguments():
    """
    Defines the command-line arguments 
    """
    parser = argparse.ArgumentParser(description="Send CSV data to Kinesis Data Streams")
    parser.add_argument("--stream_name", "-sn", required=True, help="Name of the Kinesis Data Stream")
    parser.add_argument("--interval", "-i", type=int, required=True, help="Time interval (in seconds) between two writes")
    parser.add_argument("--max_rows", "-mr", type=int, default=150, help="Maximum number of rows to write (max: 150)")
    parser.add_argument("--skip_header", "-sh", action="store_true", help="Skip the header row in CSV")
    args = parser.parse_args()

    return args


def determine_partition_key(species):
    """
    Data will be partitioned due to species name
    """
    partition_key_mapping = {
        'Iris-setosa': '1',
        'Iris-versicolor': '2',
        'Iris-virginica': '3'
    }
    return partition_key_mapping.get(species, 'unknown')


def send_csv_to_kinesis(stream_name, interval, max_rows, skip_header, csv_file=GlobalVariables.csv_file_path):
    kinesis_client = boto3.client('kinesis')
    with open(csv_file, 'r') as file:
        csv_reader = csv.reader(file)
        if skip_header:
            next(csv_reader)  # Skip the header row

        rows_written = 0
        for row in csv_reader:
            species = row[-1]  # Assuming the last column contains the species name
            partition_key = determine_partition_key(species)
            data = ','.join(row)
            encoded_data = data.encode('utf-8')  # Encode the data as bytes
            
            response = kinesis_client.put_record(
                StreamName=stream_name,
                Data=encoded_data,
                PartitionKey=partition_key
            )
            logging.info(f"Record sent: {response['SequenceNumber']}")

            time.sleep(interval)

            rows_written += 1
            if rows_written >= max_rows:
                break


if __name__ == "__main__":
    args = define_arguments()

    if args.max_rows > 150:
        logging.warning("Warning: The maximum number of rows cannot exceed 150. Setting max_rows to 150.")
        args.max_rows = 150

    send_csv_to_kinesis(args.stream_name, args.interval, args.max_rows, args.skip_header)
