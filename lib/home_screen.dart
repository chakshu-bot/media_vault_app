import 'package:flutter/material.dart';
import 'youtube_data_api.dart';
import 'models/video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YoutubeDataApi _youtubeDataApi = YoutubeDataApi();
  final TextEditingController _controller = TextEditingController();
  List<Video> _videos = [];
  bool _isLoading = false;

  void _searchVideos() async {
    setState(() {
      _isLoading = true;
    });

    try {
      const apiKey = 'AIzaSyAEcsjbv7bmgIkrYAwCpLghxDNXuvu8zjQ'; // Replace with your YouTube Data API key
      final query = _controller.text;
      final videos = await _youtubeDataApi.fetchSearchVideo(query, apiKey);
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch search results')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white10],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Search for YouTube Videos here...",
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _searchVideos,
                child: const Text("Search"),
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _videos.length,
                        itemBuilder: (context, index) {
                          final video = _videos[index];
                          return ListTile(
                            leading: video.thumbnailUrl != null
                                ? Image.network(video.thumbnailUrl!)
                                : null,
                            title: Text(video.title ?? 'No title'),
                            subtitle: Text(video.channelName ?? 'No channel name'),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
