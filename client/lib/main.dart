import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/login.dart';
import 'package:flutter_chat_app/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
  // Future.delayed(const Duration(seconds: 3), () {
  //   runApp(const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: LoginPage(),
  //   ));
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
