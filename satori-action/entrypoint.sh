#!/bin/bash 

BGREEN='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
NC='\033[0m'

gM_ENT_MAX=10
gM_ENT_MIN=0
gM_INT_MAX=10
gM_INT_MIN=0
gM_NL_MAX=10
gM_NL_MIN=0
gM_FLOW_MAX=10
gM_FLOW_MIN=0
gM_PATH_MAX=10
gM_PATH_MIN=0
gM_LPE_MAX=10
gM_LPE_MIN=0
gM_SPL_MAX=10
gM_SPL_MIN=0
gM_WL_MAX=10
gM_WL_MIN=0
gM_CL_MAX=10
gM_CL_MIN=0
gM_FPATH_MAX=10
gM_FPATH_MIN=0
gM_FACT_MAX=10
gM_FACT_MIN=0
gM_TPI_MAX=10
gM_TPI_MIN=0
gM_WPTP_MAX=10
gM_WPTP_MIN=0
gM_PPTP_MAX=10
gM_PPTP_MIN=0
gM_CPOP_MAX=10
gM_CPOP_MIN=0

function isMetricJson(){
    if test -e metrics.json; then
        return 0
    else
        return 1
    fi
}

if [ "$INPUT_FORMAT" = "" ]; then
    echo -e "${BRED}Format must be specified${NC}"
    exit 1
fi

echo -e "Testing chat-bot from ${BYELLOW}$GITHUB_REPOSITORY${NC} with:"
echo -e " - format: ${BYELLOW}[$INPUT_FORMAT]${NC}"

repo=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)

if [ "$INPUT_FORMAT" = "conga" ]; then
    INPUT_FILES=$repo.xmi
else
    echo "::group::Compressing repository"
    INPUT_FILES=$repo.zip
    PLANTUML_TXT=$repo.txt
    zip -r $INPUT_FILES .    
    echo "::endgroup::"
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
    java -jar /CongaReverse_pUML.jar $INPUT_FILES $INPUT_FORMAT

    XMI_FILE=./$repo.xmi

    if test -f "$XMI_FILE"; then    
        echo -e "${BGREEN}Archivo $XMI_FILE ha sido creado exitosamente${NC}"
    else
        echo -e "${BRED}Hubo un error al generar el archivo $XMI_FILE${NC}"
        exit 1
    fi

    java -jar /plantUML-encode.jar $PLANTUML_TXT
    imgEncoded=$(cat plantUML-encoded.txt)

    echo "::debug::{Running Asymob with $XMI_OUTPUT}"
    java -jar /AsymobJSON.jar $XMI_OUTPUT
fi

globalMetrics=$(jq --raw-output '.["Global Metrics"]' $METRICS_OUTPUT)
gb=$(echo $METRICS_OUTPUT | jq --raw-output '.[Global Metrics]')


echo "GlobalMetrics: $globalMetrics"
echo "GB: $gb"

gM_ENT=$(echo "$globalMetrics" | jq '.ENT')
gM_INT=$(echo "$globalMetrics" | jq '.INT')
gM_NL=$(echo "$globalMetrics" | jq '.NL')
gM_FLOW=$(echo "$globalMetrics" | jq '.FLOW')
gM_PATH=$(echo "$globalMetrics" | jq '.PATH')
gM_LPE=$(echo "$globalMetrics" | jq '.LPE')
gm_LPE=$(echo "$gm_LPE" | bc)

gM_SPL=$(echo "$globalMetrics" | jq '.SPL')
gM_WL=$(echo "$globalMetrics" | jq '.WL')
gM_CL=$(echo "$globalMetrics" | jq '.CL')
gM_FPATH=$(echo "$globalMetrics" | jq '.FPATH')
gM_FACT=$(echo "$globalMetrics" | jq '.FACT')
gM_TPI=$(echo "$globalMetrics" | jq '.TPI')
gM_WPTP=$(echo "$globalMetrics" | jq '.WPTP')
gM_PPTP=$(echo "$globalMetrics" | jq '.PPTP')
gM_CPOP=$(echo "$globalMetrics" | jq '.CPOP')

#Making chatbot conversation flow
echo "# Chatbot conversation flow" >> "${GITHUB_STEP_SUMMARY}"
echo "![$repo conversation flow](http://www.plantuml.com/plantuml/png/$imgEncoded)" >> "${GITHUB_STEP_SUMMARY}"
echo "#### This diagram is built thanks to:  <a href='https://plantuml.com/'>PlantUML</a>" >> "${GITHUB_STEP_SUMMARY}"
echo "****" >> "${GITHUB_STEP_SUMMARY}"


#Making table about metrics
echo "# Chatbot Metrics" >> "${GITHUB_STEP_SUMMARY}"

echo "| Name | Value | Result |" >> "${GITHUB_STEP_SUMMARY}"
echo " :-: | :-: | :-: " >> "${GITHUB_STEP_SUMMARY}"
echo " ENT | $gM_ENT | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " INT | $gM_INT | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " NL | $gM_NL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " FLOW | $gM_FLOW | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " PATH | $gM_PATH | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " LPE | $gM_LPE | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " SPL | $gM_SPL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " WL | $gM_WL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " CL | $gM_CL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " FPATH | $gM_FPATH | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " FACT | $gM_FACT | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " TPI | $gM_TPI | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " WPTP | $gM_WPTP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " PPTP | $gM_PPTP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
echo " CPOP | $gM_CPOP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"

echo "#### For more information on the interpretation of these matrices, please visit:  <a href='http://miso.ii.uam.es/asymobService/metrics.html'>asymob</a>" >> "${GITHUB_STEP_SUMMARY}"

echo "::group::Metrics"
echo "Information about metrics"
echo "::endgroup::"
#echo "$GITHUB_STEP_SUMMARY"
echo "Expected file"
echo $METRICS_OUTPUT
#jq '."Intent Metrics" | .[] | [.name, .INTP] | @tsv' "$METRICS_OUTPUT"#  >> "${GITHUB_STEP_SUMMARY}"

#python3 --version
#cat /metrics_to_html.py
#python3 /metrics_to_html.py -f $METRICS_OUTPUT >> "${GITHUB_STEP_SUMMARY}"
#echo "xxxx" >> "${GITHUB_STEP_SUMMARY}"

#python

#jq '."Global Metrics".ENT' $METRICS_OUTPUT
exit 0
