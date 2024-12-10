#!/bin/bash

# exit on error
set -e

FILE='../selling-partner-api-models/models/fulfillment-inbound-api-model/fulfillmentInboundV0.json'
API_NAME=`echo $FILE | awk -F/ '{print $4}'`
MODULE_NAME=`echo $API_NAME | perl -pe 's/(^|-)./uc($&)/ge;s/-//g'`V0

rm -r lib/${API_NAME}
mkdir lib/$API_NAME
cp config.json lib/$API_NAME
sed -i '' "s/GEMNAME/${API_NAME}/g" lib/${API_NAME}/config.json
sed -i '' "s/MODULENAME/${MODULE_NAME}/g" lib/${API_NAME}/config.json

swagger-codegen generate -i $FILE -l ruby -c lib/${API_NAME}/config.json -o lib/$API_NAME

mv lib/${API_NAME}/lib/${API_NAME}.rb lib/
mv lib/${API_NAME}/lib/${API_NAME}/* lib/${API_NAME}
rm -r lib/${API_NAME}/lib
rm lib/${API_NAME}/*.gemspec
