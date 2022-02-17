import 'package:flutter/material.dart';
import 'package:test_003/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Codigo Test 003',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'EncodeSansSemiCondensed',
      ),
      home: const MainScreen(),
    );
  }
}
