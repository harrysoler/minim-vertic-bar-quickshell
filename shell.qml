import qs.modules.bar
import Quickshell
import QtQuick

ShellRoot {
    settings.watchFiles: false

    Scope {
        Variants {
            model: Quickshell.screens

            Bar {}
        }
    }
}
