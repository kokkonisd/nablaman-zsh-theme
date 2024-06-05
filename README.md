# nablaman

A prompt theme for ZSH (to be used with Oh My Zsh).

![A screenshot of the nablaman theme.](screenshot.png)


## installation

Assuming you have [Oh My Zsh](https://ohmyz.sh/) installed, you can run the following
command to install this theme:

```sh
sh -c "$(curl -o $ZSH_CUSTOM/themes/nablaman.zsh-theme https://raw.githubusercontent.com/kokkonisd/nablaman-zsh-theme/main/nablaman.zsh-theme)"
```

You can then set the profile in your `.zshrc` file:

```sh
ZSH_THEME="nablaman"
```

It is **heavily recommended** to use Mono LGS Nerd Font, otherwise certain symbols might not work.
It is recommended that you use Monokai dark or a similar terminal profile.


## hiding/disabling username & hostname

If you wish to hide the username & hostname info from the prompt, you can add this line
in your `.zshrc`:

```sh
nablaman_hostname_segment(){}
```
