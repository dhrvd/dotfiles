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

                color: root.percentage <= 20 && !root.isCharging ? Colors.re : Colors.tx
            }
        }
        Item {
            id: nubClip

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: outline.right
            anchors.leftMargin: 1

            implicitHeight: Math.round(parent.implicitHeight * 0.4)
            implicitWidth: root.isCharging ? implicitHeight : implicitHeight / 2.5
            clip: !root.isCharging

            Rectangle {
                implicitWidth: parent.implicitWidth * 2
                implicitHeight: parent.implicitHeight
                radius: 100
                color: Colors.tx2
                x: root.isCharging ? 0 : -implicitWidth / 2
                visible: !root.isCharging
            }

            Text {
                anchors.centerIn: parent
                anchors.leftMargin: 1

                text: "\ue2de"

                font.family: Config.fontIcon
                font.pixelSize: Config.fontSize - 4
                visible: root.isCharging
            }
        }
    }

    Text {
        text: `${root.percentage}%`
    }
}
