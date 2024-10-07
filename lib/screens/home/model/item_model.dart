class FeaturedItem {
  final String name;
  final String duration;
  final String type;
  final String imageLink;
  final String musicLink;
  late final bool isFavorite;
  final String keyValue;

  FeaturedItem({
    required this.name,
    required this.duration,
    required this.type,
    required this.imageLink,
    required this.musicLink,
    required this.keyValue,
    this.isFavorite = false,
  });
}
