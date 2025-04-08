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

# corner cases
# - empty input 
# - 


if [[ "$train_file" == "" || "$val_file" == "" || "$input" == "" ]]; then
    echo "ERROR: input, train, val files have to be specified" 
    echo "use --input , --val_file, --train_file for this"
    exit 2
fi

if [ ! -f "$input" ]; then
    echo "Input file not found"
    exit 3
fi

truncate -s 0 $train_file
truncate -s 0 $val_file

lines=$(wc -l $input | awk '{ print $1 }')

if [[ $lines -lt 2 ]]; then 
    echo "Input CSV file is empty"
    exit 4
fi

train_part=$(( lines * train_ratio / 100 ))

iter=0
header=""

while IFS= read -r line; do
    if [[ iter -eq 0 ]]; then 
        header=$line
        ((iter+=1)) 
        continue
    fi 
    if [[ iter -le train_part ]]; then
        echo $line >> train.csv  
    else 
        echo $line >> val.csv 
    fi
    ((iter+=1))
done < Titanic-Dataset.csv


if $shuffle ; then 
    shuf -o val.csv < val.csv
    shuf -o train.csv < train.csv
fi 

# macos
# sed -i '' "1i\\
# ${header}
# " val.csv

# sed -i '' "1i\\
# ${header}
# " train.csv

# linuh 
sed -i "1i\\$header\\" train.csv
sed -i "1i\\$header\\" val.csv
