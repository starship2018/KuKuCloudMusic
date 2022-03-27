import QtQuick 2.6
import QtGraphicalEffects 1.0

Rectangle {
    property string img_src
    property real radiusVal : 3*dp
    color: "transparent"     //  注意！这里的color一定要指定，不然默认会出现白边！！！！！

    Image {
        id: _image
        smooth: true
        visible: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: img_src
        sourceSize: Qt.size(parent.size, parent.size)
        antialiasing: true
    }
    Rectangle {
        id: _mask
        color:"red"
        anchors.fill: parent
        radius: radiusVal
        visible: false
        antialiasing: true
        smooth: true
    }
    OpacityMask {
        id: mask_image
        anchors.fill: _image
        source: _image
        maskSource: _mask
        visible: true
        antialiasing: true
    }
}
