import qs.services
import qs.config

StyledText {
    property real fill

    font.family: Appearance.font.family.material
    font.pointSize: Appearance.font.size.small
    font.variableAxes: ({
        FILL: fill.toFixed(1),
        GRAD: 0,
        opsz: fontInfo.pixelSize,
        wght: fontInfo.weight
    })
}
