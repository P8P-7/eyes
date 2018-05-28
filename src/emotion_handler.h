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
            NEUTRAL = Emotion::NEUTRAL,
            ANGRY = Emotion::ANGRY,
            SAD = Emotion::SAD,
            SUPRISED = Emotion::SUPRISED,
            HAPPY = Emotion::HAPPY,
            WINK_LEFT = Emotion::WINK_LEFT,
            WINK_RIGHT = Emotion::WINK_RIGHT
        };

        Q_ENUM(EmotionValue)

        EmotionHandler();

        void setEmotion(const EmotionValue &emotion);
        void setEmotion(const Emotion &emotion);

        EmotionValue emotion() const;

    signals:
        void emotionChanged();

    private:
        EmotionValue m_emotion;

    };
}