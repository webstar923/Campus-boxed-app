class PackingMaterial {
  final int id;
  final String name;
  final double price;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? items; // Optional list of items

  PackingMaterial({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.items, // Initialize as null if not provided
  });

  // Factory method to create a PackingMaterial instance from JSON
  factory PackingMaterial.fromJson(Map<String, dynamic> json) {
    return PackingMaterial(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: json['items'] != null 
          ? List<String>.from(json['items'])
          : [], // Initialize as empty list if null
    );
  }
}