import QtQuick

import qs.components
import qs.services

Text {
    readonly property bool isInhibited: Stasis.state === "inhibited" || Stasis.state === "manual"

    text: ""
    color: isInhibited ? Colors.tx : Colors.tx2

    font.family: Config.fontIcon
    font.pixelSize: 21
}
