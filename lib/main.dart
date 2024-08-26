import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:chat_app3/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode:ThemeMode.light,
      home: LoginScreen(),
    );
  }
}
