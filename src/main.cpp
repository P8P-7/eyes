#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTextStream>
#include <QQuickView>

#include <MessageCarrier.pb.h>
#include <goliath/zmq_messaging.h>

#include "emotion_handler.h"

using namespace goliath;

int main(int argc, char *argv[])  {
    zmq::context_t context(1);
    messaging::ZmqSubscriber subscriber(context, "localhost", 5558);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<eyes::EmotionHandler>("goliath.eyes", 1, 0, "EmotionHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/resources/main.qml")));

    QObject *root = engine.rootObjects().value(0);

    eyes::EmotionHandler *emotion = root->findChild<eyes::EmotionHandler*>("emotion");

    emit emotion->emotionChanged();

    emotion->setEmotion(::ANGRY);

    emit emotion->emotionChanged();

    return app.exec();
}
