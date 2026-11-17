pragma ComponentBehavior: Bound

import qs.config
import qs.services
import QtQuick

Text {
    id: root

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Appearance.color.palette.foreground
    font.family: Appearance.font.family.mono
    font.pointSize: Appearance.font.size.small
}
