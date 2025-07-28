class Platform {
  final String platformName;
  final String? iconUrl;

  Platform({
    required this.platformName,
    required this.iconUrl,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      platformName: json['platform_name'],
      iconUrl: json['icon_url'],
    );
  }
}