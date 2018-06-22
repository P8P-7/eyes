#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTextStream>
#include <QQuickView>

#include <MessageCarrier.pb.h>
#include <goliath/zmq-messaging.h>

#include "emotion_handler.h"

using namespace goliath;

int main(int argc, char *argv[]) {
    zmq::context_t context(1);
    messaging::ZmqSubscriber subscriber(context, "localhost", 5556);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<eyes::EmotionHandler>("goliath.eyes", 1, 0, "EmotionHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/resources/main.qml")));

    QObject *root = engine.rootObjects().value(0);

    auto *emotion = root->findChild<eyes::EmotionHandler*>("emotion");

    emotion->setEmotion(eyes::EmotionHandler::EmotionValue::ANGRY);

    subscriber.bind(proto::MessageCarrier::MessageCase::kSynchronizeMessage, [&emotion](const proto::MessageCarrier &carrier){
        for (const auto &message : carrier.synchronizemessage().messages()) {
            if (message.Is<proto::repositories::EmotionRepository>()) {
                proto::repositories::EmotionRepository emotionRepository;
                message.UnpackTo(&emotionRepository);

                emotion->setEmotion(emotionRepository.emotion());
            }
        }
    });

    return QGuiApplication::exec();
}
