do_dedup() {
    local input
    input="$(get_input)" 
    IFS=':' read -ra paths <<< "$input"
    
    declare -A seen
    declare -a result=()

    for p in "${paths[@]}"; do
        if [[ -z "${seen["$p"]:-}" ]]; then
            seen["$p"]=1
            result+=("$p")
        fi    
    done

    local old_ifs="$IFS"
    IFS=':'
    echo "${result[*]}"
    IFS="$old_ifs"
}