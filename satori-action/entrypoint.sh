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

#Check if metrics.json exists with the minimum or maximum values per metric to be considered.
function isMetricJson(){
    if test -e metrics.json; then
        return 0
    else
        return 1
    fi
}

#Check if there is in metrics.json at least one key corresponding to the minimum or maximum value of some metric.
function keys_exist(){
  local key1="$1"
  local key2="$2"

  if jq -e ".\"$key1\"" "metrics.json" >/dev/null 2>&1 || jq -e ".\"$key2\"" "metrics.json" >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

#Check if the key exists in metrics.json 
function key_exist(){
    local key="$1"
    if jq -e ".${key}" "metrics.json" > /dev/null; then
        return 0
    else
        return 1
    fi
}


function getResult(){
    param1=$1
    param2=$2
    param3=$3
    echo "$param1"
    echo "Valor2 = $param2"
    echo "Valor3 = $param3"
    
}

function verifyMetric(){

	case $1 in
	
    ENT)
     if isMetricJson; then
        if keys_exist ENT_MAX ENT_MIN; then
            if key_exist ENT_MIN; then
                gM_ENT_MIN=$(echo metrics.json | jq -r ".ENT_MIN")
                echo "$gM_ENT_MIN"
            else
                gM_ENT_MIN=
            fi
            if key_exist ENT_MAX; then
                gM_ENT_MAX=$(echo metrics.json | jq -r ".ENT_MAX")
                echo "$gM_ENT_MAX"                
            else
                gM_ENT_MAX=
            fi
        else
        echo "algo"     
        fi
	 else	 
	 gM_ENT_MIN=0
	 gM_ENT_MAX=10 
	 fi
     getResult $gM_ENT_MAX $gM_ENT_MIN $gM_ENT
     ;;

    INT)

     ;;

    NL)

     ;;

    FLOW)

     ;;
    
    PATH)

     ;;

    LPE)

     ;;

    SPL) 

     ;;
    
    WL)

     ;;
    
    CL)

     ;;

    FPATH)

     ;;
    
    FACT)

     ;;

    TPI)

     ;;
    
    WPTP)
     ;;

    PPTP)
     ;;    

	CPOP)
	 if isMetricJson; then
     if keys_exist CPOP_MAX CPOP_MIN; then
     echo "EXISTEN"
     else
     echo "NO EXISTEN"
     fi
	 gM_CPOP_MIN=10
	 gM_CPOP_MAX=200
	 else	 
	 gM_CPOP_MIN=0
	 gM_CPOP_MAX=10	 
	 fi
	 ;;
	 
	ENT)
	 echo "ENT"
	 ;;
	esac
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
#Test lpee=$(jq -r '.["Global Metrics"].LPE' $METRICS_OUTPUT)
#Test echo "LPE: $lpee | bc" 
#Test lpFloat=$(echo "$lpee" | bc)
#Test echo "Lpfloat: $lpFloat"


echo "GlobalMetrics: $globalMetrics"


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
if isMetricJson; then
    if keys_exist ENT_MAX ENT_MIN; then
    echo " ENT | $gM_ENT | $(verifyMetric ENT) |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist INT_MAX INT_MIN; then
    echo " INT | $gM_INT | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist NL_MAX NL_MIN; then
    echo " NL | $gM_NL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist FLOW_MAX FLOW_MIN; then
    echo " FLOW | $gM_FLOW | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist PATH_MAX PATH_MIN; then
    echo " PATH | $gM_PATH | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist LPE_MAX LPE_MIN; then
    echo " LPE | $gM_LPE | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist SPL_MAX SPL_MIN; then
    echo " SPL | $gM_SPL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist WL_MAX WL_MIN; then
    echo " WL | $gM_WL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist CL_MAX CL_MIN; then
    echo " CL | $gM_CL | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist FPATH_MAX FPATH_MIN; then
    echo " FPATH | $gM_FPATH | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist FACT_MAX FACT_MIN; then
    echo " FACT | $gM_FACT | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist TPI_MAX TPI_MIN; then
    echo " TPI | $gM_TPI | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist WPTP_MAX WPTP_MIN; then
    echo " WPTP | $gM_WPTP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist PPTP_MAX PPTP_MIN; then
    echo " PPTP | $gM_PPTP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
    if keys_exist CPOP_MAX CPOP_MIN; then
    echo " CPOP | $gM_CPOP | ✅ |" >> "${GITHUB_STEP_SUMMARY}"
    fi
else 
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
fi
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
