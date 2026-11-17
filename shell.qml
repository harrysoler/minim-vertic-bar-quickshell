import qs.modules.bar
import qs.modules.notifications
import Quickshell
import QtQuick

ShellRoot {
    settings.watchFiles: true

    Scope {
        Variants {
            model: Quickshell.screens

            Bar {}
        }

        Notifications {}
    }
}
