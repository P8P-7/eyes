#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTextStream>
#include <QQuickView>

#include <MessageCarrier.pb.h>
#include <goliath/zmq-messaging.h>

#include "emotion_handler.h"

using namespace goliath;

static void show_usage(const std::string &name) {
    std::cerr << "Usage: " << name << " <option(s)> ARGUMENT\n"
              << "Options:\n"
              << "\t-h,--help\t\tShow this help message\n"
              << "\t-b,--broker IP\t\tSpecify the broker ip-address\n";
}

int main(int argc, char *argv[]) {
    const char *brokerAdress = "127.0.0.1";

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if ((arg == "-h") || (arg == "--help")) {
            show_usage(argv[0]);
            return 0;
        }
        if ((arg == "-b") || (arg == "--broker")) {
            if (i + 1 < argc) {
                i++;
                brokerAdress = argv[i];
            } else {
                std::cerr << "--broker option requires one argument." << std::endl;
                return 1;
            }
        }
    }

    zmq::context_t context(1);
    messaging::ZmqSubscriber subscriber(context, brokerAdress, 5556);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<eyes::EmotionHandler>("goliath.eyes", 1, 0, "EmotionHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/resources/main.qml")));

    QObject *root = engine.rootObjects().value(0);

    auto *emotion = root->findChild<eyes::EmotionHandler *>("emotion");

    // Start emotion
    emotion->setEmotion(eyes::EmotionHandler::EmotionValue::ANGRY);

    subscriber.bind(proto::MessageCarrier::MessageCase::kSynchronizeMessage,
                    [&emotion](const proto::MessageCarrier &carrier) {
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
