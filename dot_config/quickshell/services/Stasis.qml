pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string state: ""
    property bool paused: false
    property bool manuallyPaused: false
    property string profile: "default"

    Process {
        command: ["stasis", "watch"]
        running: true

        stdout: SplitParser {
            onRead: message => {
                try {
                    const data = JSON.parse(message)

                    root.state = data.state
                    root.paused = data.paused
                    root.manuallyPaused = data.manually_paused
                    root.profile = data.profile
                } catch (error) {
                    console.warn("Failed to parse Stasis message:", message, error)
                }
            }
        }
    }
}
