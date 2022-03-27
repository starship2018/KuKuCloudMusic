/*
    顶部栏 【logo 标题 搜索栏 界面最小化、关闭栏】
*/

import QtQuick 2.7
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0


Rectangle{
    id:root
    color:"#222225"

    MouseArea{   // 鼠标拖动事件
        property real xMouse
        property real yMouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        drag.filterChildren: true

        onPressed: {
            xMouse = mouse.x
            yMouse = mouse.y
        }

        onPositionChanged: {
            mainWindow.x = mainWindow.x + (mouse.x - xMouse)
            mainWindow.y = mainWindow.y + (mouse.y - yMouse)
        }
    }


    Image {
        id: icon
        source: "qrc:/images/logo.ico"
        width: 25*dp
        height:25*dp
        rotation: 0
        anchors{
            left: parent.left
            leftMargin: 10*dp
            verticalCenter: parent.verticalCenter
        }
        NumberAnimation on rotation{
            id:icoSeftRotate
            from:0
            to:360
            duration :2500
            loops: Animation.Infinite   // 无线循环动画
            easing{type: Easing.InOutQuad}
        }
    }

    Label{
        id:title
        anchors{
            left : icon.right
            leftMargin: 16*dp
            verticalCenter: parent.verticalCenter
        }
        text: qsTr("酷酷音乐")  // 注意！富文本形式可能不不会显示！  <font color=\"white\">网易云音乐</font>
        font{
            family: "Microsoft YaHei"
            pixelSize: 16*dp
            bold:true

        }
        color: "white"
    }

    Rectangle{
        id:leftrightBar
        width: 80*dp
        height: 22*dp
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: title.right
        anchors.leftMargin: 40*dp
        color: "transparent"
        radius: 1*dp

        TitleBarBtn{
            id:backBtn
            btnWidth: parent.width/2.0-5*dp;
            btnHeight: parent.height-2*dp;
            anchors{
                left: parent.left;
                leftMargin: 1*dp;
                verticalCenter: parent.verticalCenter;
            }
            btnImgSrc: "qrc:/images/back.png"
            btnImgSrc_hover_press: "qrc:/images/back_hover.png"
            hovered_bgColor: "#d2d2d3";
            toolTip: qsTr("后退");
            backgroundColor: "#212124";
            btnClicked: function(){
                console.log("backBtn clicked");
            }
        }

        TitleBarBtn{
            id:forwardBtn
            anchors{
                right: parent.right;
                rightMargin: 10*dp;
                verticalCenter: parent.verticalCenter;
            }
            btnWidth: parent.width/2.0-5*dp;
            btnHeight: parent.height-2*dp;
            btnImgSrc: "qrc:/images/front.png"
            btnImgSrc_hover_press: "qrc:/images/front_hover.png"
            hovered_bgColor: "#d2d2d3";
            toolTip: qsTr("前进");
            backgroundColor: "#212124";
            btnClicked: function(){
                console.log("forwardBtn clicked");
            }
        }
    }


    Rectangle{
        id:searchBar
        width: 230*dp
        height: 30*dp
        anchors{
            left: leftrightBar.right
            leftMargin: 20*dp
            verticalCenter: parent.verticalCenter
        }
        radius: 8*dp
        color: "#151517"

        TitleBarBtn{
            id:searchBtn
            anchors.verticalCenter: parent.verticalCenter
            btnImgSrc: "qrc:/images/search.png"
            btnImgSrc_hover_press: "qrc:/images/search_hover.png"
            btnWidth: 18*dp
            btnHeight: 18*dp
            anchors.left: parent.left
            anchors.leftMargin: 10*dp
            toolTip: qsTr("搜索")
            backgroundColor: "transparent"
            btnClicked: function(){
                searchText.focus=false
//                if(searchText.text.length>0)
//                {
//                    leftWdReset();
//                    rightWdRouter("qrc:/qml/RightWindow/SearchWindow/SearchWindow.qml",{"params":searchText.text});
//                }
            }
        }

        TextField{
            id:searchText
            width: searchBar.width - 20*dp
            height: searchBar.height
            anchors{
                left: searchBtn.right
                leftMargin: 3*dp
            }
            font{
                family: "Microsoft Yahei"
                pixelSize: 13*dp
            }
            verticalAlignment: TextInput.AlignVCenter
            placeholderText: qsTr("搜索音乐、歌手、歌手、用户");
            color: "white";
            placeholderTextColor: "#454546"
            background: Rectangle{
                width: parent.width
                height: parent.height
                radius: 5*dp
                color: "transparent"
            }

            Keys.enabled: true
            Keys.onReturnPressed: {
                searchBtn.btnClicked();
            }
            onActiveFocusChanged: {
                if(activeFocus){
                    if(text.length===0)
                        searchDlg.open();
                }else
                    searchDlg.close();
            }

            onTextChanged: {
                if(text.length>0)
                    searchDlg.close();
                else
                    searchDlg.open();
            }
        }

        Popup{    // 弹出组件！
            topMargin: searchBar.height+10*dp
            id:searchDlg
            visible: false
            width: 230*dp
            height: 169*dp   // 发现一个BUG 在一个屏幕上正常，在另一个屏幕上显示异常！
            background :Loader{
                source:"qrc:/qml/TitleBar/SearchRect.qml"
            }
        }
    }


    Row{  // 右上角 按钮
        anchors.right: parent.right
        anchors.rightMargin: 10*dp
        height: parent.height
        spacing: 10*dp

        TitleBarBtn{
            id:minBtn
            anchors.verticalCenter: parent.verticalCenter
            bBtnBounceAni: true
            btnHeight: 12*dp
            btnWidth: 12*dp
            btnImgSrc: "qrc:/images/min.png"
            btnImgSrc_hover_press: "qrc:/images/min_hover.png"
            hovered_bgColor: "#d2d2d3";
            toolTip: qsTr("最小化");
            backgroundColor: "#212124";
            btnClicked: function(){
                mainWindow.visibility = Window.Minimized;  // 后续开发窗口最小化动画！
            }

        }

        TitleBarBtn{
            id:closeBtn
            anchors.verticalCenter: parent.verticalCenter
            bBtnRotateAni: true
            btnHeight: 12*dp
            btnWidth: 12*dp
            btnImgSrc: "qrc:/images/close.png"
            btnImgSrc_hover_press: "qrc:/images/close_hover.png"
            hovered_bgColor: "#d2d2d3";
            toolTip: qsTr("关闭");
            backgroundColor: "#212124";
            btnClicked: function(){
                Qt.quit();
            }
        }
    }


}
