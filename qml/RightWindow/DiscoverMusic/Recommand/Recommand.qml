import QtQuick 2.7
import QtQuick.Controls 2.1
import Network 1.0

Item {
    id:item;
    width: 758*dp;
    height: 325*dp;

    Loader{
        id:loader;
        anchors.centerIn: parent;
//        source: "qrc:/qml/RightWindow/DiscoverMusic/Loading.qml";
    }

    Network{
        id:network
        onSig_requestFinish: {
            console.log(bytes)
        }
    }

    // 顶部轮播图
    Rectangle{
       id:root
       color: "transparent"
       width: parent.width
       height: parent.height
       visible: true

        //个性推荐的顶部，使用pathView
        Rectangle{
            id:pathViewRect
            width: root.width
            height: 200*dp
            anchors.left: parent.left
            anchors.top: parent.top
            color: "transparent"

            ListModel{
                id:viewModel
                ListElement{image:"1";imageUrl:"qrc:/images/ABC23.png"}
                ListElement{image:"2";imageUrl:"qrc:/images/ABC23.png"}
                ListElement{image:"3";imageUrl:"qrc:/images/ABC23.png"}
                ListElement{image:"4";imageUrl:"qrc:/images/ABC23.png"}
                ListElement{image:"5";imageUrl:"qrc:/images/ABC23.png"}
            }

            Component{
                id:viewDelegate
                Item{
                    id:wrapper
                    width: parent.width/1.5
                    height: parent.height-20*dp
                    anchors.top: parent.top
                    anchors.topMargin: 10*dp
                    z:PathView.zOrder
                    scale: PathView.itemScale
                    Image {
                        id:image
                        anchors.fill: parent
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: imageUrl
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if(index!==pathView.currentIndex)
                            {
                                pathView.currentIndex=index
                                pageIndicator.currentIndex=index
                            }
                            else
                            {
                                //打开链接
                            }
                        }
                    }
                }
            }

            PathView{
                id:pathView
                anchors.fill: parent
                interactive: true
                currentIndex: pageIndicator.currentIndex
                pathItemCount: 3
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange

                delegate: viewDelegate
                model: viewModel
                path:Path{
                    startX:50*dp
                    startY:0*dp
                    PathAttribute{name:"zOrder";value:0}
                    PathAttribute{name:"itemScale";value:0.2}
                    PathLine{
                        x:pathView.width/4
                        y:0*dp
                    }
                    PathAttribute{name:"zOrder";value:5}
                    PathAttribute{name:"itemScale";value:0.5}
                    PathLine{
                        x:pathView.width/2
                        y:0*dp
                    }
                    PathAttribute{name:"zOrder";value:10}
                    PathAttribute{name:"itemScale";value:1}
                    PathLine{
                        x:pathView.width*0.75
                        y:0*dp
                    }
                    PathAttribute{name:"zOrder";value:5}
                    PathAttribute{name:"itemScale";value:0.5}
                    PathLine{
                        x:pathView.width-50*dp
                        y:0
                    }
                    PathAttribute{name:"zOrder";value:0}
                    PathAttribute{name:"itemScale";value:0.2}
                }
            }

            PageIndicator{
                id:pageIndicator
                interactive: true
                count:pathView.count
                currentIndex: pathView.currentIndex
                height: 7*dp
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: Rectangle{
                    implicitWidth: 20*dp
                    implicitHeight: 2*dp
                    color: "#7F8082"
                    opacity: index === pageIndicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 500
                        }
                    }

                }

                onCurrentIndexChanged: {
                    timer.running=false
                    timer.running=true
                }
            }

            //Timer
            Timer{
                id:timer;
                interval: 7500;
                repeat: true;
                running: false;
                onTriggered: {
                    pageIndicator.currentIndex=(pageIndicator.currentIndex+1)%(pathView.count);
                }
            }

            Component.onCompleted: {
                timer.running=true;
            }
        }
    }


    Component.onCompleted: {
        var url="http://81.68.200.43:8080/hello/" ;
        //var params="hello";
        console.log("开始获取数据...")
        network.getUrlResource2(url,'');
    }
}
