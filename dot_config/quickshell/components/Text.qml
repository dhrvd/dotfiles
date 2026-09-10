import QtQuick
import QtQuick.Effects

import qs.services

Item {
    id: root

    property alias text: content.text
    property alias font: content.font
    property alias color: content.color
    property alias wrapMode: content.wrapMode
    property alias elide: content.elide
    property alias maximumLineCount: content.maximumLineCount
    property alias horizontalAlignment: content.horizontalAlignment
    property alias verticalAlignment: content.verticalAlignment

    property bool shadowEnabled: Config.shadowEnabled

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    MultiEffect {
        source: content
        anchors.fill: content
        shadowEnabled: root.shadowEnabled
        shadowVerticalOffset: Config.shadowVerticalOffset
        blurMax: Config.blurMax
        opacity: Config.shadowOpacity
    }

    Text {
        id: content

        anchors.fill: parent
        renderType: Text.NativeRendering
        font.family: Config.fontSans
        font.pixelSize: Config.fontSize
        color: Colors.tx
    }
}
