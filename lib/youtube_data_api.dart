import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:media_vault/models/video.dart';

class YoutubeDataApi {
  Future<List<Video>> fetchSearchVideo(String query, String apiKey, {int maxResults = 5}) async {
    final url = Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=$maxResults&q=$query&type=video&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => Video.fromSearchJson(item)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

 static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';

  static Future<Video> fetchVideoDetails(String videoId, String apiKey) async {
    final url = '$_baseUrl/videos?part=snippet,contentDetails,statistics&id=$videoId&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'] != null && data['items'].isNotEmpty) {
        return Video.fromJson(data['items'][0]);
      } else {
        throw Exception('No video details found');
      }
    } else {
      throw Exception('Failed to load video details');
    }
  }
}
