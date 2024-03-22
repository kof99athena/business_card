import 'package:business_card/main_screen.dart';
import 'package:business_card/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'business_card',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(context) => SplashScreen(),
          '/main':(context) => MainScreen(),
        }
    );
  }
}

