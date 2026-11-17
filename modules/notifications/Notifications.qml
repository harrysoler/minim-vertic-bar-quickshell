import qs.config
import qs.widgets
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => n.tracked = true
    }

    PanelWindow {
        anchors {
            top: true
            right: true
        }

        margins {
            top: 4
            right: 4
        }

        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10

            Repeater {
                model: server.trackedNotifications

                delegate: NotificationCard {}
            }
        }
    }

    component NotificationCard: Rectangle {
        id: card
        required property var modelData

        readonly property bool isCritical: modelData.urgency === NotificationUrgency.Critical

        Layout.fillWidth: true
        Layout.preferredHeight: layout.implicitHeight + 20
        color: Appearance.color.withTransparency(Appearance.color.palette.background)

        border.width: 1
        border.color: isCritical ? Appearance.color.palette.alert : Appearance.color.palette.primary

        Timer {
            running: !isCritical
            interval: Config.notificationTimeoutMs
            onTriggered: card.modelData.dismiss()
        }

        MouseArea {
            anchors.fill: parent
            onClicked: card.modelData.dismiss()
        }

        RowLayout {
            id: layout

            anchors {
                fill: parent
                margins: 10
            }

            spacing: 10

            Image {
                Layout.preferredHeight: 36
                Layout.preferredWidth: 36
                Layout.alignment: Qt.AlignTop

                fillMode: Image.PreserveAspectFit
                visible: source.toString() !== ""

                source: card.modelData.image || card.modelData.appIcon || ""
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                StyledText {
                    text: card.modelData.summary

                    Layout.fillWidth: true
                    font.bold: true
                    // ellipsis on the right
                    elide: Text.ElideRight
                }

                StyledText {
                    text: card.modelData.body
                    visible: text !== ""

                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
