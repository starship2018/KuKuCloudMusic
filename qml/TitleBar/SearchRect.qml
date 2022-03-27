import QtQuick 2.9
import QtQuick.Controls 2.3

BorderImage{
    id:root
    source: "qrc:/images/searchBorderImg.png"

    width: 230*dp
    height: searchListView.height*dp + lab.height*dp+20*dp
    cache: false
    border{
        top: 20*dp
        bottom: 10*dp
        left:10*dp
        right:10*dp
    }

    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch

    Component.onCompleted: {
        console.log(root.width + "------"+ root.height)
    }

    Label{
        id:lab
        anchors{
            top: parent.top
            topMargin: 10*dp
            leftMargin: 2*dp
        }
        width: parent.width - 4*dp
        padding: 5*dp
        text: qsTr("热门搜索")
        font{
            family: "Microsoft YaHei"
            pixelSize: 12*dp
        }
        color: "#5f5f63"
        verticalAlignment:Label.AlignVCenter
        horizontalAlignment: Label.AlignLeft
    }

    Rectangle{
        id:rect
        width: lab.width
        height: 1*dp
        anchors{
            left: parent.left
            leftMargin: 2*dp
            top:lab.bottom
        }
        color: "gray"
    }

    ListModel{
        id:searchModel
        ListElement{
            type:"name"
            title:qsTr("光年之外")
        }
        ListElement{
            type:"name"
            title:qsTr("多远都要在一起")
        }
        ListElement{
            type:"name"
            title:qsTr("盲点")
        }
        ListElement{
            type:"name"
            title:qsTr("倒数")
        }
        ListElement{
            type:"name"
            title:qsTr("泡沫")
        }
    }

    ListView{
        id:searchListView
        anchors{
            top:rect.bottom
            left: parent.left
            leftMargin: 2*dp
        }
        width: parent.width - 4*dp
        height: searchModel.count*25*dp
        model:searchModel
        delegate: Label{
            width: parent.width
            height: 25*dp
            padding: 5*dp
            text: title
            font{
                family: "Microsoft YaHei"
                pixelSize: 12*dp
            }
            color:"#a5a7a8"
            elide: Text.ElideRight
            verticalAlignment:Label.AlignVCenter
            horizontalAlignment: Label.AlignLeft
            background: Rectangle{
                id:bkRect
                implicitHeight: parent.height
                implicitWidth: parent.width
                color: "transparent"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    bkRect.color = "#333539"
                }
                onExited: {
                    bkRect.color = "transparent"
                }

                onClicked: {

                }
            }
        }
    }
}
