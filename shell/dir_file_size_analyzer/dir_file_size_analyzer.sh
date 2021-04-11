#VARS
DIR_FILE_TO_ANALYZE=$1


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
	SIZE=($(du -sh $DIR_FILE_TO_ANALYZE))
	echo "[INFO] Size of $DIR_FILE_TO_ANALYZE: $SIZE"
}

FileDiskUtilized()
{
	FILE_SYSTEM_SIZE=$(df -h $DIR_FILE_TO_ANALYZE)
	echo "[INFO] File system size of [$DIR_FILE_TO_ANALYZE]:"
	echo "$FILE_SYSTEM_SIZE"
}

ValidateInput $1
FileSize
FileDiskUtilized