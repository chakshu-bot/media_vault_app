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
