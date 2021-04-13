#VARS
DIR_FILE_TO_ANALYZE=$1
SIZE=0

#Validate Input
ValidateInput()
{
	#validate if file or directory is given
	if [ $# -lt 1 ]; then
		echo "[ERROR] file or directory path missing to analyze its size"
		echo "[INFO] Usgae exmaple: $0 /path/of/file/or/directory"
		exit 1
	fi
}

FileSize()
{
	SIZE=($(du -s $DIR_FILE_TO_ANALYZE))
	echo "[INFO] Size of $DIR_FILE_TO_ANALYZE: $SIZE"
}

#File or directory occupied in the file system
FileDiskUtilized()
{
	IFS=' '
	DF_VALS=()
	FILE_SYSTEM_SIZE=$(df $DIR_FILE_TO_ANALYZE)
	
	echo "$FILE_SYSTEM_SIZE" > fsize.txt
	while read line; do 
		#echo $line
		read -r -a DF_VALS <<< "$line"		
	done < fsize.txt
	echo "[INFO] Total File system size of ${DF_VALS[5]}: ${DF_VALS[1]}"
	#echo "$FILE_SYSTEM_SIZE" | sed 's/.*%//' | sed 's/ Mounted on//' | xargs
	echo "[INFO] [$DIR_FILE_TO_ANALYZE] occupied $(( ${SIZE}*100/${DF_VALS[1]} ))% of ${DF_VALS[5]}" 
}

ValidateInput $1
FileSize
FileDiskUtilized