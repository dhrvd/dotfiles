pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import qs.services

Row {
    id: root

    spacing: 6

    Repeater {
        model: Niri.workspaces

        delegate: Item {
            id: delegateRoot

            required property var model

            readonly property bool isFocused: model.isFocused
            readonly property bool isActive: model.isActive
            readonly property bool isUrgent: model.isUrgent

            implicitWidth: workspace.implicitWidth
            implicitHeight: workspace.implicitHeight

            Rectangle {
                id: workspace

                implicitWidth: delegateRoot.isFocused ? 15 * 3 : 15
                implicitHeight: 15
                radius: 4

                color: {
                    if (delegateRoot.isUrgent)
                        return Colors.re;
                    if (delegateRoot.isFocused)
                        return Colors.tx;
                    if (delegateRoot.isActive || delegateRoot.model.activeWindowId > 0)
                        return Colors.tx2;
                    return Colors.tx3;
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
                        easing.type: Easing.OutQuint
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Niri.focusWorkspaceById(delegateRoot.model.id)
                }
            }

            MultiEffect {
                source: workspace
                anchors.fill: workspace
                shadowEnabled: Config.shadowEnabled
                shadowVerticalOffset: Config.shadowVerticalOffset
                blurMax: Config.blurMax
                opacity: Config.shadowOpacity
            }
        }
    }
}
