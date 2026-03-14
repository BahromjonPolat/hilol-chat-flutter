# Hilol Chat Flutter

A Flutter package for integrating Hilol chat functionality into your Flutter applications. This package provides a ready-to-use chat interface with real-time messaging capabilities powered by the FCRM Chat SDK.

## Features

- **Real-time messaging** - Socket-based communication for instant message delivery
- **User registration** - Built-in user authentication and registration flow
- **Chat UI** - Pre-built, customizable chat interface with message bubbles
- **Media support** - Send and receive images and files
- **BLoC architecture** - State management using flutter_bloc
- **Customizable theming** - Adapt the chat UI to match your app's design
- **Message status** - Delivery and read receipts
- **Avatar support** - User profile pictures and online status indicators

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

This allows the app to check if the device can make phone calls and open the phone dialer when the call button is tapped in the chat interface.

#### Android Configuration

Add the following permission to your `android/app/src/main/AndroidManifest.xml` file:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Add this inside the manifest tag -->
    <queries>
        <intent>
            <action android:name="android.intent.action.DIAL" />
        </intent>
    </queries>

    <!-- Rest of your manifest -->
</manifest>
```

**Note:** The package uses `url_launcher` for phone call functionality. No additional permissions are required as the app only opens the phone dialer with a pre-filled number - the user must manually initiate the actual call.

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
flutter run --dart-define=BASE_URL=your_base_url --dart-define=COMPANY_TOKEN=your_token --dart-define=APP_KEY=your_key --dart-define=APP_SECRET=your_secret --dart-define=SOCKET_URL=your_socket_url
```

### 3. API Configuration

Obtain the following credentials from your Hilol dashboard to configure `HilolChatConfig`:
- `baseUrl` - API base URL (required)
- `companyToken` - Your company's unique token (required)
- `appKey` - Application key (required)
- `appSecret` - Application secret (required)
- `socketUrl` - WebSocket server URL (optional)
- `defaultEndpoint` - Default chat endpoint name (optional)
- `enableLogging` - Enable SDK logging (optional, default: false)
- `connectionTimeout` - Connection timeout duration (optional)
- `navigatorKey` - GlobalKey for navigator state, used for in-app notification navigation (optional)
- `onNotificationTap` - Callback when user taps on a chat notification (optional)

### 4. Initialize the BLoC

Wrap your app with `MultiBlocProvider` and initialize the `HilolChatBloc`:

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
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
                      MaterialPageRoute(
                        builder: (_) => const HilolChatPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF0085FF),
          scaffoldBackgroundColor: Color(0xFFF1F3F3),
        ),
        home: HomePage(),
      ),
    );
  }
}
```

> **Note:** `lazy: false` ensures the BLoC initializes immediately when the app starts, enabling real-time notifications even before the chat page is opened.

### 5. Navigate to Chat Page

To open the chat interface, navigate to `HilolChatPage`:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => HilolChatPage(),
  ),
);
```

## Usage Example

Here's a complete example:

```dart
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HilolChatPage(),
              ),
            );
          },
          child: Text('Open Chat'),
        ),
      ),
    );
  }
}
```

## Customization

### Theme Customization

You can customize the chat appearance by setting theme properties in your `MaterialApp`:

```dart
MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blue, // Sender message bubble color
    cardColor: Colors.white, // Receiver message bubble color
    scaffoldBackgroundColor: Color(0xFFF1F3F3), // Chat background
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  ),
  // ...
)
```

### Custom Widgets

The package exports reusable widgets that you can use in your custom implementations:

```dart
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';

// Available widgets:
// - HilolChatBubble: Message bubble widget
// - HilolChatSenderAvatar: User avatar with online status
// - HilolChatInput: Message input field with attachment options
```

## Architecture

This package uses the **BLoC (Business Logic Component)** pattern for state management:

- `HilolChatBloc` - Manages chat messages, user state, and real-time communication
- `HilolChatEvent` - Events for chat operations (send message, load history, etc.)
- `HilolChatState` - Chat state (loading, success, error states)

## Dependencies

This package relies on:
- `fcrm_chat_sdk` - Core SDK for Hilol chat functionality
- `flutter_bloc` - State management
- `cached_network_image` - Image caching
- `image_picker` - Image selection from gallery/camera
- `file_picker` - File attachment support
- `svg_flutter` - SVG icon rendering

## Requirements

- Flutter SDK: >=1.17.0
- Dart SDK: ^3.10.0

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Support

For issues, questions, or feature requests, please open an issue on the GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created by Bakhromjon Polat

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.
