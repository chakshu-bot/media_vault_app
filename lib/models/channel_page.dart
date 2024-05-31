// class ChannelPage {
//   String? subscribers;
//   String? avatar;
//   String? banner;

//   ChannelPage({this.subscribers, this.avatar, this.banner});

//   Map<String, dynamic> toJson() {
//     return {
//       'subscribers': subscribers,
//       'avatar': avatar,
//       'banner': banner,
//     };
//   }

//   @override
//   String toString() {
//     return 'ChannelPage(subscribers: $subscribers, avatar: $avatar, banner: $banner)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! ChannelPage) return false;
//     return subscribers == other.subscribers &&
//         avatar == other.avatar &&
//         banner == other.banner;
//   }


//   @override
//   int get hashCode {
//     return subscribers.hashCode ^ avatar.hashCode ^ banner.hashCode;
//   }
// }
