import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class DownloadedMediaPage extends StatefulWidget {
  @override
  _DownloadedMediaPageState createState() => _DownloadedMediaPageState();
}

class _DownloadedMediaPageState extends State<DownloadedMediaPage> {
  List<FileSystemEntity> videos = [];
  List<FileSystemEntity> audios = [];
  VideoPlayerController? _videoPlayerController;
  AudioPlayer? _audioPlayer;
  StreamSubscription<Duration>? _durationSubscription;
  Duration _currentPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadDownloadedMedia();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _audioPlayer?.dispose();
    _durationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadDownloadedMedia() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocumentsDirectory.listSync();

    setState(() {
      videos = files.where((file) => file.path.endsWith('.mp4') || file.path.endsWith('.mov')).toList();
      audios = files.where((file) => file.path.endsWith('.mp3') || file.path.endsWith('.wav')).toList();
    });
  }

  void _playMedia(String filePath, bool videoType) async {
    try {
      if (videoType) {
        _videoPlayerController = VideoPlayerController.file(File(filePath));
        await _videoPlayerController!.initialize();
        await _videoPlayerController!.play();
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
            _videoPlayerController!.dispose();
            setState(() {});
          }
        });
      } else {
        _audioPlayer = AudioPlayer();
        await _audioPlayer!.play(DeviceFileSource(filePath));

        _audioPlayer!.onDurationChanged.listen((duration) {
          setState(() => _audioDuration = duration);
        });
        _durationSubscription = _audioPlayer!.onPositionChanged.listen((position) {
          setState(() => _currentPosition = position);
        });

        _audioPlayer!.onPlayerComplete.listen((event) {
          _audioPlayer!.dispose();
          setState(() {
            _currentPosition = Duration.zero;
          });
        });
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing media: $e')),
      );
    }
  }

  Widget _buildMediaControls(dynamic controller, {required bool isVideo}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.replay_10),
            onPressed: () {
              if (isVideo) {
                _videoPlayerController!.seekTo(
                  _videoPlayerController!.value.position - Duration(seconds: 10),
                );
              } else {
                Duration newPosition = _currentPosition - Duration(seconds: 10);
                _audioPlayer!.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
              }
            },
          ),
          IconButton(
            icon: Icon(isVideo ? Icons.play_arrow : Icons.play_circle),
            onPressed: () => isVideo ? _videoPlayerController!.play() : _audioPlayer!.resume(),
          ),
          IconButton(
            icon: Icon(isVideo ? Icons.pause : Icons.pause_circle),
            onPressed: () => isVideo ? _videoPlayerController!.pause() : _audioPlayer!.pause(),
          ),
          IconButton(
            icon: Icon(Icons.forward_10),
            onPressed: () {
              if (isVideo) {
                _videoPlayerController!.seekTo(
                  _videoPlayerController!.value.position + Duration(seconds: 10),
                );
              } else {
                _audioPlayer!.seek(_currentPosition + Duration(seconds: 10));
              }
            },
          ),
          if (!isVideo)
            Expanded(
              child: Slider(
                value: _currentPosition.inSeconds.toDouble(),
                min: 0,
                max: _audioDuration.inSeconds.toDouble(),
                onChanged: (double value) {
                  Duration newPosition = Duration(seconds: value.toInt());
                  _audioPlayer!.seek(newPosition);
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloaded Media'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Videos'),
              Tab(text: 'Audios'),
            ],
          ),
        ),
        body: _videoPlayerController != null && _videoPlayerController!.value.isInitialized
            ? Column(
          children: [
            AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController!),
            ),
            VideoProgressIndicator(_videoPlayerController!, allowScrubbing: true),
            _buildMediaControls(_videoPlayerController!, isVideo: true),
          ],
        )
            : _audioPlayer != null
            ? _buildMediaControls(_audioPlayer!, isVideo: false)
            : TabBarView(
          children: [
            _buildMediaList(videos, videoType: true),
            _buildMediaList(audios, videoType: false),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaList(List<FileSystemEntity> mediaFiles, {required bool videoType}) {
    if (mediaFiles.isEmpty) {
      return Center(
        child: Text('No media found.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      );
    }

    return ListView.builder(
      itemCount: mediaFiles.length,
      itemBuilder: (context, index) {
        FileSystemEntity file = mediaFiles[index];
        return CustomListTile(
          title: file.path.split('/').last,
          onTap: () => _playMedia(file.path, videoType),
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(title.endsWith('.mp4') || title.endsWith('.mov') ? Icons.video_library : Icons.audiotrack),
        title: Text(title),
        trailing: Icon(Icons.play_arrow),
        onTap: onTap,
      ),
    );
  }
}
