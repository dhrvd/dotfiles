pragma ComponentBehavior: Bound

import QtQuick

import qs.services

Row {
    id: root

    spacing: 6

    Repeater {
        model: Niri.workspaces

        delegate: Rectangle {
            id: workspace

            required property var model

            readonly property bool isFocused: model.isFocused
            readonly property bool isActive: model.isActive
            readonly property bool isUrgent: model.isUrgent

            implicitWidth: isFocused ? 15 * 3 : 15
            implicitHeight: 15
            radius: 4

            color: {
                if (isUrgent)
                    return Colors.re
                if (isFocused)
                    return Colors.tx
                if (isActive || model.activeWindowId > 0)
                    return Colors.tx2
                return Colors.tx3
            }

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: Config.animationDuration
                    easing.type: Easing.OutQuint
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Config.animationDuration
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Niri.focusWorkspaceById(workspace.model.id)
            }
        }
    }
}
