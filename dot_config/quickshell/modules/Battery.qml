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

    readonly property color capacityColor: {
        if (root.percentage <= 20)
            return Colors.re;
        if (root.percentage <= 40)
            return Colors.ye;
        return Colors.tx;
    }

    Item {
        id: icon
        anchors.verticalCenter: parent.verticalCenter

        implicitWidth: outline.implicitWidth + nubClip.implicitWidth + nubClip.anchors.leftMargin
        implicitHeight: outline.implicitHeight

        Rectangle {
            id: outline

            implicitHeight: 15
            implicitWidth: implicitHeight * 2
            color: "transparent"

            border.color: Colors.tx2
            border.width: 1
            radius: 4

            Canvas {
                id: capacity
                anchors.fill: parent
                anchors.margins: 1

                readonly property real ratio: root.percentage / 100
                readonly property color fillColor: root.capacityColor
                readonly property bool charging: root.isCharging
                readonly property real cornerRadius: Math.max(0, outline.radius - anchors.margins)

                onRatioChanged: requestPaint()
                onFillColorChanged: requestPaint()
                onChargingChanged: requestPaint()
                onWidthChanged: requestPaint()
                onHeightChanged: requestPaint()
                Component.onCompleted: requestPaint()

                onPaint: {
                    const ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    const fillWidth = width * ratio;

                    function roundedRectPath(x, y, w, h, r) {
                        const radius = Math.max(0, Math.min(r, w / 2, h / 2));
                        ctx.beginPath();
                        ctx.moveTo(x + radius, y);
                        ctx.lineTo(x + w - radius, y);
                        ctx.arcTo(x + w, y, x + w, y + radius, radius);
                        ctx.lineTo(x + w, y + h - radius);
                        ctx.arcTo(x + w, y + h, x + w - radius, y + h, radius);
                        ctx.lineTo(x + radius, y + h);
                        ctx.arcTo(x, y + h, x, y + h - radius, radius);
                        ctx.lineTo(x, y + radius);
                        ctx.arcTo(x, y, x + radius, y, radius);
                        ctx.closePath();
                    }

                    if (fillWidth > 0 && height > 0) {
                        ctx.save();
                        roundedRectPath(0, 0, fillWidth, height, cornerRadius);
                        ctx.clip();
                        ctx.fillStyle = fillColor;
                        ctx.fillRect(0, 0, fillWidth, height);
                        ctx.restore();
                    }

                    if (charging) {
                        const cx = width / 2;
                        const cy = height / 2 + 1;

                        ctx.save();
                        ctx.globalCompositeOperation = "destination-out";
                        ctx.fillStyle = "black";
                        ctx.textAlign = "center";
                        ctx.textBaseline = "middle";
                        ctx.font = `${height + 4}px "${Config.fontIcon}"`;
                        ctx.fillText("\ue2de", cx, cy);
                        ctx.restore();

                        ctx.save();
                        ctx.fillStyle = Colors.tx;
                        ctx.textAlign = "center";
                        ctx.textBaseline = "middle";
                        ctx.font = `${height}px "${Config.fontIcon}"`;
                        ctx.fillText("\ue2de", cx, cy);
                        ctx.restore();
                    }
                }
            }
        }

        Item {
            id: nubClip

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: outline.right
            anchors.leftMargin: 1

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
    }

    Text {
        text: `${root.percentage}%`
    }
}
