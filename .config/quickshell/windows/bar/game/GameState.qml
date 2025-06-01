pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Singleton {
  property QtObject player
  property var enemies: []

  player: QtObject {
    property int size: 75

    property int velX: 0
    property int velY: 0

    property string action: "idle"
    property string dir: "right"

    property bool onGround: true

    property int attackTimer: 0
    property bool isAttacking: false

    property int shieldTimer: 83
    property bool isShielding: false

    property int x: 0
    property int y: 0
  }
}
