import QtQuick 2.0
import QtQuick.Controls 2.3



Label{
    property var btnClicked: (function(){})   // 将下面的MouseArea的点击事件暴露给外部去实现
    property bool bBtnRotateAni: false        //  是否开启旋转动画
    property bool bBtnBounceAni: false
    property Image btnImg : btnImg
    property real btnWidth
    property real btnHeight
    property color hovered_bgColor
    property bool ishovered: false
    property string toolTip
    property color backgroundColor : "transparent"
    property url btnImgSrc
    property url btnImgSrc_hover_press

    width: btnWidth
    height: btnHeight
    background: Rectangle{    // 背景常使用Rectangle定义
        anchors.fill: parent
        color: backgroundColor
        radius: 5*dp
        Image{
            id:btnImg
            width: btnWidth
            height: btnHeight
            source: btnImgSrc
            fillMode: Image.PreserveAspectFit
            cache: false
        }
    }
    ToolTip.visible: ishovered
    ToolTip.delay: 500
    ToolTip.text: toolTip

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor // 手套状鼠标指针

        onEntered: {
            btnImg.source = btnImgSrc_hover_press
            ishovered = true
            if(bBtnRotateAni) hoverRotate.start()
            if(bBtnBounceAni) hoverBounce.start()
        }

        onExited: {
            btnImg.source = btnImgSrc
            ishovered = false
            if(bBtnRotateAni) leaveRotate.start()
        }

        onClicked: {
            btnImg.source = btnImgSrc_hover_press
            btnClicked();
        }
    }

    SequentialAnimation{     // 序列动画 起跳+下落弹跳
        id:hoverBounce
        running: false
        PropertyAnimation{
            target: btnImg
            properties: "y"
            from:0
            to:-10
            duration: 200
            easing.type: Easing.OutQuart
        }
        PropertyAnimation{
            target: btnImg
            properties: "y"
            from:-10
            to:0
            duration: 600
            easing.type: Easing.OutBounce
        }
    }



    RotationAnimation{
        id : hoverRotate
        target: btnImg
        from : 0
        to : 90
        duration: 500
        running: false
        easing.type: Easing.OutCubic
    }

    RotationAnimation{
        id : leaveRotate
        target: btnImg
        from : 90
        to : 0
        duration: 500
        running: false
        easing.type: Easing.OutCubic
    }
}
