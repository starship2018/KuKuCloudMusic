import QtQuick 2.7
import QtQuick.Controls 2.1

Label{
    property string btnText
    property color color_hovered
    property bool isClicked: false
    property var btnClickFunc: (function(){})
    id:tab
    Label{   // 文字标签
        id:lab
        width: parent.width
        height: parent.height/1.1
        text: btnText
        font.family: "Microsoft YaHei"
        font.pixelSize: 16*dp
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#828385"
    }

    Rectangle{     // 选中项下面的横线！ + 添加渐入渐出动画！
        id:rect
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: tab.width
        height: 2*dp
        color: "#5C5E61"
        visible: false
    }

    Rectangle{     // 作为rect的遮罩，实现渐退效果！
        id:rectMask
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 0
        opacity: 0
        height: 2*dp
        color: "#202226"
        visible: true
    }

    SequentialAnimation{
        id:inAni
        // 遮罩急速变透明，横线缓缓变宽（0开始）
        PropertyAnimation{
            target: rectMask
            properties: "opacity"    // 属性必须是string类型
            from : 1
            to: 0
            running: false
            duration: 10
            easing.type: Easing.InOutBack
        }

        PropertyAnimation{
            target: rect
            properties: "width"    // 属性必须是string类型
            from : 0
            to: tab.width
            running: false
            duration: 400
            easing.type: Easing.InOutBack
        }
    }

    SequentialAnimation{
        id:outAni
        // 遮罩急速变不透明，并且之后开始缓缓变宽，视觉上造成横线缓缓变宽的效果！
        PropertyAnimation{
            target: rectMask
            properties: "opacity"
            from :0
            to:1
            running: false
            duration: 10
            easing.type: Easing.InOutBack
        }
        PropertyAnimation{
            target: rectMask
            properties: "width"
            from :0
            to:tab.width
            running: false
            duration: 400
            easing.type: Easing.InOutBack
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            if(!isClicked)
                lab.color=color_hovered
        }

        onExited: {
            if(!isClicked)
                lab.color="#828385"
        }

        onClicked: {
            isClicked=true
            rect.width = 0
            rect.visible=true
            tab.parent.tabClicked(tab.objectName)
            btnClickFunc()
            inAni.start()
        }
    }

    function reset(){
        lab.color="#828385"
        //rect.visible=false
        if(isClicked){
            outAni.start()
        }
        isClicked=false
    }

    //设置为已点击状态
    function firstClicked(){   // 在外界通过component.onComplete调用！
        isClicked = true
        rect.visible = true
        lab.color = color_hovered
    }

    Component.onCompleted: {
        parent.btns.push(tab)
    }
}
