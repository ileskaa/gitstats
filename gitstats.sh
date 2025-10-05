#!/bin/bash

log_commits() {
    if [ "$1" ]; then
        # git shortlog summarizes git log output. Each commit is grouped by author.
        # --summary suppresses commit descriptions and provides a commit count summary instead.
        # --numbered sorts the ouptut according to the number of commits.
        git shortlog -s -n --author="$1"
    else
        git shortlog -s -n
    fi
}

log_stats() {
    git log --author="$1" --pretty=tformat: --numstat | \
    awk -v author="$1" -v commits="$2" 'BEGIN {
        RED = "\033[31m"
        GREEN = "\033[92m"
        RESET = "\033[0m"
    } {
        adds += $1; subs += $2
    } END {
        if (adds || subs) {
            print author
            printf "Commits: %'"'"'d | Lines: ", commits
            printf GREEN
            printf "++%'"'"'d", adds
            printf RESET
            printf "; "
            printf RED
            printf "--%'"'"'d\n", subs
            printf RESET
        }
    }'
}

commits_per_user=$(log_commits "")

line_count=$(echo "$commits_per_user" | wc -l)
current=0
echo "$commits_per_user" | while IFS= read -r line; do
    ((current++)) # double parentheses are used for arithmetic operations
    # -r prevents backslashes from escaping characters
    read -r commits author <<< "$line"
    log_stats "$author" "$commits"
    [ "$current" -lt "$line_count" ] && echo
done