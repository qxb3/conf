import QtQuick
import QtQuick.Effects

Item {
  id: root

  property string iconName: ""
  property color color: "#c1c1c1"
  property int size: 18

  implicitWidth: size
  implicitHeight: size

  Image {
    anchors.fill: parent
    source: Qt.resolvedUrl("../../assets/icons/" + root.iconName + ".svg")
    sourceSize: Qt.size(root.size * 2, root.size * 2)
    smooth: true

    layer.enabled: true
    layer.effect: MultiEffect {
      colorization: 1.0
      colorizationColor: root.color
    }
  }
}
