# dotfiles

Personal configs for a Linux (Kali / Debian / Arch) and WSL setup centred on
**zsh**, the **kitty** terminal and a pentesting / CTF workflow. Managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level folder is a Stow package that mirrors the layout of `$HOME`.

| Package    | Links to                         | What it is                                                        |
| ---------- | -------------------------------- | ----------------------------------------------------------------- |
| `zsh`      | `~/.zshenv`, `~/.config/zsh/`    | Shell config (sets `ZDOTDIR=~/.config/zsh`)                       |
| `kitty`    | `~/.config/kitty/`               | Terminal config, themes and kittens                               |
| `format`   | `~/.clang-format`, `~/.shellcheckrc` | Formatter / linter defaults                                   |
| `starship` | `~/.config/starship.toml`        | Alternative prompt (not installed by default)                     |
| `ideavim`  | `~/.ideavimrc`                   | Vim bindings for JetBrains IDEs (not installed by default)        |

Not stowed:

- `atuin/` – copied into `~/.config/atuin/` (see below).
- `windows/` – VS Code and Windows Terminal settings, copied over by hand on the Windows side.

## Install

```bash
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles

# Install
stow -t ~ kitty zsh format

# Uninstall
stow -t ~ -D kitty zsh format
```

```bash
# Copy Atuin config into ~/.config/atuin/
mkdir -p ~/.config/atuin && cp atuin/config.toml ~/.config/atuin/
```

Add `starship` or `ideavim` to the list if you want them too.

### Dependencies

Plugins cloned into `~/Code/repos/`:

```bash
mkdir -p ~/Code/repos && cd ~/Code/repos
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git
git clone https://github.com/ruizii/zsh-completions.git
```

From the package manager:

- `zsh`, `zsh-autosuggestions`, `stow`, `kitty`, `atuin`
- CLI tools the aliases expect: `eza`, `bat`, `fd`, `difftastic`, `curlie`, `hexyl`, `glow`, `ncat`, `xclip` / `wl-clipboard`
- [CaskaydiaCove Nerd Font Mono](https://www.nerdfonts.com/) for kitty
- `seclists` for the wordlist variables

On Debian/Kali, `fdfind` and `batcat` are wrapped as `fd` and `bat` automatically.

## zsh

`.zshrc` holds options, completion styles and keybindings; the rest lives in
`config.d/`:

| File               | Purpose                                                                 |
| ------------------ | ----------------------------------------------------------------------- |
| `aliases.zsh`      | Aliases; `copy` picks the right clipboard tool for WSL, X11 or Wayland  |
| `arch-debian.zsh`  | Distro-specific plugin paths and `fd` / `bat` wrappers                  |
| `autosuggest.zsh`  | Fish-style autosuggestions: only suggests history whose commands and path arguments still exist |
| `highlights.zsh`   | fast-syntax-highlighting colours                                        |
| `history.zsh`      | `history` shows timestamps                                              |
| `htb.zsh`          | `settarget` / `cleartarget` for the current box, synced across tabs and shown in the prompt |
| `man.zsh`          | Coloured man pages                                                      |

Other things worth knowing:

- **Completion** – menu select, fish-style `(description)` formatting, a menu
  capped at 30 lines, and `compinit` only does a full rebuild when a completion
  folder changes. `.zlogin` compiles the dump in the background.
- **History** – 20k entries, shared across sessions, searched with atuin (up
  arrow left as normal zsh history).
- **Wordlists** – `$DIRS`, `$SUBDOMAINS`, `$ROCKYOU`, `$PARAMETERS` and friends
  point into SecLists.
- **WSL / Windows Terminal** – sets `$BROWSER` to Windows Firefox and reports
  the working directory so new tabs open in the same place.
- **Local overrides** – `~/.env` and `~/.local_alias` are sourced if they exist,
  for secrets and machine-specific aliases that stay out of the repo.

Prompt: Powerlevel10k, configured in `.config/zsh/.p10k.zsh` (`p10k configure`
to regenerate).

## kitty

- Splits layout: `ctrl+shift+e` vertical split, `ctrl+shift+d` horizontal split
- `ctrl+h/j/k/l` move between splits, `alt+h/j/k/l` resize them (`relative_resize.py`)
- `ctrl+tab` / `ctrl+shift+tab` cycle tabs, `ctrl+shift+t` new tab in the same directory
- Themes in `themes/`; the active one is `current-theme.conf` (`asdf-kali` by default)

## Formatting

- `.clang-format` – 4-space indent, no column limit
- `.shellcheckrc` – disables SC2181 (checking `$?` directly)
