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
terminator() {
    echo "%F{166}∇%f" 
}

# Display a segment of the prompt given a background and a foreground color.
segment() {
    if [[ $# != 3 ]]; then
        echo "ERROR: wrong syntax for \`segment\` call."
        echo "\texpected \`segment <background color code> <foreground color code> <text>\`."
        exit 1
    fi
    echo -n "%F{$1}◢%f%F{$2}%K{$1}$3%k%f%F{$1}◤%f"
}

# Set up the info segments.
info_segments() {
    # Base symbol.
    echo -n "%F{130}∴%f "

    # User & hostname.
    segment 238 244 "%n@%m"

    # Path to current directory.
    segment 208 235 "%B%~%b"
}

# Set up the return code segment.
return_code_segment() {
    if [[ $? -eq 0 ]]; then
        echo -n "%F{040}⊨%f"
    else
        echo -n "%F{red}⊭%f"
    fi
}

# Set up the git segment.
git_segment() {
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

    if [[ $(parse_git_dirty) == "$ZSH_THEME_GIT_PROMPT_DIRTY" ]]; then
        git_bg_color=94;
    else
        git_bg_color=99;
    fi

    segment $git_bg_color $git_fg_color $prompt_info$prompt_status
}


RPROMPT=' $(return_code_segment)'
PROMPT='$(info_segments)
$(terminator)$(git_segment) '
