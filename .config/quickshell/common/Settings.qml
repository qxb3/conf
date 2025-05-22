pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Singleton {
  property QtObject colors: QtObject {
    property string fg: "#FFFFFF"
    property string bg: "#000000"
    property string bgHard: "#000000"
    property string bgSoft: "#121212"
    property string bgSofter: "#1c1c1c"
    property string primary: "#8C7F70"
    property string secondary: "#5A8080"
    property string tertiary: "#444444"
  }

  property QtObject animation: QtObject {
    property int speed: 500
    property int easing: Easing.InOutQuint
  }

  property QtObject rounding: QtObject {
    property int general: 8
    property int full: 999
    property int bar: 32
    property int workspace: 16
  }

  property QtObject font: QtObject {
    property string family: "ShureTechMono Nerd Font"
    property int size: 18
  }
}
