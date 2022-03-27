import QtQuick 2.7
import QtQuick.Controls 2.1

SwitchDelegate{   // 自定义switch
    property string switchText;
    id:control
    font{
        family: "Microsoft YaHei"
        pixelSize: 12*dp
    }

    checked: false;

    onCheckedChanged: {
        switch(switchText)
        {
        case qsTr("回声"):
            AudioData.setEcho();
            break;
        case qsTr("EQ均衡器"):
            AudioData.setEq();
            break;
        case qsTr("消除人声"):
            AudioData.setCenterCut();
            break;
        case qsTr("混合立体声道"):
            AudioData.setMixChannels();
            break;
        }
    }

    contentItem: Text {    // 按钮前的说明性文字
        rightPadding: control.indicator.width + control.spacing
        text: switchText
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "#cccccc"
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 20
        x: control.width - width - control.rightPadding
        y: parent.height / 2 - height / 2
        radius: 10
        color: control.checked ? "#17a81a" : "transparent"
        border.color: control.checked ? "#17a81a" : "#cccccc"

        Label{     // 切换前后的两个文字Label
            width: 20;
            height: 24;
            anchors.leftMargin: 13;
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("开")
        }
        Label{
            width: 20;
            height: 24;
            anchors.right: parent.right;
            anchors.rightMargin: 3;
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("关");
            color: "#cccccc";
        }

        Rectangle {     // 左右滑动的切换按钮
            x: control.checked ? parent.width - width : 0
            width: 20
            height: 20
            radius: 10
            color: control.down ? "#cccccc" : "#ffffff"
            border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
        }
    }

    background: Rectangle {   // 背景，在点击时才现身
        implicitWidth: 100
        implicitHeight: 40
        visible: control.down || control.highlighted
        color: "transparent"
    } 

}

