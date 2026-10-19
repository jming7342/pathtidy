get_input() {
    if [[ -t 0 ]]; then
        printf '%s' "$PATH"
    else
        cat
    fi 
}