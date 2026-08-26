import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components

RowLayout {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        text: Qt.formatDateTime(clock.date, "ddd dd MMM")
    }

    Text {
        text: Qt.formatDateTime(clock.date, "hh:mm")
        font.weight: Font.Medium
    }
}
