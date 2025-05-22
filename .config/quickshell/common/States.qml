pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Singleton {
  property QtObject sidebar: QtObject {
    property bool isOpen: true
    property string currentPage: "home"
  }
}
