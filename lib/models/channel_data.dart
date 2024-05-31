// import 'package:youtube_data_api/models/video.dart';
// import 'package:media_vault/models/channel_page.dart';

// class ChannelData {
//   ChannelPage channel;
//   List<Video> videosList;

//   ChannelData({required this.channel, required this.videosList});

//   ChannelData.fromMap(Map<String, dynamic> map)
//       : channel = ChannelPage.fromMap(map['channel']),
//         videosList = (map['videosList'] as List).map((videoMap) => Video.fromMap(videoMap)).toList();

//   Map<String, dynamic> toJson() {
//     return {
//       'channel': channel.toJson(),
//       'videosList': videosList.map((video) => video.toJson()).toList(),
//     };
//   }

//   @override
//   String toString() {
//     return 'ChannelData(channel: ${channel.toString()}, videosList: ${videosList.toString()})';
//   }
// r
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! ChannelData) return false;
//     return channel == other.channel &&
//         videosList == other.videosList;
//   }

//   @override
//   int get hashCode {
//     return channel.hashCode ^ videosList.hashCode;
//   }
// }

