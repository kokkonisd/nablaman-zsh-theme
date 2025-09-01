# vim:ft=zsh
#
#                 __       ___
#                /\ \     /\_ \
#   ___      __  \ \ \____\//\ \      __      ___ ___      __      ___
# /' _ `\  /'__`\ \ \ '__`\ \ \ \   /'__`\  /' __` __`\  /'__`\  /' _ `\
# /\ \/\ \/\ \L\.\_\ \ \L\ \ \_\ \_/\ \L\.\_/\ \/\ \/\ \/\ \L\.\_/\ \/\ \
# \ \_\ \_\ \__/.\_\\ \_,__/ /\____\ \__/.\_\ \_\ \_\ \_\ \__/.\_\ \_\ \_\
#  \/_/\/_/\/__/\/_/ \/___/  \/____/\/__/\/_/\/_/\/_/\/_/\/__/\/_/\/_/\/_/
#
# nablaman - a terminal theme for ZSH.
# https://github.com/kokkonisd/nablaman-zsh-theme
# It is recommended that you use Monokai dark as a color profile (or similar).

# Display the "terminator" (i.e. `$`-equivalent).
nablaman_terminator() {
    echo "%F{166}∇%f"
}

# Display a segment of the prompt given a background and a foreground color.
nablaman_segment() {
    local bottom_right_triangle top_left_triangle
    bottom_right_triangle="\uE0BA"
    top_left_triangle="\uE0BC"

    if [[ $# != 3 ]]; then
        echo "ERROR: incorrect args to \`nablaman_segment(bg_color, fg_color, text)\`." 1>&2
        exit 1
    fi
    echo -n "%F{$1}$bottom_right_triangle%f%F{$2}%K{$1}$3%k%f%F{$1}$top_left_triangle%f"
}

# Set up the hostname segment of the prompt.
nablaman_hostname_segment() {
    # User & hostname.
    nablaman_segment 238 244 "%n@%m"
}

# Set up the info segments.
nablaman_info_segments() {
    # Base symbol.
    echo -n "%F{130}∴%f "

    nablaman_hostname_segment

    # Path to current directory.
    nablaman_segment 208 235 "%B%~%b"
}

# Set up the return code segment.
nablaman_return_code_segment() {
    if [[ $? -eq 0 ]]; then
        echo -n "%F{040}⊤%f"
    else
        echo -n "%F{red}⊥%f"
    fi
}

# Set up the git segment.
nablaman_git_segment() {
    local empty_tree fg_color bg_color branch staged_changes unstaged_changes untracked_changes \
        segment dirty

    empty_tree="4b825dc642cb6eb9a060e54bf8d69288fbee4904"
    fg_color=252
    bg_color=99

    if ! git status &>/dev/null
    then
        return
    fi

    branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)"
    staged_changes="$( \
            git diff-index --cached HEAD -- 2>/dev/null \
            || git diff-index --cached "$empty_tree" -- \
    )"
    unstaged_changes="$(git diff-files)"
    untracked_changes="$(git ls-files --exclude-standard --others)"
    other_changes="$(git status --porcelain)"


    segment="⋔ $branch"
    dirty=0

    if [[ -n $untracked_changes ]]
    then
        segment+=" ⋄"
        dirty=1
    fi

    if [[ -n $unstaged_changes ]]
    then
        segment+=" ∗"
        dirty=1
    fi

    if [[ -n $staged_changes ]]
    then
        segment+=" ⊛"
        dirty=1
    fi

    if [[ (dirty -eq 0) && (-n $other_changes) ]]
    then
        dirty=1
    fi

    if [[ dirty -eq 1 ]]
    then
        bg_color=94
    fi

    nablaman_segment "$bg_color" "$fg_color" "$segment "
}


RPROMPT=' $(nablaman_return_code_segment)'
PROMPT='$(nablaman_info_segments)
$(nablaman_terminator)$(nablaman_git_segment) '
