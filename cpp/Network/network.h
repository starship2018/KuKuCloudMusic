#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QVariant>
class QNetworkReply;
class QNetworkAccessManager;

class Network : public QObject
{
    Q_OBJECT
public:
    explicit Network(QObject *parent = nullptr);   //  这里的默认函数必须指定！
    ~Network();

    Q_INVOKABLE void getUrlResource(QString url,QString params);   // 使用Q_INVOKABLE关键字来修饰函数，使其能够在QML中被直接调用
    Q_INVOKABLE void getUrlResource2(QString url,QString params);

signals:
    void sig_requestFinish(QVariant bytes);  // 此信号的响应直接在qml中执行！
public slots:
    void slot_requestFinish(QNetworkReply*); // QNetAccessManager 的 请求结束槽函数，发射信号sig_requestFinish()

private:
    QNetworkAccessManager *networkManager;
};

#endif // NETWORK_H
