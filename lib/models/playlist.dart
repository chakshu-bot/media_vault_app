import 'package:media_vault/models/thumbnail.dart';

class PlayList {
  // Properties
  String? playListId;
  List<Thumbnail>? thumbnails;
  String? title;
  String? channelName;
  String? videoCount;

  // Constructor
  PlayList({this.playListId, this.thumbnails, this.title, this.channelName, this.videoCount});

  // Named constructor to create an instance from a map
  PlayList.fromMap(Map<String, dynamic>? map)
      : playListId = map?['playListId'],
        thumbnails = map?['thumbnails'] != null 
            ? (map?['thumbnails'] as List).map((thumbMap) => Thumbnail.fromMap(thumbMap)).toList()
            : null,
        title = map?['title'],
        channelName = map?['channelName'],
        videoCount = map?['videoCount'];

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'playListId': playListId,
      'thumbnails': thumbnails?.map((thumb) => thumb.toJson()).toList(),
      'title': title,
      'channelName': channelName,
      'videoCount': videoCount,
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'PlayList(playListId: $playListId, thumbnails: $thumbnails, title: $title, channelName: $channelName, videoCount: $videoCount)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayList) return false;
    return playListId == other.playListId &&
        thumbnails == other.thumbnails &&
        title == other.title &&
        channelName == other.channelName &&
        videoCount == other.videoCount;
  }

  // Override hashCode
  @override
  int get hashCode {
    return playListId.hashCode ^
        thumbnails.hashCode ^
        title.hashCode ^
        channelName.hashCode ^
        videoCount.hashCode;
  }
}
