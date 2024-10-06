class FeaturedItem {
  final String title;
  final String time;
  final String category;
  final String imageUrl;
  bool isFavorite;

  FeaturedItem({
    required this.title,
    required this.time,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
