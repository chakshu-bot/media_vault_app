import 'package:flutter/material.dart';
import 'package:media_vault/screens/search_screen.dart';
import 'package:media_vault/screens/convert_screen.dart';
import 'package:media_vault/screens/download_screen.dart';
import 'package:media_vault/screens/play_screen.dart';
import 'package:media_vault/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/': (context) => SplashScreen(),
        '/seach': (context) => SearchScreen(),
        '/convert': (context) => ConvertScreen(),
        '/download': (context) => DownloadScreen(),
        '/play': (context) => PlayScreen(),
      },
    );
  }
}
