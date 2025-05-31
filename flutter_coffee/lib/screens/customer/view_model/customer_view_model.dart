import 'package:flutter/foundation.dart';

class Customer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String description;
  final bool isActive;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.description,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'description': description,
      'isActive': isActive,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      isActive: json['isActive'] as bool,
    );
  }
}

class CustomerViewModel extends ChangeNotifier {
  List<Customer> _customers = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Create new customer
  Future<bool> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String description,
    required bool isActive,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Create a new customer with a unique ID
      final newCustomer = Customer(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phone: phone,
        email: email,
        address: address,
        description: description,
        isActive: isActive,
      );

      // TODO: Implement API call to save customer
      // For now, we'll just add it to the local list
      _customers.add(newCustomer);
      
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

  // Update existing customer
  Future<bool> updateCustomer(Customer customer) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to update customer
      final index = _customers.indexWhere((c) => c.id == customer.id);
      if (index != -1) {
        _customers[index] = customer;
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

  // Delete customer
  Future<bool> deleteCustomer(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to delete customer
      _customers.removeWhere((customer) => customer.id == id);

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

  // Load all customers
  Future<void> loadCustomers() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call to fetch customers
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
