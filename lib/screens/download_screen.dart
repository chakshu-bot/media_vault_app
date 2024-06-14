import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'play_screen.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List<FileSystemEntity> _mediaFiles = [];

  @override
  void initState() {
    super.initState();
    _loadDownloadedMedia();
  }

  Future<void> _loadDownloadedMedia() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();

    setState(() {
      _mediaFiles = files.where((file) {
        return file.path.endsWith('.mp3');
      }).toList();
    });
  }

  void _playMedia(FileSystemEntity file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayScreen(file: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Downloaded Media')),
        backgroundColor: Colors.green,
      ),
      body: _mediaFiles.isEmpty
          ? const Center(child: Text('No downloaded media found'))
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: _mediaFiles.length,
                itemBuilder: (context, index) {
                  final file = _mediaFiles[index];
                  return ListTile(
                    leading: Icon(file.path.endsWith('.mp4')
                        ? Icons.video_library
                        : Icons.audiotrack),
                    title: Text(file.path.split('/').last),
                    onTap: () => _playMedia(file),
                  );
                },
              ),
            ),
    );
  }
}
