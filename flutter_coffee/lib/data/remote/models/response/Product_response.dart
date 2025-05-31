class ProductResponse {
  final String id;
  final String name;
  final String category;
  final String brand;
  final double price;
  final String? barcode;
  final double? discount;
  final String? description;
  final String? imagePath;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  ProductResponse({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    this.barcode,
    this.discount,
    this.description,
    this.imagePath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      barcode: json['barcode'] as String?,
      discount: json['discount'] == null ? null : (json['discount'] as num).toDouble(),
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'brand': brand,
      'price': price,
      'barcode': barcode,
      'discount': discount,
      'description': description,
      'imagePath': imagePath,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
