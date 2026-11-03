pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    ClockText {
        id: hours
        text: Time.format("hh")
    }

    ClockText {
        id: minutes
        text: Time.format("mm")
    }

    component ClockText: Text {
        Layout.alignment: Qt.AlignCenter
        color: Appearance.color.palette.foreground
        font.family: Appearance.font.family.mono
        // TODO: Redefine sizes, small must be normal
        font.pointSize: Appearance.font.size.small
    }
}
