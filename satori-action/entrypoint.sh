#!/bin/bash 

echo "Testing chat-bot from $GITHUB_REPOSITORY with:"
echo " - format: [$INPUT_FORMAT]"

XMI_OUTPUT="${GITHUB_REPOSITORY_NAME/.zip/.xmi}"
METRICS_OUTPUT="${GITHUB_REPOSITORY_NAME/.zip/.metrics.json}"

if [ "$INPUT_FORMAT" = "conga" ]; then
#  echo `ls /`
    java -jar /AsymobJSON.jar $GITHUB_REPOSITORY_NAME | tee /tmp/output.txt
    COUNT=`grep "INP = 0" /tmp/output.txt | wc --lines`
    if [ $COUNT -gt 2 ]; then
	echo "More than two intents with INP > 2"
	exit 1
    fi
elif [ "$INPUT_FORMAT" = "Dialogflow" ]; then
    echo "::debug::{Running CONGA with $GITHUB_REPOSITORY_NAME}"
    java -jar /CongaReverse.jar $GITHUB_REPOSITORY_NAME $INPUT_FORMAT
    echo "::debug::{Running Asymob with $XMI_OUTPUT}"
    java -jar /AsymobJSON.jar $XMI_OUTPUT
fi

echo "::group::Metrics"
echo "Information about metrics"
echo "::endgroup::"

echo "TEST-FILES"
ls test-files


#echo "$GITHUB_STEP_SUMMARY"
echo "Expected file"
echo $METRICS_OUTPUT
#jq '."Intent Metrics" | .[] | [.name, .INTP] | @tsv' "$METRICS_OUTPUT"#  >> "${GITHUB_STEP_SUMMARY}"

#python3 --version
#cat /metrics_to_html.py
python3 /metrics_to_html.py -f $METRICS_OUTPUT >> "${GITHUB_STEP_SUMMARY}"
#echo "xxxx" >> "${GITHUB_STEP_SUMMARY}"

#python

#jq '."Global Metrics".ENT' $METRICS_OUTPUT


exit 0
