# 🤖 DeepMind AI - Next Gen Chat 2026

![Flutter](https://img.shields.io/badge/Flutter-3.38.9-blue.svg)
![GetX](https://img.shields.io/badge/State_Management-GetX-green.svg)
![AI](https://img.shields.io/badge/Powered_by-SambaNova-orange.svg)

DeepMind AI is a state-of-the-art, premium chat application built with **Flutter 3.38.9**. It features a futuristic **2026 Design Language** and is powered by **SambaNova AI** for lightning-fast, streaming responses.

## ✨ Key Features

- ⚡ **Real-time Streaming**: Watch the AI type responses word-by-word with ultra-low latency.
- 🎨 **Futuristic UI/UX**: Modern glassmorphism, smooth gradients, and premium dark mode aesthetics.
- 🏗️ **Clean Architecture**: Organized into data, modules, and theme layers for maximum scalability.
- 🚀 **GetX State Management**: High-performance state management for a smooth user experience.
- 📱 **Responsive Design**: Pixel-perfect UI on all devices thanks to `flutter_screenutil`.
- 🎬 **Animated Interactions**: Elegant entrance and transition animations using `animate_do`.

## 🛠 Tech Stack

- **Framework**: [Flutter 3.38.9](https://flutter.dev)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **AI Backend**: [SambaNova Cloud](https://sambanova.ai) (Model: `ALLaM-7B-Instruct-preview`)
- **Icons**: [Iconsax](https://pub.dev/packages/iconsax)
- **Fonts**: [Google Fonts (Outfit)](https://fonts.google.com/specimen/Outfit)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.38.9 or higher)
- A SambaNova API Key

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/deepmind-ai-chat.git
   cd deepmind-ai-chat
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Configure API Key**:
   Open `lib/app/utils/constants.dart` and replace the API key with your own:

   ```dart
   static const String aiApiKey = 'YOUR_SAMBANOVA_API_KEY';
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
lib/
├── app/
│   ├── components/    # Reusable UI Widgets (Chat Bubble, etc.)
│   ├── data/          # Models and API Services
│   ├── modules/       # Feature-specific Views, Controllers, and Bindings
│   ├── routes/        # App Pages and Navigation Logic
│   ├── theme/         # Custom Theme and Design System
│   └── utils/         # Constants and Helper Functions
└── main.dart          # App Entry Point
```

## 🤝 Contribution

Contributions are welcome! If you have any ideas to make this even more "2026", feel free to open a PR.

---
