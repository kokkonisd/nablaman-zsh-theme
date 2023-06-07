# vim:ft=zsh
#
# NOTE: https://jsfiddle.net/seport/shrovLgf/

terminator() {
    echo "%F{166}∇%f" 
}

segment() {
    echo -n "%F{$1}◢%f%F{$2}%K{$1}$3%k%f%F{$1}◤%f"
}


base_prompt() {
    # Base symbol
    echo -n "%F{130}∴%f "

    # User & hostname
    segment 238 244 "%n@%m"

    # Path
    segment 208 235 "%B%~%b"
}

return_code() {
    if [[ $? -eq 0 ]]; then
        echo -n "%F{040}⊨%f"
    else
        echo -n "%F{red}⊭%f"
    fi
}

git_prompt() {
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

ZSH_THEME_GIT_PROMPT_UNTRACKED=" ⋄ "
ZSH_THEME_GIT_PROMPT_ADDED=" ⊛ "
ZSH_THEME_GIT_PROMPT_MODIFIED=" ∗ "
ZSH_THEME_GIT_PROMPT_PREFIX="⋔ "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=" "

RPROMPT=' $(return_code)'
PROMPT='$(base_prompt)
$(terminator)$(git_prompt) '
