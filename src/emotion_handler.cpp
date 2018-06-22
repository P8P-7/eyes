#include "emotion_handler.h"

using namespace goliath;

eyes::EmotionHandler::EmotionHandler()
        : m_emotion(EmotionValue::NEUTRAL) {
}

eyes::EmotionHandler::EmotionValue eyes::EmotionHandler::emotion() const {
    return m_emotion;
}

void eyes::EmotionHandler::setEmotion(const EmotionValue& emotion) {
    m_emotion = emotion;
    emit emotionChanged();
}

void eyes::EmotionHandler::setEmotion(const proto::repositories::EmotionRepository::Emotion& emotion) {
    setEmotion(static_cast<EmotionValue>(emotion));
}
