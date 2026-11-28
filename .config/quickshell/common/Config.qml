pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import Qt.labs.platform

Singleton {
  property var anim: QtObject {
    property int duration: 800
    property int easing: Easing.OutQuint
  }

  property var theme: QtObject {
    property string bg: "#1c1b1d"
    property string fg: "#cccccc"
  }

  property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
}
