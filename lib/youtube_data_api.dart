import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';

class YoutubeDataApi {
  Future<List<Video>> fetchSearchVideo(String query, String apiKey, {int maxResults = 69}) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&maxResults=$maxResults&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List videos = data['items'];
      return videos.map((video) => Video.fromMap(video)).toList();
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
