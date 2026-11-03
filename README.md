# dotfiles

Personal configs for a Linux (Kali / Debian / Arch) and WSL setup centred on
**zsh**, the **kitty** terminal and a pentesting / CTF workflow. Managed with
[GNU Stow](https://www.gnu.org/software/stow/).

These dotfiles are very opinionated. The install steps don't cover 
all required dependencies. Expect to adapt them to your own machine and use case.

## Layout

Each top-level folder is a Stow package that mirrors the layout of `$HOME`.

| Package    | Links to                         | What it is                                                        |
| ---------- | -------------------------------- | ----------------------------------------------------------------- |
| `zsh`      | `~/.zshenv`, `~/.config/zsh/`    | Shell config (sets `ZDOTDIR=~/.config/zsh`)                       |
| `kitty`    | `~/.config/kitty/`               | Terminal config, themes and kittens                               |
| `format`   | `~/.clang-format`, `~/.shellcheckrc` | Formatter / linter defaults                                   |
| `atuin`    | `~/.config/atuin/config.toml`    | Shell history search                                              |
| `ffuf`     | `~/.config/ffuf/ffufrc`          | ffuf defaults                                                     |

`windows/` isn't stowed: VS Code and Windows Terminal settings, copied over by hand
on the Windows side.

## Install

```bash
git clone https://github.com/ruizii/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

mkdir -p ~/.config/atuin ~/.config/ffuf

# Backup before running this line
rm -f ~/.config/atuin/config.toml ~/.config/ffuf/ffufrc && stow -t ~ kitty zsh format atuin ffuf
```

The `mkdir` matters: when those folders already exist, Stow links only the file inside
instead of linking the whole folder, so ffuf's run history and autocalibration data
stay out of the repo. The `rm` clears the default `config.toml` atuin writes whenever
it runs without one; run it from bash, since zsh's atuin hooks can recreate the file
before `stow` gets to it.

## Uninstall

```bash
stow -t ~ -D kitty zsh format atuin ffuf
```

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
- CLI tools the aliases expect: `eza`, `bat`, `fd`, `ncat`, `xclip` / `wl-clipboard`
- [CaskaydiaCove Nerd Font Mono](https://www.nerdfonts.com/) for kitty
- `seclists` for the wordlist variables, `ffuf`

On Debian/Kali, `fdfind` and `batcat` are wrapped as `fd` and `bat` automatically.

Installed separately:

```bash
# glow and curlie (my fork); .zshrc expects Go binaries in ~/.local/share/go/bin,
# so set GOPATH (or GOBIN) to match first
go install charm.land/glow/v3@latest
go install github.com/ruizii/curlie@latest

# hexyl, into ~/.cargo/bin
cargo install hexyl
```

- `difftastic` – download the binary from the
  [releases page](https://github.com/Wilfred/difftastic/releases) and put `difft` somewhere in path.

All of these folders are already on `PATH` in `.zshrc`.

## zsh

`.zshrc` holds options, completion styles and keybindings; the rest lives in
`config.d/`:

| File               | Purpose                                                                 |
| ------------------ | ----------------------------------------------------------------------- |
| `aliases.zsh`      | Aliases; `copy` picks the right clipboard tool for WSL, X11 or Wayland  |
| `autosuggest.zsh`  | Fish-style autosuggestions: only suggests history whose commands and path arguments still exist |
| `highlights.zsh`   | fast-syntax-highlighting colours                                        |
| `htb.zsh`          | `settarget` / `cleartarget` for the current box, synced across tabs and shown in the prompt |

Other things worth knowing:

- **Small helpers in `.zshrc`** – plugin paths for Arch and Debian, `fd` / `bat`
  wrappers where Debian names them `fdfind` / `batcat`, `history` listing every
  entry with timestamps, and coloured man pages.
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

## ffuf

- 60 threads, colours and verbose output on, wordlist comments skipped
- Browser-like `User-Agent`, `Accept`, `Accept-Language` and `Accept-Encoding` headers on every request

## Formatting

- `.clang-format` – 4-space indent, no column limit
- `.shellcheckrc` – disables SC2181 (checking `$?` directly)
