#pragma once

#include <QObject>

#include <repositories/EmotionRepository.pb.h>

namespace goliath::eyes {
    class EmotionHandler : public QObject {
    Q_OBJECT
    Q_PROPERTY(EmotionValue emotion READ emotion WRITE setEmotion NOTIFY emotionChanged)

    public:
        // Sadly no better solution...
        // See https://forum.qt.io/topic/77111/expose-an-enum-from-a-non-qobject-member-variable-to-qml/7
        enum EmotionValue {
            NEUTRAL = proto::repositories::EmotionRepository::NEUTRAL,
            ANGRY = proto::repositories::EmotionRepository::ANGRY,
            SAD = proto::repositories::EmotionRepository::SAD,
            SUPRISED = proto::repositories::EmotionRepository::SUPRISED,
            HAPPY = proto::repositories::EmotionRepository::HAPPY,
            WINK_LEFT = proto::repositories::EmotionRepository::WINK_LEFT,
            WINK_RIGHT = proto::repositories::EmotionRepository::WINK_RIGHT
        };

        Q_ENUM(EmotionValue)

        EmotionHandler();

        void setEmotion(const EmotionValue &emotion);
        void setEmotion(const proto::repositories::EmotionRepository::Emotion &emotion);

        EmotionValue emotion() const;

    signals:
        void emotionChanged();

    private:
        EmotionValue m_emotion;

    };
}