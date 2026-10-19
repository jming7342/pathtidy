do_rm() {
    local input
    input="$(get_input)"

    IFS=':' read -ra paths <<< "$input"
    local count="${#paths[@]}"

    if [[ $# -eq 0 ]]; then
        echo "Usage: pathtidy rm <num>" >&2
        exit 1
    fi

    declare -A to_delete
    for num in "$@"; do
        if [[ ! "$num" =~ ^[0-9]+$ ]]; then
            echo "Err: 编号必须是数字" >&2
            exit 1
        fi    
        
        if [[ "$num" -lt 1 || "$num" -gt "$count" ]]; then
            echo "Err: 编号超出范围(1-${count})" >&2
            exit 1
        fi

        to_delete["$num"]=1
    done
    
    local -a result=()
    for i in "${!paths[@]}"; do
        if [[ -z "${to_delete[$((i+1))]:-}" ]]; then
            result+=("${paths[$i]}")
        fi
    done

    local old_ifs="$IFS"
    IFS=':'
    echo "${result[*]}"
    IFS="$old_ifs"
}