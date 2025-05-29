import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

import "./thingies"

Item {
  id: topBar
  anchors.fill: parent

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
    z: 1

    Left {}
    Center {}
    Right {}
  }

  NotificationCenter {}
  NotificationPopups {}
  Calendar {}
}
