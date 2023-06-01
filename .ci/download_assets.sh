#!/bin/bash

S3_ASSETS_BUCKET="${1}"
OUTPUT_DIRECTORY="${2}"

s3cmd --access_key=${GCS_ACCESS_KEY_ID} --secret_key="${GCS_SECRET_ACCESS_KEY}" --host="https://storage.googleapis.com" --host-bucket="https://storage.googleapis.com" get s3://${S3_ASSETS_BUCKET}/ssh.key ${OUTPUT_DIRECTORY}/ssh.key
s3cmd --access_key=${GCS_ACCESS_KEY_ID} --secret_key="${GCS_SECRET_ACCESS_KEY}" --host="https://storage.googleapis.com" --host-bucket="https://storage.googleapis.com" get s3://${S3_ASSETS_BUCKET}/inventory.yml ${OUTPUT_DIRECTORY}/inventory.yml
