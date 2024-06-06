import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(final_data: [
         downloaded_video_data(
      title: 'Flutter Tutorial',
      channel_name: 'Tech Channel',
      views: '1M views',
      uploaded_time: '1 year ago',
      image_uri: Uri.parse('https://example.com/image.jpg'),
    ),
      ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class downloaded_video_data {
  final String title;
  final String channel_name;
  final String views;
  final String uploaded_time;
  final Uri image_uri;

  downloaded_video_data({
    required this.title,
    required this.channel_name,
    required this.uploaded_time,
    required this.views,
    required this.image_uri,
  });

  // Convert a downloaded_video_data into a Map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'channel_name': channel_name,
        'views': views,
        'uploaded_time': uploaded_time,
        'image_uri': image_uri.toString(),
      };

  // Convert a Map into a downloaded_video_data.
  factory downloaded_video_data.fromJson(Map<String, dynamic> json) {
    return downloaded_video_data(
      title: json['title'],
      channel_name: json['channel_name'],
      views: json['views'],
      uploaded_time: json['uploaded_time'],
      image_uri: Uri.parse(json['image_uri']),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.final_data});

  final List<downloaded_video_data> final_data;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<downloaded_video_data> _videoData = [];

  @override
  void initState() {
    super.initState();
    _loadVideoData().then((_) {
      if (widget.final_data.isNotEmpty) {
        _addNewData(widget.final_data);
      }
    });
  }

  Future<void> _loadVideoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? videoDataString = prefs.getString('videoData');
    if (videoDataString != null) {
      List<dynamic> jsonData = jsonDecode(videoDataString);
      List<downloaded_video_data> loadedData = jsonData
          .map((item) => downloaded_video_data.fromJson(item))
          .toList();
      setState(() {
        _videoData = loadedData;
      });
    }
  }

  Future<void> _saveVideoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(_videoData.map((item) => item.toJson()).toList());
    await prefs.setString('videoData', jsonData);
  }

  void _addNewData(List<downloaded_video_data> newData) {
    setState(() {
      _videoData.addAll(newData);
    });
    _saveVideoData();
  }

  void _deleteVideoData(int index) {
    setState(() {
      _videoData.removeAt(index);
    });
    _saveVideoData();
  }

  void _shareVideo(downloaded_video_data video) async {
  // Get the app's local directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String localPath = appDocDir.path;

  // Replace spaces in title with underscores to construct the file path
  String sanitizedTitle = video.title.replaceAll(' ', '_');
  String filePath = '$localPath/$sanitizedTitle.mp4'; // Assuming the file extension is .mp4

  File file = File(filePath);
  if (await file.exists()) {
    Share.shareFiles([file.path], text: 'Check out this video: ${video.title}');
  } else {
    // Handle file not found case
    print('File not found at $filePath!');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Downloaded Videos',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: _videoData.length,
        itemBuilder: (BuildContext context, int index) {
          final data_video = _videoData[index];
          return Container(
            height: 75,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextButton(
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        data_video.image_uri.toString(),
                        width: 50,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data_video.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(data_video.channel_name, style: TextStyle(color: Colors.black),),
                        Text(data_video.views + ' • ' + data_video.uploaded_time, style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                    PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'play') {
                        //play
                      } else if (value == 'share') {
                        _shareVideo(data_video);
                      } else if (value == 'delete') {
                        _deleteVideoData(index);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'play',
                        child: Text('Play'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'share',
                        child: Text('Share'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
              onPressed: (){
                //play
              },
            ),
          );
        },
      ),
    );
  }
}
