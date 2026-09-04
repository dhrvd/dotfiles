pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property bool ready: Pipewire.ready

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property PwNodeAudio sinkAudio: sink?.audio ?? null

    readonly property real volume: sinkAudio?.volume ?? 0
    readonly property bool muted: sinkAudio?.muted ?? false

    readonly property string sinkName: sink?.name ?? ""
    readonly property string sinkDescription: sink?.description ?? ""
    readonly property string sinkNickname: sink?.nickname ?? ""

    readonly property string sourceName: source?.name ?? ""
    readonly property string sourceDescription: source?.description ?? ""
    readonly property string sourceNickname: source?.nickname ?? ""

    PwObjectTracker {
        objects: [
            root.sink,
            root.source,
        ]
    }

    function toggleMute(): void {
        if (sinkAudio)
            sinkAudio.muted = !sinkAudio.muted
    }

    function setVolume(value: real): void {
        if (sinkAudio)
            sinkAudio.volume = Math.max(0, Math.min(1, value))
    }

    function changeVolume(amount: real): void {
        if (sinkAudio)
            setVolume(volume + amount)
    }

    function volumeUp(amount: real): void {
        changeVolume(amount)
    }

    function volumeDown(amount: real): void {
        changeVolume(-amount)
    }
}
