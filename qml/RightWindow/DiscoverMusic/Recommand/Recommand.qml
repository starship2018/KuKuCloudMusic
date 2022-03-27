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
        var url="http://81.68.200.43:8080"      //eapi/batch"";
        var params="0BD8BB39A78692F1744DEFF63EBC30F7FE83CBFBE69FB6E2A494DDC656FCF324992EBC760DFDA29344AB022F1ED1E1AD7F69DF3F9037CDA722EF9C5EC883D149A60E23D0330460A4BE0FE549BBCDFE7621739B66CD0E0C0CCF8405F6AF3F3F103B303EFD0B9AC5E24499ABF75580E51A266873D4ECB04E5BDF0EE5817CBFEFB0203BD3D6ED41272AD353B43D033004929DCACAF754EDC3D1C9DF5720E7389D3FA60E23D0330460A4BE0FE549BBCDFE76207E1DEDCAE9968287C2A3EE7CE1430BA7E74D4B82FE41EC4CCD5ADD46104647B777508B9E46A6831F34F1FE96D4C9CF403A65DC2326932CA692485D7D468112A0E5947E5B721259718EC12B285D54542E50169890D7AB95256E11B944BD4BB88F83E2028B47A3AF99821E6A87AAD0855D08C3EC33AD4C86E3200B98C5E15B787E6ED4DCD758B2C4F348D0571D1BC0FB968487627FC8A7A91D7A1BD818500AB657E2DBB5C19220C20EE55DE2B6B8E0C0DA6346D00362771113455A98A163207CB40A38525BE56CDBC698F73DFC9392BF2CBA6FFE3AC75B245A49E23786EE61FAC3307402FF7D616232727F115F9D96B8FE02282A299C8BD227067BB8F9504B7E0F64D36DE3C199B272CA52E990D4EF534F2BEC7FA1DA7BAFA35265120FF079108DFFDC0470BBA5F748184C58F5F8C3ABA2BBF2700A59B9A7C7BBC9AD2C304E92BE1F8252AFD62C4305B0857C2A9C6B47058835118756D631E676F077E76498532C0484D0ED571ADB3965B5CD14DB6A825B95FA79945EF114B7D62AA943E18ACFACAE01F1A2315E828D4E8EB312409A15C650366172747D774F74A544464B6819693F5F649F0081EBD249BF65B65FB95C4BC2E337620A0A218715DDF3CC87142CC50653ADE8472E50D8512C243986080405285F116F3F746C0EF3CDD353724BA09B7C4B9FEBFE6A1ABB1F1D8ECE0CC0715DBC475FF2A39AC448EF9477D661FD5C75F297C67E95C4ECC18F9643A6139B82FD1C3526167C0230F51D8B1FE10C7E00B11CB1CD371D1CD44818E61166B1E47ACE2035169C8A792CD4AD590A073A4DF21B3BE5365ADEA4D11A8F7EC5BCED5CBDC741BFBBDB8E099323235EF140C1A09CF233ABF4C32EE7FCE81757313FC4CFF9760082D0943217CCF6753205F07EF0D54105D1D5EA7FB191811F142573214EC8760082D0943217CCF6753205F07EF0D55E351148BCA3D0967594207E795AD59DB5187DDA240F7FD7E12E3DA42B8837FE4B6FD099278DCDF94348A5E9ADCF7F856873739EE57D527041F0DEF09A55A985";
        console.log("开始获取数据...")
        network.getUrlResource2(url,"");
    }
}
