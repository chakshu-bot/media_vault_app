class VideoPage {
  // Properties
  String? videoId;
  String? title;
  String? channelName;
  String? viewCount;
  String? subscribeCount;
  String? likeCount;
  String? unlikeCount;
  String? date;
  String? description;
  String? channelThumb;
  String? channelId;

  // Constructor
  VideoPage({
    this.videoId,
    this.title,
    this.channelName,
    this.viewCount,
    this.subscribeCount,
    this.likeCount,
    this.unlikeCount,
    this.date,
    this.description,
    this.channelThumb,
    this.channelId,
  });

  // Named constructor to create an instance from a map
  factory VideoPage.fromMap(Map<String, dynamic>? map, String videoId) {
    return VideoPage(
      videoId: videoId,
      title: map?['title'],
      channelName: map?['channelName'],
      viewCount: map?['viewCount'],
      subscribeCount: map?['subscribeCount'],
      likeCount: map?['likeCount'],
      unlikeCount: map?['unlikeCount'],
      date: map?['date'],
      description: map?['description'],
      channelThumb: map?['channelThumb'],
      channelId: map?['channelId'],
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'title': title,
      'channelName': channelName,
      'viewCount': viewCount,
      'subscribeCount': subscribeCount,
      'likeCount': likeCount,
      'unlikeCount': unlikeCount,
      'date': date,
      'description': description,
      'channelThumb': channelThumb,
      'channelId': channelId,
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'VideoPage(videoId: $videoId, title: $title, channelName: $channelName, viewCount: $viewCount, subscribeCount: $subscribeCount, likeCount: $likeCount, unlikeCount: $unlikeCount, date: $date, description: $description, channelThumb: $channelThumb, channelId: $channelId)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPage) return false;
    return videoId == other.videoId &&
        title == other.title &&
        channelName == other.channelName &&
        viewCount == other.viewCount &&
        subscribeCount == other.subscribeCount &&
        likeCount == other.likeCount &&
        unlikeCount == other.unlikeCount &&
        date == other.date &&
        description == other.description &&
        channelThumb == other.channelThumb &&
        channelId == other.channelId;
  }

  // Override hashCode
  @override
  int get hashCode {
    return videoId.hashCode ^
        title.hashCode ^
        channelName.hashCode ^
        viewCount.hashCode ^
        subscribeCount.hashCode ^
        likeCount.hashCode ^
        unlikeCount.hashCode ^
        date.hashCode ^
        description.hashCode ^
        channelThumb.hashCode ^
        channelId.hashCode;
  }
}
