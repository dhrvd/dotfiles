pragma ComponentBehavior: Bound

import QtQuick
import Niri

import qs

Row {
    id: root

    anchors.verticalCenter: parent.verticalCenter
    spacing: 6

    Niri {
        id: niri
        Component.onCompleted: connect()

        onErrorOccurred: function (error) {
            console.error("Niri error: ", error);
        }
    }

    Repeater {
        model: niri.workspaces

        delegate: Rectangle {
            required property var model

            readonly property bool isFocused: model.isFocused
            readonly property bool isActive: model.isActive
            readonly property bool isUrgent: model.isUrgent

            implicitWidth: isFocused ? 15 * 3 : 15
            implicitHeight: 15
            radius: 4

            color: {
                if (isUrgent) {
                    return Colors.re;
                }
                if (isFocused) {
                    return Colors.tx;
                }
                if (isActive || model.activeWindowId > 0) {
                    return Colors.tx2;
                }
                return Colors.tx3;
            }

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuint
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: niri.focusWorkspaceById(parent.model.id)
            }
        }
    }
}
