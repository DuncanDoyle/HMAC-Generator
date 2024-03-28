#!/bin/sh

##############################################################################################################################
#
# Simple shell script that calculates HMAC for a given input string, algorithm and secret
#
# author: Duncan Doyle (https://github.com/DuncanDoyle)
#
##############################################################################################################################


function usage {
      echo "Usage: hmac-generator.sh [args...] INPUT"
      echo "where args include:"
      echo "  -a    Algorithm to be used, e.g. sha256, sha1, etc."
      echo "  -s    Secret used by openssl to calculate the HMAC for the give input string."
      echo "  -h    Print this help."
}

#Parse the params
while getopts ":a:s:h" opt; do
  case $opt in
    a)
      HMAC_ALGORITHM=$OPTARG
      ;;
    s)
      HMAC_SECRET=$OPTARG
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Remove all processed parameters so we can parse the input string.
shift $((OPTIND - 1))

HMAC_INPUT=$1

PARAMS_NOT_OK=false

#Check params

if [ -z "$HMAC_ALGORITHM" ] 
then
	echo "No algorithm specified!\n"
	PARAMS_NOT_OK=true
fi

if [ -z "$HMAC_SECRET" ] 
then
	echo "No secret specified!\n"
	PARAMS_NOT_OK=true
fi

if [ -z "$HMAC_INPUT" ]
then
	echo "No input message found!\n"
	PARAMS_NOT_OK=true
fi

if $PARAMS_NOT_OK
then
	usage
	exit 1
fi

printf "\nGenerate the HMAC and Bas64 HMAC of the input message:\n\n$HMAC_INPUT\n"

export HMAC=$(printf "$HMAC_INPUT" | openssl $HMAC_ALGORITHM -hmac $HMAC_SECRET | cut -c16- | xxd -r -p | base64)

printf "\nHMAC Base64: $HMAC\n"

