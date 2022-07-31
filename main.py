import boto3
from datetime import datetime
from time import strftime

# Create an S3 access object
s3 = boto3.client("s3")
# Retrieve current date to download last dump only
now = datetime.now()
year = now.strftime("%Y")
month = now.strftime("%m")
day = now.strftime("%d")
# Formatting the file naime
filename = "mongo/[name-of-backup]{}{}{}0000.archive".format(year, month, day)
# Download the last dump
s3.download_file(
    Bucket="[bucket-name]", Key=filename, Filename='[archive or dump name]'
)
# Print sucess message
print('Download Completed')
