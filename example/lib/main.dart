import 'package:example/env.dart';
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
              defaultEndpoint: 'Chat Example',
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0085FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          appBarTheme: const AppBarThemeData(
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          scaffoldBackgroundColor: const Color(0xFFF1F3F3),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hilol Chat Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HilolChatPage()),
          ),
          child: const Text('Open Chat'),
        ),
      ),
    );
  }
}
