import QtQuick

import qs.components
import qs.services

Row {
    id: root

    readonly property var focusedWindow: Niri.focusedWindow

    spacing: 6

    Image {
        readonly property string iconPath: root.focusedWindow?.iconPath ?? ""

        anchors.verticalCenter: parent.verticalCenter
        source: iconPath ? `file://${iconPath}` : ""
        sourceSize: Qt.size(24, 24)
        visible: iconPath !== ""
        smooth: true
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        spacing: -6

        Text {
            width: 150
            text: root.focusedWindow?.appId ?? ""
            color: Colors.tx2
            elide: Text.ElideRight

            font.pixelSize: 12
        }

        Text {
            width: 200
            text: root.focusedWindow?.title ?? ""
            elide: Text.ElideRight

            font.pixelSize: 15
        }
    }
}
