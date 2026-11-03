pragma Singleton

import Quickshell
import Quickshell.I3
import QtQuick

Singleton {
    id: root

    readonly property var workspaces: I3.workspaces
    readonly property I3Workspace focusedWorkspace: I3.focusedWorkspace
    readonly property int activeWorkspaceId: focusedWorkspace?.number ?? 1

    function isWorkspaceOccupied(workspaceId: int): bool {
        var workspace = workspaces.values
            .find((workspace) => workspace.number == workspaceId + 1)

        if (!workspace) {
            return false
        }

        var ipc = workspace.lastIpcObject

        if (!ipc) {
            return false
        }

        if (ipc.nodes && ipc.nodes.length > 0) {
            return true
        }

        if (ipc.floating_nodes && ipc.floating_nodes.length > 0) {
            return true
        }

        return false
    }

    function switchToWorkspace(workspace: int): void {
        I3.dispatch(`workspace ${workspace}`)
    }

    function shiftWorkspace(shiftForward: bool): void {
        const shiftDirection = shiftForward ? "next" : "prev"
        I3.dispatch(`workspace ${shiftDirection}`)
    }

    // Connections {
    //     target: I3

    //     function onRawEvent(event: I3Event): void {
    //         console.log(event.type)

    //         if (event.type.includes("workspace")) {
    //             var data = JSON.parse(event.data)
    //             console.log(` ${data.change}`)

    //             // if (["empty", "init", "none"].includes(data.change)) {
    //             //     I3.refreshWorkspaces()
    //             // }
    //         }
    //     }
    // }
}
