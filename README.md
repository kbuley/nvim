# Introduction

This is my personal nvim configuration, initially based on [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)

### Install External Dependencies

> **NOTE**
> [Backup](#faq) your previous configuration (if any exists)

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#install-recipes) for additional Windows and Linux specific
> notes and quick install snippets

Neovim's configurations are located under the following paths:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

- What should I do if I already have a pre-existing neovim configuration?
  - You should back it up and then delete all associated files.
  - This includes your existing init.lua and the neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
- Can I keep my existing configuration?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install your own
    configuration in `~/.config/nvim-mycustomconfig` and create an alias:

    ```sh
    alias nvim-mycustomconfig='NVIM_APPNAME="nvim-mycustomconfig" nvim'
    ```

    When you run Neovim using `nvim-mycustomconfig` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-mycustomconfig`. You can apply this approach to any Neovim
    distribution that you would like to try out.

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installing tools and updating the command for `telescope-fzf-native` may be required

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:

```sh
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:

```sh
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```sh
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim
```

</details>

#### Linux Install

<details><summary>Ubuntu Install Steps</summary>

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim
```

</details>
<details><summary>Debian Install Steps</summary>

```sh
sudo apt update
sudo apt install make gcc ripgrep unzip git
echo "deb https://deb.debian.org/debian unstable main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install -t unstable neovim
```

</details>
<details><summary>Fedora Install Steps</summary>

```sh
sudo dnf install -y gcc make git ripgrep fd-find neovim
```

</details>

#### MacOS Install Steps

<details><summary>Homebrew Install Steps</summary>

```sh
brew install gcc make git ripgrep fd-find neovim
```

</details>
