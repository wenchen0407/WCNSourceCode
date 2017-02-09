#! /usr/bin/env bash
# Here we setup the environment
# variables needed by the tinyos 
# make system

#echo "Setting up for TinyOS 2.x"
export TOSROOT=
export TOSDIR=
export MAKERULES=
export Work2012=
export PYTHONPATH

export TOSROOT="$HOME/local/src/tinyos-2.x"
export TOSDIR="$TOSROOT/tos"
export CLASSPATH=$CLASSPATH:$TOSROOT/support/sdk/java/tinyos.jar
export MAKERULES="$TOSROOT/support/make/Makerules"
export PYTHONPATH="$TOSROOT/support/sdk/python"

export MSPGCCROOT="$HOME/local/src/msp430"
export AVRGCCROOT="$HOME/local/src/avr"
export NESCROOT="$HOME/local/src/nesc"
export DEPUTYROOT="$HOME/local/src/deputy"
#export PATH="$TOSROOT-tools/bin:$NESCROOT/bin:$MSPGCCROOT/bin:$AVRGCCROOT/bin:$DEPUTYROOT/bin:$PATH"

export JAVAPATH="$TOSROOT/support/sdk/java/:$JAVAPATH"
export PATH="$HOME/local/src/tinyos-2.x/support/sdk/java:$PATH"

source $TOSROOT/apps/wustl/upma/upma.sh
echo "Sourcing tinyos.sh finsihed successfully."
echo "Setting up for TinyOS 2.x finished successfully"
