#NO slashes ( / ) at the end of the string!
startFolder="/media/sam/T7/Windows recovered files"
destinationFolder="/media/sam/T7/Windows sorted files"
#double check file extensions
#should NOT have a period ( . ) at the start
extensions=("png" "jpg" "py" "pyc" "svg" "txt" "mp4" "ogg" "java")

declare -A counters
for extension in "${extensions[@]}"
    do
    mkdir -p "$destinationFolder/$extension"
    counters[$extension]=0
done

folders=$(ls "$startFolder")

arrFolders=()
for folder in $folders;do
    arrFolders+=($folder)
done

folderAmount=${#arrFolders[@]}

echo $folderAmount folders

completed=0

for folder in $folders;do
    completed=$((completed+1))
    percentage=$(((completed*100)/folderAmount))
    files=$(ls "$startFolder/$folder")
    for file in $files;do
        for extension in "${extensions[@]}";do
            if [[ $file == *".$extension"* ]];then
            filePath="$startFolder/$folder/$file"
            number="${counters[$extension]}"
            destPath="$destinationFolder/$extension/$number.$extension"
            echo -n -e "\r\e[0K$completed/$folderAmount $percentage% $filePath -> $destPath"
            mv "$filePath" "$destPath"
            counters[$extension]=$((counters[$extension]+1))
            break
            fi
        done
    done
done

echo
