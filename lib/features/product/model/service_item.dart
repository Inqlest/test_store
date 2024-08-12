class ServiceItem {
  final String imageUrl;
  final String title;
  final String provider;
  final String price;
  final bool isFavorite;

  ServiceItem({
    required this.imageUrl,
    required this.title,
    required this.provider,
    required this.price,
    this.isFavorite = false,
  });

  ServiceItem copyWith({
    String? imageUrl,
    String? title,
    String? provider,
    String? price,
    bool? isFavorite,
  }) {
    return ServiceItem(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
