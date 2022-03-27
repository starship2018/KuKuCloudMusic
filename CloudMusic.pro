QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    main.cpp \
    main.cpp \
    cpp/Network/network.cpp \
    cpp/audiodata.cpp \
    main.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/LeftWindow/LeftMusicListItem.qml \
    qml/LeftWindow/LeftMusicListItem.qml \
    qml/Utils/CircularImage.qml \
    main.qml \
    qml/BottomWindow/BottomWindow.qml \
    qml/BottomWindow/BtnPlay.qml \
    qml/BottomWindow/CustomSlider.qml \
    qml/BottomWindow/CustomSwitch.qml \
    qml/BottomWindow/SliderPlay.qml \
    qml/BottomWindow/SoundEffect.qml \
    qml/RightWindow/Developing.qml \

HEADERS += \
    cpp/Network/network.h \
    cpp/audiodata.h \

