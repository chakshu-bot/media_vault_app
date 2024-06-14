import 'package:flutter/material.dart';
import 'package:media_vault/screens/onboarding_screen.dart';
import 'package:media_vault/screens/search_screen.dart';
import 'package:media_vault/screens/convert_screen.dart';
import 'package:media_vault/screens/download_screen.dart';
import 'package:media_vault/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Vault',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding(),
        '/splash': (context) => const SplashScreen(),
        '/seach': (context) => const SearchScreen(),
        '/convert': (context) => const ConvertScreen(),
        '/download': (context) => const DownloadScreen(),
        
      },
    );
  }
}
