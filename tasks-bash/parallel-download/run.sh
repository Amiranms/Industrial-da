#! /bin/bash


num_workers=""
input_file=""
links_index=""
output_folder=""



while [[ "$#" -gt 0 ]];do 
    case $1 in 
        --num_workers)
            num_workers=$2
            shift 2
            ;;
        --input_file)
            input_file=$2
            shift 2
            ;;
        --links_index)
            links_index=$2
            shift 2
            ;;
        --output_folder)
            output_folder=$2
            shift 2
            ;;
    esac 
done 


if [[ -z "$num_workers" || -z "$input_file" || -z "$links_index" || -z "$output_folder" ]]; then
    echo "All parameters are required."
    exit 1
fi

mkdir -p $output_folder

workers=$num_workers

download_link() {
    local link="$1"
    local file_name 
    file_name=$(basename "$link")
    if [ -z $file_name ]; then
        file_name=$(date +%s%N)
    fi 

    if [[ ${#file_name} -gt 100 ]]; then 
        file_name=${file_name:0:99}
    fi

    wget -q --timeout=10 -O "$output_folder/$file_name" "$link"
}



tail -n +2 "$input_file" | awk -F ';' -v col="$links_index" '{print $col}' | while read -r link; do
    if [[ workers -eq 0 ]]; then 
        continue 
    fi 

    download_link "$link" &

    ((active_jobs++))

    if [[ "$active_jobs" -ge "$num_workers" ]]; then
        wait
        ((active_jobs--))
    fi
done 


wait 



