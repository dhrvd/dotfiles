pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.UPower

import qs.components
import qs.services

Row {
    id: root
    spacing: 6

    visible: root.battery !== null

    readonly property var battery: UPower.displayDevice.ready ? UPower.displayDevice : null
    readonly property int percentage: Math.round((root.battery?.percentage ?? 0) * 100)
    readonly property bool isCharging: battery?.state === UPowerDeviceState.Charging || battery?.state === UPowerDeviceState.FullyCharged || battery?.state === UPowerDeviceState.Unknown

    Item {
        id: icon
        anchors.verticalCenter: parent.verticalCenter

        implicitWidth: outline.implicitWidth + nubClip.implicitWidth + nubClip.anchors.leftMargin
        implicitHeight: outline.implicitHeight

        Rectangle {
            id: outline

            implicitHeight: Config.fontSize * 5 / 6
            implicitWidth: implicitHeight * 2
            color: "transparent"

            border.color: Colors.tx2
            border.width: 1
            radius: Math.round(implicitHeight / 4)

            Rectangle {
                id: capacity

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                anchors.margins: 1
                width: (outline.implicitWidth - anchors.margins * 2) * root.percentage / 100
                radius: outline.radius - anchors.margins

                color: {
                    if (root.percentage <= 20)
                        return Colors.re;
                    if (root.percentage <= 40)
                        return Colors.ye;
                    return Colors.tx;
                }
            }
        }
        Item {
            id: nubClip

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: outline.right
            anchors.leftMargin: 1

            visible: !root.isCharging
            implicitHeight: Math.round(parent.implicitHeight * 0.4)
            implicitWidth: implicitHeight / 2.5
            clip: true

            Rectangle {
                implicitWidth: parent.implicitWidth * 2
                implicitHeight: parent.implicitHeight
                radius: 100
                color: Colors.tx2
                x: -implicitWidth / 2
            }
        }

        Text {
            anchors.left: outline.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: -font.pixelSize / 2

            z: 1
            visible: root.isCharging

            text: "\ue2de"

            shadowEnabled: false
            font.family: Config.fontIcon
            font.pixelSize: Config.fontSize - 2
        }
    }

    Text {
        text: `${root.percentage}%`
    }
}
