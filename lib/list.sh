do_list() {
    local input
    input="$(get_input)"

    IFS=':' read -ra paths <<< "$input"
    declare -A seen

    for i in "${!paths[@]}"; do
        local mark=""
        local p="${paths[$i]}"
        if [[ -z "${seen["$p"]:-}" ]]; then
            seen["$p"]=$((i+1))
        else
            mark=" (Duplicate with No.${seen["$p"]})"
        fi
        printf '%2d %s%s\n' "$((i+1))" "$p" "$mark"
    done
}
