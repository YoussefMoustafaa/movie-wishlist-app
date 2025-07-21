class Platform {
  final String platformName;
  final String? monetizationType;
  final String? streamQuality;
  final int? price;
  final String? priceCurrency;
  final String? iconUrl;

  Platform({
    required this.platformName,
    required this.iconUrl,
    this.monetizationType,
    this.streamQuality,
    this.price,
    this.priceCurrency,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      platformName: json['platform_name'],
      monetizationType: json['monetization_type'],
      streamQuality: json['stream_quality'],
      price: json['price'],
      priceCurrency: json['price_currency'],
      iconUrl: json['icon_url'],
    );
  }
}