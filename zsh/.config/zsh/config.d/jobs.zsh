fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

bg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin bg %-
    else
        builtin bg %"$@"
    fi
}