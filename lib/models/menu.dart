class MenuItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final int displayOrder;
  final String description;

  const MenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.displayOrder,
    this.description = '',
  });
}
