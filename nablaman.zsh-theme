# NOTE: https://jsfiddle.net/seport/shrovLgf/
# NOTE: make sure to match every %{F,K} with an %{f,k} otherwise it gets slow
# TODO: git (next to the nabla)
# TODO: command succeed/fail (on the far end of the top line, maybe with retcode?)

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

PROMPT='$(base_prompt)
$(terminator) '
