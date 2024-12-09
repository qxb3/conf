<div align = center><img src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/logo.png"><br><br>

&ensp;[<kbd> <br> Screenshots <br> </kbd>](#Screenshots)&ensp;
&ensp;[<kbd> <br> Installation <br> </kbd>](#Installation)&ensp;
&ensp;[<kbd> <br> Dependecies <br> </kbd>](#Dependecies)&ensp;
&ensp;[<kbd> <br> Keybindings <br> </kbd>](#Keybindings)&ensp;
&ensp;[<kbd> <br> Commands <br> </kbd>](#Command-Mode-Commands)&ensp;
<!-- &ensp;[<kbd> <br> Issues <br> </kbd>](#Issues)&ensp; -->
<br><br></div>

## Screenshots

<p align="center">
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/1.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/2.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/3.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/4.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/vim_styled/repo/5.png" />
</p>

<br>

## Installation

> [!CAUTION]
> Backup your config files first.

> [!IMPORTANT]
> Please see [Dependecies](#Dependecies)

```bash
git clone --depth=1 --single-branch --branch vim_styled https://github.com/qxb3/gruvbox.hypr
cd gruvbox.hypr
cp -r font/* ~/.local/share/fonts
cp -r .config/* ~/.config
cp -r .scripts ~/ # Optional
# Restart your pc
```

<br>

## Dependecies

<table><tr><td>
  <code>a</code><br><code>p</code><br><code>p</code><br><code>s</code><br></td><td><table>
  <tr><td>kitty</td><td>terminal emulator</td></tr>
  <tr><td>dolphin</td><td>file explorer</td></tr>
  <tr><td>spotify</td><td>music player</td></tr>
  <tr><td>grimblast</td><td>screenshot tool</td></tr>
  <tr><td>swappy</td><td>screenshot editor & image viewer</td></tr>
  <tr><td>firefox</td><td>browser</td></tr></table>
</td></tr></table>

<br>

<table><tr><td>
  <code>r</code><br><code>i</code><br><code>c</code><br><code>e</code><br></td><td><table>
  <tr><td>swww</td><td>wallpaper daemon</td></tr>
  <tr><td>swaylock</td><td>screen locker</td></tr>
  <tr><td>ags</td><td>aylur's gtk widget</td></tr></table>
</td></tr></table>

<br>

<table><tr><td>
  <code>s</code><br><code>h</code><br><code>e</code><br><code>l</code><br><code>l</code></td><td><table>
  <tr><td>zsh</td><td>main shell</td></tr>
  <tr><td>neovim</td><td>text editor</td></tr>
  <tr><td>neofetch</td><td>beautiful sys info</td></tr>
  <tr><td>cava</td><td>music visualizer</td></tr>
  <tr><td>brightnessctl</td><td>control brightness</td></tr></table>
</td></tr></table>

<br>

<table><tr><td>
  <code>e</code><br><code>t</code><br><code>c</code></td><td><table>
  <tr><td>gvfs</td><td>mpris cover art caching</td></tr>
  <tr><td>pipwire-pulse</td><td>audio</td></tr>
  <tr><td>NetworkManager</td><td>manages network</td></tr></table>
</td></tr></table>

<br>

## Keybindings

#### Window Mangement

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Q</kbd> | quit active/focused window
| <kbd>Alt</kbd> + <kbd>F4</kbd> | kill window using cursor
| <kbd>Super</kbd> + <kbd>W</kbd> | toggle window on focus to float
| <kbd>Alt</kbd> + <kbd>Enter</kbd> | toggle window on focus to fullscreen
| <kbd>Super</kbd> + <kbd>RightClick</kbd> | resize the window
| <kbd>Super</kbd> + <kbd>LeftClick</kbd> | change the window position
| <kbd>Alt</kbd> + <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd>| switch the focus around active windows
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd>| move/switch windows around active workspace
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd><kbd>→</kbd><kbd>↑</kbd><kbd>↓</kbd>| resize windows (hold)
| <kbd>Super</kbd> + <kbd>J</kbd> | toggle dwindle

#### Application Shortcuts

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>T</kbd> | launch kitty terminal
| <kbd>Super</kbd> + <kbd>E</kbd> | launch dolphin file explorer
| <kbd>Super</kbd> + <kbd>F</kbd> | launch firefox
| <kbd>Super</kbd> + <kbd>D</kbd> | launch vencord (replace it with normal discord if u want)

#### Widgets

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Tab</kbd> | toggle sidebar
| <kbd>Super</kbd> + <kbd>A</kbd> | toggle app launcher mode
| <kbd>Super</kbd> + <kbd>C</kbd> | toggle command launcher mode

#### Print Screen

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>P</kbd> | drag to select area or click on a window to print
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd> | print current screen
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>P</kbd> | print current screen (frozen)

#### Workspaces

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>MouseScroll</kbd> | cycle through workspaces
| <kbd>Super</kbd> + <kbd>[0-5]</kbd> | switch to workspace [0-5]
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>[0-5]</kbd> | move active window to workspace [0-5]
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>[0-5]</kbd> | move active window to workspace [0-5] (silently)

#### Special Workspace

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | move window to special workspace
| <kbd>Super</kbd> + <kbd>S</kbd> | toogle to special workspace

#### Others
| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>L</kbd> | lock screen

<br>

## Command Mode Commands
| Command | Description |
| :--  | :-- |
| <kbd>shutdown</kbd>| shudown pc
| <kbd>restart</kbd>| restart pc
| <kbd>suspend</kbd>| suspend & lock pc
| <kbd>logout</kbd>| logout out hyprland session
| <kbd>notif-clear</kbd>| clear notifications
| <kbd>change-wallpaper</kbd>| open wallpapers menu

<!-- ## Issues -->
<!-- * This is built for a laptop with a resolution of 1366x768 so the widgets/wallpaper or the overall look might be messed up for you. -->
<!-- * I have only one monitor (which is from the laptop) so multiple monitor support is not really in mind, so you might need to tweak the config for it to work properly. -->
<!-- * The AppLauncher widget has a problem with focus where if your cursor is inside of it and you close the AppLauncher the focus will not be transferred back to the active window. Solutions: Move the cursor or Move the cursor outside the AppLauncher when you open it. (idk why this is happening but i think its a gtk problem) -->
<!-- * Not really a problem but if you want to support multiple music players and not just spotify change the `PLAYER` variable in `config/eww/sidebar/scripts/music.sh`. -->
<!---->
<!-- <br> -->
