pragma Singleton

import QtQuick
import Niri

Niri {
    Component.onCompleted: connect()
    onErrorOccurred: function(error) {
        console.error("Niri error:", error)
    }
}
