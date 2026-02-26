import 'package:example/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final pref = await SharedPreferences.getInstance();
  // await pref.clear();
  runApp(const MyApp());
}

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
                  defaultEndpoint: 'Chat Example',
                ),
              ),
            ),
          child: Container(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF0085FF),
          cardColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0085FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
          ),
          appBarTheme: AppBarThemeData(
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),

          // primaryColor: const Color.fromARGB(255, 52, 148, 55),
          scaffoldBackgroundColor: Color(0xFFF1F3F3),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 16,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HilolChatPage())),
              child: Text('Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
