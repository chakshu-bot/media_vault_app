import 'package:flutter/material.dart';
import 'mediaPlayer.dart';

void main() {
  runApp(MyApp());
}

// MyApp class definition
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Vault',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// HomeScreen class (remains the same)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media Vault"),),
      body: Center(
        child: Text("Our First Team Project 'Media Vault'"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DownloadedMediaPage()),
          );
        },
        label: Text('Open Media Vault'),
        icon: Icon(Icons.folder_open),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

