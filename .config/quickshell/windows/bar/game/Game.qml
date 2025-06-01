import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick

import "root:/common"
import "root:/common/widgets"

import "./logic.js" as GameLogic

Rectangle {
  id: world
  implicitWidth: parent.width
  implicitHeight: 120
  color: "transparent"
  y: GlobalState.isGaming ? 0 : -world.height

  Behavior on y {
    NumberAnimation {
      duration: 500
      easing.type: Easing.OutQuart
    }
  }

  GlobalShortcut {
    name: "playerLeft"
    onPressed: GameLogic.playerLeft(GameState)
    onReleased: GameLogic.playerIdle(GameState)
  }

  GlobalShortcut {
    name: "playerRight"
    onPressed: GameLogic.playerRight(GameState)
    onReleased: GameLogic.playerIdle(GameState)
  }

  GlobalShortcut {
    name: "playerJump"
    onPressed: GameLogic.playerJump(GameState)
  }

  IpcHandler {
    target: "game"

    function attack(): void {
      GameLogic.playerAttack(GameState)
    }

    function shield(): void {
      GameLogic.playerShield(GameState)
    }

    function unShield(): void {
      GameLogic.playerUnShield(GameState)
    }
  }

  Rectangle {
    x: GameState.player.x
    y: world.height - GameState.player.size - GameState.player.y
    implicitWidth: GameState.player.size
    implicitHeight: GameState.player.size
    color: "transparent"
    clip: true

    AnimatedImage {
      anchors.fill: parent
      speed: {
        if (GameState.player.action == "attack") return 3

        return 1
      }
      source: {
        let path = `file:///${Quickshell.shellRoot}/assets/`

        if (GameState.player.action == "attack") path += "playerAttack.gif"
        if (GameState.player.action == "shield") path += "playerShield.gif"
        if (GameState.player.action == "idle") path += "playerIdle.gif"
        if (GameState.player.action == "run") path += "playerRun.gif"
        if (GameState.player.action == "jump") path += "playerJump.gif"
        if (GameState.player.action == "fall") path += "playerFall.gif"

        return path
      }
      transform: Scale {
        xScale: GameState.player.dir == "left" ? -1 : 1
        origin.x: GameState.player.size / 2
      }
    }
  }

  // Repeater {
  //   model: ScriptModel {
  //     values: GameState.enemies
  //   }
  //
  //   Rectangle {
  //     required property var modelData
  //
  //     x: modelData.x
  //     y: world.height - modelData.size - modelData.y
  //     implicitWidth: modelData.size
  //     implicitHeight: modelData.size
  //     color: "transparent"
  //     clip: true
  //
  //     Image {
  //       anchors.fill: parent
  //       source: {
  //         let path = `file:///${Quickshell.shellRoot}/assets/`
  //
  //         if (modelData.action == "walk") path += "enemyWalk.gif"
  //
  //         return path
  //       }
  //       transform: Scale {
  //         xScale: modelData.dir == "left" ? -1 : 1
  //         origin.x: modelData.size / 2
  //       }
  //     }
  //     // AnimatedImage {
  //     //   anchors.fill: parent
  //     //   speed: 1
  //     //   currentFrame: modelData.currentFrame
  //     //   source: {
  //     //     let path = `file:///${Quickshell.shellRoot}/assets/`
  //     //
  //     //     if (modelData.action == "walk") path += "enemyWalk.gif"
  //     //
  //     //     return path
  //     //   }
  //     //   transform: Scale {
  //     //     xScale: modelData.dir == "left" ? -1 : 1
  //     //     origin.x: modelData.size / 2
  //     //   }
  //     // }
  //   }
  // }

  // Tickler.
  Timer {
    interval: 16
    running: true
    repeat: true

    property double lastTime: Date.now()

    onTriggered: {
      let now = Date.now()
      let delta = (now - lastTime) / 1000.0
      lastTime = now

      GameLogic.tick(GameState, {
        worldWidth: world.width,
        worldHeight: world.height,
        delta
      })
    }
  }

  // // Enemy spawner
  // Timer {
  //   interval: 5000
  //   running: true
  //   repeat: true
  //
  //   onTriggered: {
  //     GameLogic.spawnEnemy(GameState, {
  //       x: world.width * Math.random(),
  //       y: 0
  //     })
  //   }
  // }
}
