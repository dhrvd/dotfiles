import QtQuick

import qs.components
import qs.services

Item {
    id: root

    visible: Pipewire.ready
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Row {
        id: content
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: {
                if (Pipewire.muted)
                    return "\ue456";
                if (Pipewire.volume < 0.33)
                    return "\ue454";
                if (Pipewire.volume < 0.66)
                    return "\ue452";
                return "\ue450";
            }
            color: Pipewire.muted ? Colors.re : Colors.tx

            font.family: Config.fontIcon
            font.pixelSize: 18
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: `${Math.round(Pipewire.volume * 100)}%`
            color: Pipewire.muted ? Colors.tx2 : Colors.tx
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: Pipewire.toggleMute()
        onWheel: function (wheel) {
            if (wheel.angleDelta.y > 0)
                Pipewire.volumeUp(0.05);
            else if (wheel.angleDelta.y < 0)
                Pipewire.volumeDown(0.05);
        }
    }
}
