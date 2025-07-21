import 'package:movie_wish_list/models/Platform.dart';

class PlatformLink {
  final String linkUrl;
  final Platform platform;

  PlatformLink({
    required this.linkUrl,
    required this.platform,
  });

  factory PlatformLink.fromJson(Map<String, dynamic> json) {
    return PlatformLink(
      linkUrl: json['link_url'],
      platform: Platform.fromJson(json['platform']),
    );
  }
}