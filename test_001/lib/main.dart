import 'package:flutter/material.dart';
import 'package:test_001/screens/register_screen.dart';

import 'screens/main_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Codigo Test 001',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Chivo',
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => const MainScreen(),
      },
      home: const WelcomeScreen(),
    );
  }
}
