#include "network.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>
#include <QDebug>
#include <QUrlQuery>


Network::Network(QObject *parent) : QObject (parent)
{
    networkManager = new QNetworkAccessManager(this);
    connect(networkManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(slot_requestFinish(QNetworkReply*)));
}

Network::~Network()
{

}

void Network::getUrlResource(QString url, QString params)
{
    QNetworkRequest req;
    req.setRawHeader("Content-Type","application/x-www-form-urlencoded");
    req.setRawHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.157 Safari/537.36");
    req.setUrl(url);
    QByteArray data;
    data.append("params="+params);
    networkManager->post(req,data);
}

void Network::getUrlResource2(QString url, QString params)
{
    QNetworkRequest req;
    req.setUrl(url);
    networkManager->get(req);
}

void Network::slot_requestFinish(QNetworkReply *reply)
{
    QByteArray bytes = reply->readAll();
    reply->deleteLater();
    emit sig_requestFinish(bytes);
}
