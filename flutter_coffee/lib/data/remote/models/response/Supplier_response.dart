class SupplierResponse {
  final String id;
  final String name;
  final String productType;
  final String code;
  final String phone;
  final String email;
  final String address;
  final String? description;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  SupplierResponse({
    required this.id,
    required this.name,
    required this.productType,
    required this.code,
    required this.phone,
    required this.email,
    required this.address,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupplierResponse.fromJson(Map<String, dynamic> json) {
    return SupplierResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      productType: json['productType'] as String,
      code: json['code'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'productType': productType,
      'code': code,
      'phone': phone,
      'email': email,
      'address': address,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
