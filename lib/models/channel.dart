class Channel {
  // Properties
  String? channelId;
  String? title;
  String? thumbnail;
  String? videoCount;

  // Constructor
  Channel({this.channelId, this.title, this.thumbnail, this.videoCount});

  // Named constructor to create an instance from a map
  Channel.fromMap(Map<String, dynamic>? map)
      : channelId = map?['channelId'],
        title = map?['title'],
        thumbnail = map?['thumbnail'],
        videoCount = map?['videoCount'];

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'title': title,
      'thumbnail': thumbnail,
      'videoCount': videoCount,
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'Channel(channelId: $channelId, title: $title, thumbnail: $thumbnail, videoCount: $videoCount)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Channel) return false;
    return channelId == other.channelId &&
        title == other.title &&
        thumbnail == other.thumbnail &&
        videoCount == other.videoCount;
  }

  // Override hashCode
  @override
  int get hashCode {
    return channelId.hashCode ^
        title.hashCode ^
        thumbnail.hashCode ^
        videoCount.hashCode;
  }
}
