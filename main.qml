import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import "qrc:/qml/TitleBar"
import "qrc:/qml/LeftWindow"
import "qrc:/qml/BottomWindow"

Window {
    id:mainWindow
    property real dpScale: 1.5
    readonly property real dp: Math.max(Screen.pixelDensity*25.4/160*dpScale)
    color: "black"
    visible: true
    width: 1000*dp
    height: 685*dp
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint | Qt.Window  // 无边框 + 任务栏图标

    //字体图标
    FontLoader{
        id:icomoonFont;
        source: "../font/icomoon.ttf";    //本字体通过特殊的转移字符能显示出独特的icon，很神奇！这里附上官网，修改图标可自行查找对应https://icomoon.io/#home
    }


    TitleBar{
        id:titleBar
        width: parent.width-2*dp
        height: 45*dp
        anchors.left: parent.left
        anchors.leftMargin: 1*dp     // 左侧同一1dp边距
        anchors.top: parent.top
        anchors.topMargin: 1*dp
    }

    Rectangle{    // 标题栏下的横线
        id:redLine
        color:"#247BA0"
        width: parent.width - 2*dp
        height: 2*dp
        anchors{
            left: parent.left
            top: titleBar.bottom
            leftMargin: 1*dp
        }
    }

    LeftWindow{
        id:leftWd
        anchors.left: parent.left
        anchors.leftMargin: 1*dp
        anchors.top: redLine.bottom
        width: 200*dp
        height: 575*dp
    }

    BottomWindow{
        id:bottomWd
        z:1  // 置顶显示
        width:parent.width - 2*dp
        height:60*dp
        anchors.left : parent.left
        anchors.top :leftWd.bottom
    }

    Loader{
        id:rightWd
        width: 798*dp
        height: 575*dp
        anchors.left: leftWd.right;
        anchors.top: redLine.bottom;
        source: "qrc:/qml/RightWindow/DiscoverMusic/DiscoverMusic.qml";
    }

    // 窗口阴影，后续补充
//    DropShadow {
//        anchors.fill: leftWd
//        horizontalOffset: -5
//        verticalOffset: -5
//        radius: 12.0
//        samples: 25
//        color: "#20000000"
//        spread: 0.0
//        source: leftWd
//    }
//    DropShadow {
//        anchors.fill: leftWd
//        horizontalOffset: 5
//        verticalOffset: 5
//        radius: 12.0
//        samples: 25
//        color: "#20000000"
//        spread: 0.0
//        source: leftWd
//    }


}
