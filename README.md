<div align = center><img src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/yume/repo/logo.png"><br><br>

&ensp;[<kbd> <br> Screenshots <br> </kbd>](#Screenshots)&ensp;
&ensp;[<kbd> <br> Installation <br> </kbd>](#Installation)&ensp;
&ensp;[<kbd> <br> Dependecies <br> </kbd>](#Dependecies)&ensp;
&ensp;[<kbd> <br> Keybindings <br> </kbd>](#Keybindings)&ensp;
<br><br></div>

## Screenshots

<p align="center">
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/yume/repo/1.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/yume/repo/2.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/yume/repo/3.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/qxb3/gruvbox.hypr/yume/repo/4.png" />
</p>

<br>

## Installation

> [!CAUTION]
> Backup your config files first.

> [!IMPORTANT]
> Please see [Dependecies](#Dependecies)

```bash
git clone --depth=1 --single-branch --branch yume https://github.com/qxb3/gruvbox.hypr
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
  <tr><td>thunar</td><td>another file explorer</td></tr>
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
  <tr><td>neofetch</td><td>beautiful sys info</td></tr></table>
</td></tr></table>

<br>

<table><tr><td>
  <code>e</code><br><code>t</code><br><code>c</code></td><td><table>
  <tr><td>gvfs</td><td>mpris cover art caching</td></tr>
  <tr><td>gnome-bluetooth-3.0</td><td>for bluetooth</td></tr>
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

#### Sidebar

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Tab</kbd> | toggle sidebar
| <kbd>Super</kbd> + <kbd>A</kbd> | toggle app launcher
| <kbd>Super</kbd> + <kbd>C</kbd> | toggle wallpaper select

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
