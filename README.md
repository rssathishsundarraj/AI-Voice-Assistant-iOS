# 🎤 AI Voice Assistant (iOS)

A SwiftUI-based voice assistant that converts speech to text, processes it using AI, and responds with natural voice output.

This project demonstrates real-time audio processing, clean architecture, and AI integration in an iOS application.

---

## 🚀 Features

* 🎤 **Speech-to-Text**
  Capture user voice input using Apple's Speech framework.

* 🤖 **AI-Powered Responses**
  Processes user input using AI (Google Gemini API).

* 🔊 **Text-to-Speech**
  Converts AI responses into natural voice output using AVFoundation.

* ⚡ **Real-Time Interaction**
  Seamless flow from voice input → AI → voice response.

* 🧱 **Clean Architecture**
  Separation of concerns using Presentation, Domain, and Data layers.

---

## 🛠 Tech Stack

* **SwiftUI** – UI development
* **AVFoundation** – Audio playback (TTS)
* **Speech Framework** – Speech recognition
* **URLSession** – Network calls
* **Google Gemini API** – AI responses
* **Swift Concurrency (async/await)**

---

## 🧠 Architecture

This project follows **Clean Architecture**:

```
Presentation (UI + ViewModel)
        ↓
Domain (UseCases + Entities)
        ↓
Data (API + Models)
```

### Key Principles:

* Domain layer is independent of external APIs
* API models are isolated in Data layer
* Easy to switch AI providers (OpenAI → Gemini)

---

## 🔄 AI Integration

Initially, the app was designed to use the OpenAI API.
However, due to API key limitations, the integration was switched to **Google Gemini API**, which is currently used for generating responses.

The architecture allows easy replacement of AI providers without affecting other layers.

---

## 📸 Demo

> 🎥 Add your demo video or GIF here
> Example flow:

1. Tap microphone
2. Speak input
3. Text appears
4. AI responds
5. Voice output plays

---

## ⚙️ Setup Instructions

1. Clone the repository
2. Open in Xcode
3. Add your Gemini API key:

```swift
private let apiKey = "YOUR_API_KEY"
```

4. Run on a real device (Speech + Audio required)

---

## ⚠️ Notes

* Speech recognition works best on a real device
* Internet connection is required for AI responses
* API keys are not included for security reasons

---

## 💡 Future Improvements

* Streaming AI responses
* Conversation history (context awareness)
* Voice selection options
* Improved UI/UX animations

---

## 👨‍💻 Author

Sathish Kumar RS

---

## 📌 Summary

This project showcases:

* Real-time voice processing
* AI integration
* Clean architecture design
* Production-level Swift development practices

---

⭐ If you found this useful, feel free to star the repo!
