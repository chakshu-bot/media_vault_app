class Video {
  final String? id;
  final String? title;
  final String? channelName;
  final String? thumbnailUrl;
  final String? videoUrl;

  Video({
    this.id,
    this.title,
    this.channelName,
    this.thumbnailUrl,
    this.videoUrl,
  });

  factory Video.fromSearchJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    return Video(
      id: json['id']['videoId'] ?? json['id'],
      title: snippet['title'],
      channelName: snippet['channelTitle'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
    );
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['default']['url'],
      videoUrl: 'https://www.youtube.com/watch?v=${json['id']}', 
    );
  }
}
