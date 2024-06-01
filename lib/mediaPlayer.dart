import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedMediaPage extends StatefulWidget {
  @override
  _DownloadedMediaPageState createState() => _DownloadedMediaPageState();
}

class _DownloadedMediaPageState extends State<DownloadedMediaPage> {
  List<FileSystemEntity> videos = [];
  List<FileSystemEntity> audios = [];

  @override
  void initState() {
    super.initState();
    _loadDownloadedMedia();
  }

  Future<void> _loadDownloadedMedia() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocumentsDirectory.listSync();

    setState(() {
      videos = files.where((file) => file.path.endsWith('.mp4') || file.path.endsWith('.mov')).toList(); // Common video extensions
      audios = files.where((file) => file.path.endsWith('.mp3') || file.path.endsWith('.wav')).toList(); // Common audio extensions
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloaded Media'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Videos'),
              Tab(text: 'Audios'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMediaList(videos),
            _buildMediaList(audios),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaList(List<FileSystemEntity> mediaFiles) {
    if (mediaFiles.isEmpty) {
      return Center(child: Text('No media found.'));
    }

    return ListView.builder(
      itemCount: mediaFiles.length,
      itemBuilder: (context, index) {
        FileSystemEntity file = mediaFiles[index];
        return ListTile(
          title: Text(file.path.split('/').last),
          // Add functionality for opening or playing the media
        );
      },
    );
  }
}
