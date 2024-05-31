class VideoData {
  // Properties
  VideoPage? video;
  List<Video> videosList;

  // Constructor
  VideoData({this.video, required this.videosList});

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'video': video?.toJson(),
      'videosList': videosList.map((video) => video.toJson()).toList(),
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'VideoData(video: ${video?.toString()}, videosList: ${videosList.toString()})';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoData) return false;
    return video == other.video &&
        videosList == other.videosList;
  }

  // Override hashCode
  @override
  int get hashCode {
    return video.hashCode ^ videosList.hashCode;
  }
}

// Assuming VideoPage and Video classes are defined as follows:

class VideoPage {
  // Properties
  String? title;
  String? description;

  // Constructor
  VideoPage({this.title, this.description});

  // Named constructor to create an instance from a map
  VideoPage.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'];

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'VideoPage(title: $title, description: $description)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPage) return false;
    return title == other.title &&
        description == other.description;
  }

  // Override hashCode
  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode;
  }
}

class Video {
  // Properties
  String? videoId;
  String? duration;
  String? title;
  String? channelName;
  String? views;
  List<Thumbnail>? thumbnails;

  // Constructor
  Video({this.videoId, this.duration, this.title, this.channelName, this.views, this.thumbnails});

  // Named constructor to create an instance from a map
  Video.fromMap(Map<String, dynamic>? map)
      : videoId = map?['videoId'],
        duration = map?['duration'],
        title = map?['title'],
        channelName = map?['channelName'],
        views = map?['views'],
        thumbnails = map?['thumbnails'] != null 
            ? (map?['thumbnails'] as List).map((thumbMap) => Thumbnail.fromMap(thumbMap)).toList()
            : null;

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'duration': duration,
      'title': title,
      'channelName': channelName,
      'views': views,
      'thumbnails': thumbnails?.map((thumb) => thumb.toJson()).toList(),
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'Video(videoId: $videoId, duration: $duration, title: $title, channelName: $channelName, views: $views, thumbnails: $thumbnails)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Video) return false;
    return videoId == other.videoId &&
        duration == other.duration &&
        title == other.title &&
        channelName == other.channelName &&
        views == other.views &&
        thumbnails == other.thumbnails;
  }

  // Override hashCode
  @override
  int get hashCode {
    return videoId.hashCode ^
        duration.hashCode ^
        title.hashCode ^
        channelName.hashCode ^
        views.hashCode ^
        thumbnails.hashCode;
  }
}

class Thumbnail {
  // Properties
  String? url;
  int? width;
  int? height;

  // Constructor
  Thumbnail({this.url, this.width, this.height});

  // Named constructor to create an instance from a map
  Thumbnail.fromMap(Map<String, dynamic> map)
      : url = map['url'],
        width = map['width'],
        height = map['height'];

  // Method to convert the instance to a map
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  // Override toString method
  @override
  String toString() {
    return 'Thumbnail(url: $url, width: $width, height: $height)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Thumbnail) return false;
    return url == other.url &&
        width == other.width &&
        height == other.height;
  }

  // Override hashCode
  @override
  int get hashCode {
    return url.hashCode ^ width.hashCode ^ height.hashCode;
  }
}
