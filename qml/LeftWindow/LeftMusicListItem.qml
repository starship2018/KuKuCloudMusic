import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
import "qrc:/qml/Utils"
/*
    歌单Item项
*/
Button{
    property bool isClicked: false
    property url icoforMusicList
    property string listName
    property string count
    property string idName  // 信号槽参数使用！

    id:musicItemBtn
    width: parent.width
    height: 60*dp

    signal btnClicked(string name)

    background: Rectangle{
        id:rect
        color: "transparent"
        Row{
            leftPadding: 12*dp
            spacing: 10*dp
            width: musicItemBtn.width
            height: musicItemBtn.height
            Item{
                width: 42*dp
                height: parent.height
                CircularImage{
                    anchors.verticalCenter: parent.verticalCenter
                    id:icon
                    img_src: icoforMusicList
                    radiusVal:8*dp
                    width: parent.width
                    height: parent.width   // 正方形！！
                }
            }


            Column{
                width: musicItemBtn.width * 0.7
                height: parent.height
                spacing: 12*dp
                topPadding: 12*dp
                Label{    // 可视元素Item需要指定具体的width和height，不然显示会出现问题！
                    id:musicListTitle
                    height: parent.height*0.2
                    width: musicItemBtn.width - 80*dp
                    Text {
                        id: name
                        anchors.fill: parent
                        text: listName
                        elide: Text.ElideRight
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 12*dp
                        color: "#adafb2"
                    }

                }
                Label{
                    id:acountInfo
                    text:count+qsTr("首")
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 10*dp
                    color: "#adafb2"
                }
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                if(!isClicked){
                    musicListTitle.color = "#dcdde3"
                    acountInfo.color = "#dcdde3"
                    parent.color = "#26282c"
                }
            }

            onExited: {
                if(!isClicked){
                    musicListTitle.color = "#adafb2"
                    acountInfo.color = "#adafb2"
                    parent.color = "transparent"
                }
            }

            onClicked: {
                isClicked = true
                parent.color = "#26282c"
                btnClicked(idName)   // emit signal
            }
        }
    }

    function reset(){
        isClicked = false
        musicListTitle.color = "#adafb2"
        acountInfo.color = "#adafb2"
        rect.color = "transparent"
    }

    Component.onCompleted: {
        musicItemBtn.btnClicked.connect(btnGroupClicked)  // 连接槽函数 sender.signal.connect(slot)
    }
}
