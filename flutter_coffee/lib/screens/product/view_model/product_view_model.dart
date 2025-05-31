import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String brand;
  final double price;
  final String barcode;
  final double discount;
  final String description;
  final String? imagePath;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.barcode,
    required this.discount,
    required this.description,
    this.imagePath,
    required this.isActive,
  });

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
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: json['price'] as double,
      barcode: json['barcode'] as String,
      discount: json['discount'] as double,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String?,
      isActive: json['isActive'] as bool,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Create new product
  Future<bool> createProduct({
    required String name,
    required String category,
    required String brand,
    required double price,
    required String barcode,
    required double discount,
    required String description,
    String? imagePath,
    required bool isActive,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Create a new product with a unique ID
      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category,
        brand: brand,
        price: price,
        barcode: barcode,
        discount: discount,
        description: description,
        imagePath: imagePath,
        isActive: isActive,
      );

      // TODO: Implement API call to save product
      // For now, we'll just add it to the local list
      _products.add(newProduct);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update existing product
  Future<bool> updateProduct(Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to update product
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to delete product
      _products.removeWhere((product) => product.id == id);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load all products
  Future<void> loadProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to fetch products
      // For now, we'll just work with the local list

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
