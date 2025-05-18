#! /bin/bash


input=""
train_ratio=50
shuffle=false
train_file=""
val_file=""


while [[ "$#" -gt 0 ]];do 
    case "$1"
    in 
        --input)
            input=$2
            shift 2
            ;;
        --train_ratio)
            train_ratio=$2
            shift 2
            ;;
        --shuffle)
            shuffle=true
            shift 1
            ;;
        --train_file)
            train_file=$2 
            shift 2
            ;;
        --val_file)
            val_file=$2
            shift 2
            ;;
        *)
            echo "$1 is not a recognized flag!"
            exit 1
    esac 

done 



if [[ "$train_file" == "" || "$val_file" == "" || "$input" == "" ]]; then
    echo "ERROR: input, train, val files have to be specified" 
    echo "use --input , --val_file, --train_file for this"
    exit 2
fi

if [ ! -f "$input" ]; then
    echo "Input file not found"
    exit 3
fi

header=$(head -n 1 "$input")
data=$(tail -n +2 "$input")

if [ -z "$data" ]; then 
    echo "Input CSV file is empty"
    exit 4
fi

if $shuffle; then
    data=$(echo "$data" | shuf)
fi

total_lines=$(echo "$data" | wc -l)
train_part=$((total_lines * train_ratio / 100))

echo "$header" > "$train_file"
echo "$data" | head -n "$train_part" >> "$train_file"

echo "$header" > "$val_file"
echo "$data" | tail -n +"$((train_part + 1))" >> "$val_file"