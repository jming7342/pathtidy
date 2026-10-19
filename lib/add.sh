do_add() {
    local pos=""
    local new_path=""

    if [[ "$1" =~ ^[0-9]+$ ]]; then
        pos="$1"
        new_path="$2"
    else    
        new_path="$1"
    fi

    if [[ -z "$new_path" ]]; then
        echo "Usage: pathtidy add [位置] <路径>" >&2
        exit 1
    fi

    local input
    input="$(get_input)"
    IFS=':' read -ra paths <<< "$input"
    local count=${#paths[@]}

    local insert_index
    if [[ -z "$pos" ]]; then
        insert_index=$count         
    else
        if [[ "$pos" -lt 1 || "$pos" -gt $((count + 1)) ]]; then
            echo "Err: 位置超出范围(1-$((count + 1)))" >&2
            exit 1
        fi
        insert_index=$((pos - 1))
    fi

    local -a result=()
    local i
    for i in "${!paths[@]}"; do
        if [[ $i -eq $insert_index ]]; then
            result+=("$new_path")
        fi
        result+=("${paths[$i]}")
    done
    if [[ $insert_index -ge $count ]]; then
        result+=("$new_path")          
    fi
    
    local old_ifs="$IFS"
    IFS=':'
    echo "${result[*]}"
    IFS="$old_ifs"
}