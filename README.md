# iOS Development Neovim Configuration

## Introduction

A comprehensive Neovim configuration for iOS and macOS development that provides:

* **Intelligent code completion** with sourcekit-lsp and xcode-build-server
* **Integrated build/run/test** functionality via xcodebuild.nvim
* **Full debugging support** with lldb integration
* **Code formatting and linting** with SwiftFormat and SwiftLint
* **90%+ Xcode replacement** for daily iOS development

Based on kickstart.nvim with specialized iOS development plugins and configurations.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

#### Basic Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

#### iOS Development Requirements:
- **Xcode** (for iOS SDK, simulators, and sourcekit-lsp)
- **Homebrew** (for installing development tools)

#### Install iOS Development Tools:
```bash
# Install core iOS development tools
brew install xcode-build-server swiftlint swiftformat xcbeautify

# Create tools directory and download codelldb debugger
mkdir -p ~/tools
cd ~/tools
curl -L https://github.com/vadimcn/codelldb/releases/download/v1.11.5/codelldb-darwin-arm64.vsix -o codelldb.vsix
unzip -q codelldb.vsix
```

#### Tool Descriptions:
- **xcode-build-server**: Bridges sourcekit-lsp with Xcode projects for intelligent completion
- **SwiftLint**: Swift code linting and style checking
- **SwiftFormat**: Automatic Swift code formatting
- **xcbeautify**: Pretty formatting for xcodebuild output
- **codelldb**: Debug adapter for Swift/iOS debugging

## Project Setup

### For New iOS Projects

1. **Navigate to your iOS project directory**
2. **Configure xcode-build-server** (run once per project):
   ```bash
   # For workspace projects:
   xcode-build-server config -scheme <YOUR_SCHEME> -workspace *.xcworkspace
   
   # For single project files:
   xcode-build-server config -scheme <YOUR_SCHEME> -project *.xcodeproj
   ```
3. **Open Neovim in the project root**:
   ```bash
   nvim .
   ```

### Verify Setup

1. Open any Swift file in your project
2. Run `:LspInfo` to verify sourcekit-lsp is attached
3. Try code completion with `<C-Space>`
4. Run `:XcodebuildPicker` to configure build settings

## Key Features

### Code Intelligence
- **Smart completion** with iOS/macOS SDK awareness
- **Go to definition/declaration** (`gd`, `gD`)
- **Find references** (`gr`)
- **Symbol search** via Telescope
- **Hover documentation** (`K`)
- **Code actions** (`<leader>ca`)
- **Smart rename** (`<leader>rn`)

### Build & Test Integration

> **First Time Setup**: Before using build commands, run `:XcodebuildSetup` or press `<leader>X` to configure your project settings.

- **Build project**: `<leader>xb`
- **Build & run**: `<leader>xr`
- **Run tests**: `<leader>xt`
- **Run test class**: `<leader>xT`
- **Select device/simulator**: `<leader>xd`
- **Toggle logs**: `<leader>xl`
- **All actions**: `<leader>X`

### Debugging
- **Build & debug**: `<leader>dd`
- **Debug without build**: `<leader>dr`
- **Debug tests**: `<leader>dt`
- **Toggle breakpoint**: `<leader>b`
- **Step over**: `<F2>`
- **Step into**: `<F1>`
- **Continue**: `<F5>`

### Code Quality
- **Format code**: `<leader>mp` (auto-format on save)
- **Lint file**: `<leader>ml` (auto-lint on change)
- **Code coverage**: `<leader>xc` (toggle), `<leader>xC` (report)

## Troubleshooting

### LSP Not Working
1. Ensure you're in the project root directory
2. Check `:LspInfo` for sourcekit-lsp status
3. Rebuild project in Xcode once
4. Re-run `xcode-build-server config` command
5. Restart Neovim

### Build/Run Issues
1. Ensure Xcode project builds successfully first
2. Check simulator availability with `xcrun simctl list`
3. Use `:XcodebuildPicker` to reconfigure settings
4. Check logs with `:XcodebuildToggleLogs`

### Debugging Issues
1. Verify codelldb path: `~/tools/extension/adapter/codelldb`
2. Ensure app builds and runs normally first
3. Check that scheme supports debugging
4. Try `:XcodebuildSelectDevice` to change target

## Recommended Workflow

1. **Start**: Open project root in Neovim
2. **Initial Setup**: Run `:XcodebuildSetup` or press `<leader>X` (Space + Shift + X) to configure project
3. **Configure**: Use `:XcodebuildPicker` or `<leader>X` to set scheme/device as needed
4. **Code**: Use LSP features for intelligent editing
5. **Test**: Use `<leader>xt` for quick test runs
6. **Debug**: Use `<leader>dd` for debugging sessions
7. **Build**: Use `<leader>xr` for build & run cycles

## Project Structure Recommendations

For best results, consider using:
- **XcodeGen** or **Tuist** instead of .xcodeproj files
- **SwiftLint** configuration file (`.swiftlint.yml`)
- **SwiftFormat** configuration file (`.swiftformat`)

This setup provides 90%+ of Xcode functionality within Neovim!

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

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
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

