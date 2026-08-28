import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs

PanelWindow {
    id: barWindow
    WlrLayershell.namespace: "quickshell:bar"

    required property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36
    color: Qt.alpha(Colors.bg, 0.6)

    RowLayout {
        id: barLeft

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        anchors.leftMargin: 12
        spacing: 24

        Workspaces {}
    }

    RowLayout {
        id: barRight

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        anchors.rightMargin: 12
        spacing: 24

        Battery {}
        Clock {}
    }
}

