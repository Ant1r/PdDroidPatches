#!/bin/bash

exportDirectory=$PWD/export2

mkdir -p $exportDirectory

function zipPatch() {
	local patchName=$(basename $1)
	local parentDir=$(dirname $1)
	#mkdir -p "$exportDirectory/$parentDir"
		cd $parentDir
		echo zip -r --filesync "$exportDirectory/$patchName.pdz" "$patchName"
		zip -r --filesync "$exportDirectory/$patchName.pdz" "$patchName"
		cd -
}

function parseDir() {
	echo parseDir $1
	if [ -e ${1}droidparty_main.pd ] ; then
		zipPatch $1;
	else
		for dir in $(ls -d ${1}*/) ; do
			parseDir $dir
		done
	fi
}

parseDir work/
