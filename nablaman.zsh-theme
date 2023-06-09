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
    if [[ $# != 3 ]]; then
        echo "ERROR: wrong syntax for \`nablaman_segment\` call."
        echo "\texpected \`segment <background color code> <foreground color code> <text>\`."
        exit 1
    fi
    echo -n "%F{$1}◢%f%F{$2}%K{$1}$3%k%f%F{$1}◤%f"
}

# Set up the info segments.
nablaman_info_segments() {
    # Base symbol.
    echo -n "%F{130}∴%f "

    # User & hostname.
    nablaman_segment 238 244 "%n@%m"

    # Path to current directory.
    nablaman_segment 208 235 "%B%~%b"
}

# Set up the return code segment.
nablaman_return_code_segment() {
    if [[ $? -eq 0 ]]; then
        echo -n "%F{040}⊨%f"
    else
        echo -n "%F{red}⊭%f"
    fi
}

# Set up the git segment.
nablaman_git_segment() {
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ⋄ "
    ZSH_THEME_GIT_PROMPT_ADDED=" ⊛ "
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ∗ "
    ZSH_THEME_GIT_PROMPT_PREFIX="⋔ "
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=" "

    local prompt_info git_fg_color git_bg_color

    prompt_info=$(git_prompt_info) 
    prompt_status=$(git_prompt_status)

    if [[ -z $prompt_info ]]; then
        return
    fi

    git_fg_color=252
    git_bg_color=99

    if [[ -n $prompt_status ]]; then
        git_bg_color=94;
    fi

    nablaman_segment $git_bg_color $git_fg_color $prompt_info$prompt_status
}


RPROMPT=' $(nablaman_return_code_segment)'
PROMPT='$(nablaman_info_segments)
$(nablaman_terminator)$(nablaman_git_segment) '
