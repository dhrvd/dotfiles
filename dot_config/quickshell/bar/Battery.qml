import QtQuick
import Quickshell.Widgets
import Quickshell.Services.UPower

import qs
import qs.components

Item {
    id: root

    implicitWidth: capacityClip.implicitWidth
    implicitHeight: capacityClip.implicitHeight

    readonly property var battery: UPower.displayDevice.ready ? UPower.displayDevice : null
    readonly property var percentage: battery?.percentage != null ? Math.round(battery.percentage * 100) : -1
    readonly property bool charging: battery?.state === UPowerDeviceState.Charging || battery?.state === UPowerDeviceState.FullyCharged || battery?.state === UPowerDeviceState.Unknown

    ClippingRectangle {
        id: capacityClip

        implicitHeight: 18
        implicitWidth: 18 * 2
        radius: 4
        color: Colors.tx2

        Rectangle {
            id: capacity

            anchors.left: parent.left
            anchors.top: parent.top
            height: parent.height
            width: parent.width * root.percentage / 100
            color: {
                if (root.charging) return Colors.cy
                if (root.percentage == 100) return Colors.tx
                if (root.percentage <= 20) return Colors.re
                if (root.percentage <= 40) return Colors.ye
                return Colors.gr
            }
        }
    }

    Item {
        id: nubClip

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: capacityClip.right
        anchors.leftMargin: 2

        width: nub.width / 2
        height: nub.height
        clip: true

        Rectangle {
            id: nub

            width: 4
            height: 6
            radius: 100
            color: Colors.tx2
            x: -width / 2
        }
    }

    Row {
        id: content

        anchors.centerIn: capacityClip
        spacing: -1

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: root.percentage
            color: Colors.bg

            font.pixelSize: 18
            font.weight: Font.Medium
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            visible: root.charging

            text: ""
            color: Colors.bg
            font.family: "Phosphor-Fill"
            font.pixelSize: 12
        }
    }
}
