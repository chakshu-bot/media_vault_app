// play_screen.dart

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayScreen extends StatefulWidget {
  final FileSystemEntity file;

  const PlayScreen({required this.file});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  VideoPlayerController? _videoPlayerController;
  AudioPlayer? _audioPlayer;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    if (widget.file.path.endsWith('.mp4')) {
      _isVideo = true;
      _videoPlayerController = VideoPlayerController.file(File(widget.file.path))
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.play();
        });
    } else {
      _audioPlayer = AudioPlayer();
      _audioPlayer!.play(DeviceFileSource(widget.file.path));
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isVideo ? 'Playing Video' : 'Playing Audio'),
      ),
      body: Center(
        child: _isVideo
            ? _videoPlayerController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController!),
                  )
                : const CircularProgressIndicator()
            : const Text('Playing Audio'),
      ),
    );
  }
}
