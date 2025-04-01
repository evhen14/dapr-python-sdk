#!/bin/sh

aws configure set default.region us-west-2
aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test

DYNAMODB_ENDPOINT=http://dynamodb:8000

if aws dynamodb describe-table --table-name actors-store --endpoint-url "$DYNAMODB_ENDPOINT" > /dev/null 2>&1; then
    echo "✅ Table actors-state already exists. Skipping creation."
    echo "Sleep for health checks"
    sleep 10
    exit 0
else
    aws dynamodb create-table \
        --table-name actors-store \
        --attribute-definitions AttributeName=key,AttributeType=S \
        --key-schema AttributeName=key,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
        --endpoint-url $DYNAMODB_ENDPOINT \
        --region us-west-2
fi

echo "Sleep for health checks"
sleep 10