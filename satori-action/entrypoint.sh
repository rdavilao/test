#!/bin/bash 

echo " ver - files: [$INPUT_FILES]"
ar = "rdavilao.zip"

echo "Testing chat-bot from [$INPUT_REPOSITORY] with:"
echo "  - format: [$INPUT_FORMAT]"
echo "  - files: [$ar]"

echo "CONTENIDO: "
ls

XMI_OUTPUT="${ar/.zip/.xmi}"
METRICS_OUTPUT="${ar/.zip/.metrics.json}"

if [ "$INPUT_FORMAT" = "conga" ]; then
#  echo `ls /`
    java -jar /AsymobJSON.jar $ar | tee /tmp/output.txt
    COUNT=`grep "INP = 0" /tmp/output.txt | wc --lines`
    if [ $COUNT -gt 2 ]; then
	echo "More than two intents with INP > 2"
	exit 1
    fi
elif [ "$INPUT_FORMAT" = "Dialogflow" ]; then
    echo "::debug::{Running CONGA with $ar"
    java -jar /CongaReverse.jar $ar $INPUT_FORMAT
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
