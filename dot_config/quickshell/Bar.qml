import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import qs.modules
import qs.services

PanelWindow {
    WlrLayershell.namespace: "quickshell:bar"

    required property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Config.fontSize * 2
    color: "transparent"

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        anchors.leftMargin: Config.fontSize  * 2 / 3
        spacing: Config.fontSize * 4 / 3

        Workspaces {}
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        anchors.rightMargin: Config.fontSize  * 4 / 3
        spacing: Config.fontSize * 4 / 3

        Battery {}
        Clock {}
    }
}
