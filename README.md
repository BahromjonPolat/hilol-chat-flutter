# Hilol Chat Flutter

A Flutter package for integrating Hilol chat functionality into your Flutter applications. This package provides a ready-to-use chat interface with real-time messaging capabilities powered by the FCRM Chat SDK.

## Features

- **Real-time messaging** - Socket-based communication for instant message delivery
- **User registration** - Built-in user authentication and registration flow
- **Chat UI** - Pre-built, customizable chat interface with message bubbles
- **Media support** - Send and receive images and files
- **BLoC architecture** - State management using flutter_bloc
- **Customizable theming** - Adapt the chat UI to match your app's design
- **Message editing** - Edit sent messages
- **In-app notifications** - Overlay-based notification banners when new messages arrive outside the chat page
- **Multi-language support** - Built-in translations for Uzbek, Russian, English, Turkish, and more

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  hilol_chat_flutter:
    git:
      url: https://github.com/BahromjonPolat/hilol-chat-flutter.git
      ref: main
```

Then run:

```bash
flutter pub get
```

## Getting Started

### 1. Platform Configuration

#### iOS Configuration

Add the following to your `ios/Runner/Info.plist` file to enable phone call functionality:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>tel</string>
</array>
```

#### Android Configuration

Add the following to your `android/app/src/main/AndroidManifest.xml` file:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <queries>
        <intent>
            <action android:name="android.intent.action.DIAL" />
        </intent>
    </queries>
</manifest>
```

### 2. Environment Variables

Create an `env.dart` file to store your credentials securely using `String.fromEnvironment`:

```dart
abstract final class Env {
  const Env._();
  static const baseUrl = String.fromEnvironment('BASE_URL');
  static const companyToken = String.fromEnvironment('COMPANY_TOKEN');
  static const appKey = String.fromEnvironment('APP_KEY');
  static const appSecret = String.fromEnvironment('APP_SECRET');
  static const socketUrl = String.fromEnvironment('SOCKET_URL');
}
```

Then run your app with:

```bash
flutter run \
  --dart-define=BASE_URL=your_base_url \
  --dart-define=COMPANY_TOKEN=your_token \
  --dart-define=APP_KEY=your_key \
  --dart-define=APP_SECRET=your_secret \
  --dart-define=SOCKET_URL=your_socket_url
```

### 3. Initialize and Use

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HilolChatBloc()
        ..add(
          HilolChatEvent.initialize(
            config: HilolChatConfig(
              baseUrl: Env.baseUrl,
              companyToken: Env.companyToken,
              appKey: Env.appKey,
              appSecret: Env.appSecret,
              socketUrl: Env.socketUrl,
              enableLogging: kDebugMode,
              defaultEndpoint: 'Support Chat',
              navigatorKey: _navigatorKey,
              onNotificationTap: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(builder: (_) => const HilolChatPage()),
                );
              },
            ),
          ),
        ),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0085FF),
          cardColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xFFF1F3F3),
        ),
        home: const HomePage(),
      ),
    );
  }
}
```

> **Note:** `lazy: false` ensures the BLoC initializes immediately when the app starts, enabling real-time notifications even before the chat page is opened.

### 4. Navigate to Chat Page

```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const HilolChatPage()),
);
```

### 5. Pre-fill User Data (Optional)

If you already have user information, pass it during initialization to skip the registration form:

```dart
HilolChatEvent.initialize(
  config: HilolChatConfig(...),
  userData: HilolChatRegisterModel(
    name: 'John Doe',
    email: 'john@example.com',
    phone: '+998901234567',
  ),
)
```

## Configuration

### HilolChatConfig

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `baseUrl` | `String` | Yes | API base URL |
| `companyToken` | `String` | Yes | Your company's unique token |
| `appKey` | `String` | Yes | Application key |
| `appSecret` | `String` | Yes | Application secret |
| `socketUrl` | `String` | No | WebSocket server URL |
| `defaultEndpoint` | `String` | No | Default chat endpoint name |
| `enableLogging` | `bool` | No | Enable SDK logging (default: `false`) |
| `connectionTimeout` | `Duration` | No | Connection timeout duration |
| `navigatorKey` | `GlobalKey<NavigatorState>` | No | Navigator key for in-app notification overlay |
| `onNotificationTap` | `void Function()` | No | Callback when user taps on a notification banner |

### Theme Customization

Customize the chat appearance through `ThemeData`:

```dart
ThemeData(
  primaryColor: Colors.blue,           // Sender message bubble color
  cardColor: Colors.white,             // Receiver message bubble color
  scaffoldBackgroundColor: Color(0xFFF1F3F3), // Chat background
  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
)
```

## Architecture

This package uses the **BLoC** pattern for state management:

- `HilolChatBloc` - Manages chat messages, user state, and real-time communication
- `HilolChatEvent` - Events for chat operations (initialize, send message, load history, edit message, etc.)
- `HilolChatState` - Chat state including messages, registration status, and upload progress

## Dependencies

- `fcrm_chat_sdk` - Core SDK for Hilol chat functionality
- `flutter_bloc` - State management
- `cached_network_image` - Image caching
- `image_picker` - Image selection from gallery/camera
- `file_picker` - File attachment support
- `svg_flutter` - SVG icon rendering

## Requirements

- Flutter SDK: >=1.17.0
- Dart SDK: >=3.0.0 <4.0.0

## Author

Created by Bakhromjon Polat
