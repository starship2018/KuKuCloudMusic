import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.1


Slider {
    property real minValue
    property real maxValue
    property bool hasParent: false
    property bool isVisible: true
    property bool ispressed: false
    property bool isHorizonal: true
    property var showColor
    property var workedBarColor
    property var unworkedBarColor
    property var releasedFunc: function(){}
    property var hoveredEnteredFunc: function(){}   // 添加hover函数，配合外部使用！
    id: sliderControl
    width: parent.width
    height: parent.height
    from: minValue
    to:maxValue
    orientation:isHorizonal?Qt.Horizontal : Qt.Vertical

    background: Rectangle {// 进度条颜色（未播放）  positionVal~maxValue
        x: sliderControl.leftPadding
        y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: isHorizonal? sliderControl.width :5*dp
        implicitHeight: isHorizonal?  5*dp : sliderControl.height
        width: isHorizonal? sliderControl.availableWidth : implicitWidth
        height: isHorizonal? implicitHeight : sliderControl.availableHeight
        radius: 3*dp
        color: unworkedBarColor

        Rectangle {   // 进度条颜色（已播放）       minValue~positionVal
            anchors.bottom: parent.bottom
            width: isHorizonal? sliderControl.visualPosition * parent.width : parent.width
            height: isHorizonal? parent.height : (1-sliderControl.visualPosition) * parent.height
            color: workedBarColor
            radius: 3*dp
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            dragIco.color = showColor
            console.log("parent entered")
            hoveredEnteredFunc()
        }

        onExited: {
            dragIco.color = "transparent"
            console.log("parent exited")
        }

        Rectangle {
                id: dragIco
                visible: true
                anchors{
                    horizontalCenter:isHorizonal?  null: parent.horizontalCenter
                }

                x: isHorizonal? sliderControl.leftPadding + sliderControl.visualPosition * (sliderControl.availableWidth - width) : /*sliderControl.leftPadding*/ + sliderControl.availableWidth/2-width/2-1
                y: isHorizonal? sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2 : sliderControl.topPadding + sliderControl.visualPosition * (sliderControl.availableHeight - height)
                width: 15*dp
                height: 15*dp
                radius: 15*dp
                color: "transparent"

                Label{
                    id:cd
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    //text: "\uf6ca"   // ⊙
                    color: "#b82525"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:icomoonFont.name
                    font.pixelSize: 20*dp
                }

               // source: "qrc:/images/slider.png";
                MouseArea{
                    property real xmouse
                    property real ymouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
//                    propagateComposedEvents: true
                    onEntered: {
                        console.log("Entered")
                        dragIco.color = showColor
                        hoveredEnteredFunc()
                    }

                    onPressed: {
                        xmouse = mouseX
                        ymouse = mouseY
                        dragIco.color = showColor
                        sliderControl.ispressed=true
                        console.log("Pressed")
                        //mouse.accepted = true
                    }

                    onReleased: {
                        console.log("Released")
                        dragIco.color = "transparent"
                        sliderControl.ispressed=false
                        sliderControl.releasedFunc()
                        //mouse.accepted = true
                    }

                    onPositionChanged: {
                        if(pressed)
                        {
                            if(isHorizonal) {
                                sliderControl.value=sliderControl.value+(mouseX-xmouse)/(sliderControl.width)*(maxValue-minValue)
                            }else{
                                sliderControl.value=sliderControl.value-(mouseY-ymouse)/(sliderControl.height)*(maxValue-minValue)
                            }
                        }
                        //mouse.accepted = true
                    }
                }
            }
    }

    handle: dragIco
}

