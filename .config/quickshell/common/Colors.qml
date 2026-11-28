pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  // Base16 Black Metal (Gorgoroth), from ~/.config/kitty/theme.conf
  readonly property string bg: "#000000"
  readonly property string surface: "#121212"
  readonly property string surface2: "#222222"
  readonly property string border: "#333333"
  readonly property string muted: "#444444"
  readonly property string dim: "#888888"
  readonly property string fg: "#c1c1c1"
  readonly property string primary: "#9b8d7f"
  readonly property string secondary: "#8c7f70"
  readonly property string accent: "#5f8787"
  // Kitty theme has no red, so this is a muted stand-in. Change the hex to taste.
  readonly property string red: "#a04a4a"
}
