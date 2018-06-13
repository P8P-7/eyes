#pragma once

#include <QObject>

#include <EmotionMessage.pb.h>

namespace goliath::eyes {
    class EmotionHandler : public QObject {
    Q_OBJECT
    Q_PROPERTY(EmotionValue emotion READ emotion WRITE setEmotion NOTIFY emotionChanged)

    public:
        // Sadly no better solution...
        // See https://forum.qt.io/topic/77111/expose-an-enum-from-a-non-qobject-member-variable-to-qml/7
        enum EmotionValue {
            NEUTRAL = proto::Emotion::NEUTRAL,
            ANGRY = proto::Emotion::ANGRY,
            SAD = proto::Emotion::SAD,
            SUPRISED = proto::Emotion::SUPRISED,
            HAPPY = proto::Emotion::HAPPY,
            WINK_LEFT = proto::Emotion::WINK_LEFT,
            WINK_RIGHT = proto::Emotion::WINK_RIGHT
        };

        Q_ENUM(EmotionValue)

        EmotionHandler();

        void setEmotion(const EmotionValue &emotion);
        void setEmotion(const proto::Emotion &emotion);

        EmotionValue emotion() const;

    signals:
        void emotionChanged();

    private:
        EmotionValue m_emotion;

    };
}