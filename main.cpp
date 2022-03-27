#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "cpp/Network/network.h"
//#include "cpp/audiodata.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Network>("Network",1,0,"Network");   // 注册Network类型到Qt元对象系统中
    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty("AudioData",new AudioData);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
