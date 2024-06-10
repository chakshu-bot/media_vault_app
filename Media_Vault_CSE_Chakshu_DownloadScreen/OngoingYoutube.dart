import 'package:flutter/material.dart';
import 'package:youtube_data_api/models/video_data.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Video Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YouTubeVideoDetails(),
    );
  }
}

class YouTubeVideoDetails extends StatefulWidget {
  @override
  _YouTubeVideoDetailsState createState() => _YouTubeVideoDetailsState();
}

class _YouTubeVideoDetailsState extends State<YouTubeVideoDetails> {
  TextEditingController _controller = TextEditingController();
  String _videoTitle = '';
  String _videoDescription = '';
  String _thumbnailUrl = '';
  String _channelTitle = '';
  String _viewCount = '';
  String _publishDate = '';
  String? _videoUrl;
  YoutubePlayerController? _youtubeController;
  bool _isPlaying = false;
  //AIzaSyAMjuQoeNMCeCEhXUfbZrq9Ue5WQdrfB6k

  void _fetchVideoDetails(String url) async {
    final videoId = _extractVideoId(url);
    final uri = Uri.https("www.googleapis.com","/youtube/v3/videos",{'part': 'snippet,statistics','id': videoId,'key': 'AIzaSyAMjuQoeNMCeCEhXUfbZrq9Ue5WQdrfB6k'});
    final result = await http.get(uri);
    final body = jsonDecode(result.body);
    final storage_data = body['items'] as List;
    //_thumbnailUrl = storage_data[0]['snippet']['thumbnails']['default']['url'];
    //_channelTitle = storage_data[0]['snippet']['channelTitle'];
    //_viewCount = storage_data[0]['snippet'][]
    //_publishDate = storage_data[0]['snippet']['publishedAt'];
    setState(() {
    _videoTitle = storage_data[0]['snippet']['title'];
    _videoDescription = storage_data[0]['snippet']['description'];
    _thumbnailUrl = storage_data[0]['snippet']['thumbnails']['medium']['url'];
    _channelTitle = storage_data[0]['snippet']['channelTitle'];
    _viewCount = storage_data[0]['statistics']['viewCount'] ?? '0';
    _publishDate = storage_data[0]['snippet']['publishedAt'];
    _videoUrl = url;
    _isPlaying = false; // Ensure video is not playing when details are fetched
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    });
    
  }
 

  String? _extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      if (uri.queryParameters['v'] != null) {
        return uri.queryParameters['v'];
      } else if (uri.pathSegments.contains('shorts')) {
        return uri.pathSegments.last;
      } else if (uri.host == 'youtu.be') {
        return uri.pathSegments.last;
      }
    }
    return null;
  }

  void _playVideo() async {
    if (_youtubeController != null) {
    setState(() {
      _isPlaying = true;
    });
  }
  }

  void _downloadVideo() {
    debugPrint("Download feature not implemented. Redirecting to video URL...");
    _playVideo();
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter YouTube URL',
              ),
              onSubmitted: (url) {
                _fetchVideoDetails(url);
              },
            ),
            SizedBox(height: 20),
            _thumbnailUrl.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _thumbnailUrl,
                            width: 150,
                            height: 90,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 90,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _videoTitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Channel: $_channelTitle',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Views: $_viewCount',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Uploaded: ${_publishDate.split("T")[0]}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
                SizedBox(height: 10),
        if (_isPlaying && _youtubeController != null)
          Container(
            width: double.infinity,
            height: 120,
            child: YoutubePlayer(
              controller: _youtubeController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
                SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: _playVideo,
                                    icon: Icon(Icons.play_arrow),
                                    label: Text("Play"),
                                  ),
                                   SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: _downloadVideo,
                                    icon: Icon(Icons.download),
                                    label: Text("Download"),
                                  ),
                                ],
                              ),
          ],
        ),
      ),
    );
  }
}
