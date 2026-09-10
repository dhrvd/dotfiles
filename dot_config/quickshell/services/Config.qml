pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property int fontSize: 18

    readonly property string fontSans: "Geist"
    readonly property string fontMono: "Geist Mono"
    readonly property string fontIcon: "Phosphor-Fill"

    readonly property int animationDuration: 150

    readonly property bool shadowEnabled: true
    readonly property int shadowVerticalOffset: 2
    readonly property int blurMax: 36
    readonly property real shadowOpacity: 0.8
}
