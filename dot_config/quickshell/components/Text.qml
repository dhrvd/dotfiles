import QtQuick

import qs

Item {
    id: root

    property alias text: content.text
    property alias font: content.font
    property alias color: content.color
    property alias horizontalAlignment: content.horizontalAlignment
    property alias verticalALignment: content.verticalAlignment

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Text {
        id: content

        anchors.fill: parent
        renderType: Text.NativeRendering

        font.family: Config.fontSans
        font.pixelSize: 18
        color: Colors.tx
    }
}
