// video.dart
class Video {
  final String? videoId;
  final String? title;
  final String? channelName;
  final String? thumbnailUrl;

  Video({this.videoId, this.title, this.channelName, this.thumbnailUrl});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      videoId: map['id']['videoId'],
      title: map['snippet']['title'],
      channelName: map['snippet']['channelTitle'],
      thumbnailUrl: map['snippet']['thumbnails']['default']['url'],
    );
  }
}