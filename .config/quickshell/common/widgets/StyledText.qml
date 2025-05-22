import QtQuick
import QtQuick.Layouts

import "root:/common"

Text {
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting
  verticalAlignment: Text.AlignVCenter
  font.family: Settings.font.family
  font.pixelSize: Settings.font.size
  color: Settings.colors.fg
}
