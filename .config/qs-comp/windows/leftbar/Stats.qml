import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  id: stats
  Layout.fillWidth: true
  Layout.preferredHeight: statsContent.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
  }

  ColumnLayout {
    id: statsContent

    StyledText {
      id: kernel
      Layout.topMargin: 28
      Layout.leftMargin: 28

      Process {
        id: kernelProc
        command: ["uname", "-r"]
        running: true
        stdout: SplitParser {
          onRead: data => kernel.text = `Linux ${data}`
        }
      }
    }

    StyledText {
      id: uptime
      Layout.leftMargin: 28

      Process {
        id: uptimeProc
        command: ["sh", "-c", "uptime --pretty | cut -d',' -f1 | sed 's/^up //'"]
        running: true
        stdout: SplitParser {
          onRead: (data) => {
            let up = data.replace(/up /, '')
            uptime.text = `Uptime ${up}`
          }
        }
      }

      Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: uptimeProc.running = true
      }
    }

    StyledText {
      id: cpu
      Layout.leftMargin: 28
      text: "Cpu 0%"
      font.pixelSize: 30

      Process {
        id: cpuProc
        command: ["top", "-bn1"]
        running: true
        stdout: SplitParser {
          onRead: (data) => {
            const cpuLine = data
            .split("\n")
            .find(line => line.toLowerCase().includes("cpu(s)"))

            if (!cpuLine) return

            const match = cpuLine.match(/(\d+\.\d+)\s*id/)
            if (!match) return

            const idle = parseFloat(match[1])
            const usage = (100 - idle).toFixed(2)

            cpu.text = `Cpu ${usage}%`
          }
        }
      }
    }

    StyledText {
      id: mem
      Layout.leftMargin: 28
      Layout.bottomMargin: 28
      text: "Mem"
      font.pixelSize: 30

      Process {
        id: memProc
        command: ["top", "-bn1"]
        running: true
        stdout: SplitParser {
          onRead: (data) => {
            const memLine = data
            .split("\n")
            .find(line => line.toLowerCase().startsWith("mi") || line.toLowerCase().includes("mem"))

            if (!memLine) return

            const match = memLine.match(/([\d.]+)\s+total,\s+([\d.]+)\s+free,\s+[\d.]+\s+used,\s+([\d.]+)\s+buff\/cache/)
            if (!match) return

            const total = parseFloat(match[1])
            const free = parseFloat(match[2])
            const cache = parseFloat(match[3])

            const realUsed = total - free - cache;
            const usage = ((realUsed / total) * 100).toFixed(2)

            mem.text = `Mem ${usage}%`
          }
        }
      }

      Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: memProc.running = true
      }
    }
  }
}
