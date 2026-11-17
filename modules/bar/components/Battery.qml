pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick.Layouts
import QtQuick

Loader {
    id: root

    readonly property real percentage: UPower.floatPercentage
    readonly property bool isCharging: !UPower.onBattery

    active: UPower.isReady
    asynchronous: true

    sourceComponent: ColumnLayout {
        spacing: 0

        BatteryIcon {}
        BatteryText {}
    }

    component BatteryIcon: MaterialIcon {
        readonly property list<string> rangeIcons: [
            "battery_0_bar",
            "battery_1_bar",
            "battery_2_bar",
            "battery_3_bar",
            "battery_4_bar",
            "battery_5_bar",
            "battery_full"
        ]
        readonly property string currentIcon: rangeIcons[Math.floor(root.percentage / 0.142)]

        property bool isBatteryLow: root.percentage <= 0.2

        text: root.isCharging ? "bolt" : currentIcon
        color: isBatteryLow ? Appearance.color.palette.alert : Appearance.color.palette.foreground
        opacity: 1
        fill: 1

        Layout.alignment: Qt.AlignCenter

        SequentialAnimation on opacity {
            running: isBatteryLow && !root.isCharging
            loops: Animation.Infinite

            NumberAnimation { to: 0.0; duration: 0 }
            PauseAnimation { duration: 500 }
            NumberAnimation { to: 1.0; duration: 0 }
            PauseAnimation { duration: 500 }
        }

    }

    component BatteryText: StyledText {
        text: {
            return percentage == 1 ? "FL" : Math.floor(percentage * 100)
        }

        Layout.alignment: Qt.AlignCenter
        color: Appearance.color.palette.foreground
        font.family: Appearance.font.family.mono
        font.pointSize: Appearance.font.size.small
    }
}
