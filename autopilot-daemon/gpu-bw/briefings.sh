#!/bin/bash
nvidia-smi > error.log
errors="$(grep ERR error.log)"
if [[ -n $errors ]]
then
	echo !! nvidia-smi reports errors. ABORT.
	cat error.log
	exit 1
fi
nvidia-smi --query-gpu=mig.mode.current --format=csv > mig.log
mig="$(grep Enabled mig.log)"
if [[ -n $mig ]]
then
	echo !! MIG enabled. ABORT.
	exit 1
fi
# echo Proceed with main health check