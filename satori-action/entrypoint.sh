#!/bin/bash 

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;43m'
NC='\033[0m'

echo "Testing chat-bot from ${COLOR_YELLOW}$GITHUB_REPOSITORY${NC} with:"
echo " - format: ${COLOR_YELLOW}[$INPUT_FORMAT]${NC}"

repo=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)

if [ "$INPUT_FORMAT" = "conga" ]; then
    INPUT_FILES=$repo.xmi
else
    INPUT_FILES=$repo.zip
    zip -r $INPUT_FILES .
fi

XMI_OUTPUT="${INPUT_FILES/.zip/.xmi}"
METRICS_OUTPUT="${INPUT_FILES/.zip/.metrics.json}"

if [ "$INPUT_FORMAT" = "conga" ]; then
#  echo `ls /`
    java -jar /AsymobJSON.jar $INPUT_FILES | tee /tmp/output.txt
    COUNT=`grep "INP = 0" /tmp/output.txt | wc --lines`
    if [ $COUNT -gt 2 ]; then
	echo "More than two intents with INP > 2"
	exit 1
    fi
else
    echo "::debug::{Running CONGA with $INPUT_FILES}"
    java -jar /CongaReverse.jar $INPUT_FILES $INPUT_FORMAT

    XMI_FILE=./$repo.xmi

    if test -f "$XMI_FILE"; then    
        echo -e "${COLOR_GREEN}Archivo $XMI_FILE ha sido creado exitosamente${NC}"
    else
        echo -e "${COLOR_RED}Hubo un error al generar el archivo $XMI_FILE${NC}"
        exit 1
    fi

    echo "::debug::{Running Asymob with $XMI_OUTPUT}"
    java -jar /AsymobJSON.jar $XMI_OUTPUT
fi

echo "::group::Metrics"
echo "Information about metrics"
echo "::endgroup::"

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
