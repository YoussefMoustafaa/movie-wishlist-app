import 'package:movie_wish_list/models/Platform.dart';

class PlatformLink {
  final String linkUrl;
  final String? monetizationType;
  final String? streamQuality;
  final double? price;
  final String? priceCurrency;
  final Platform platform;

  PlatformLink({
    required this.linkUrl,
    this.monetizationType,
    this.streamQuality,
    this.price,
    this.priceCurrency,
    required this.platform,
  });

  factory PlatformLink.fromJson(Map<String, dynamic> json) {
    return PlatformLink(
      linkUrl: json['link_url'],
      monetizationType: json['monetization_type'],
      streamQuality: json['stream_quality'],
      price: json['price'],
      priceCurrency: json['price_currency'],
      platform: Platform.fromJson(json['platform']),
    );
  }
}