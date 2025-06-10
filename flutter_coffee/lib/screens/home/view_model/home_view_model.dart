import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/models/invoice.dart';
import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/Category_response.dart';
import 'package:flutter_coffee/data/remote/models/response/Product_response.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/article_repository_impl.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:flutter_coffee/screens/invoice/view/invoice_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeViewModel extends GetxController {
  var articleRepo = ArticleRepositoryImpl();
  var loadingCategoryStatus = Status.loading.obs;
  var loadingProductStatus = Status.loading.obs;
  var categoriesList = <CategoryResponse>[].obs;
  var productsList = <ProductResponse>[].obs;
  var cartItemCount = 0.obs;
  var cartList = <ProductResponse>[].obs;

  // Computed property for cart total
  double get cartTotal => cartList.fold(0, (sum, item) => sum + item.price);
  
  // Add to cart method
  void addToCart(ProductResponse product) {
    cartList.add(product);
    cartItemCount.value = cartList.length;
    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  // Remove from cart method
  void removeFromCart(ProductResponse product) {
    cartList.remove(product);
    cartItemCount.value = cartList.length;
  }

  // Clear cart method
  void clearCart() {
    cartList.clear();
    cartItemCount.value = 0;
  }

  // Create invoice and show invoice view
  void createInvoice() {
    // Create a map to count quantities of each product
    final Map<String, InvoiceItem> itemMap = {};
    
    for (var product in cartList) {
      if (itemMap.containsKey(product.id)) {
        // Increment quantity if product already exists
        final existingItem = itemMap[product.id]!;
        itemMap[product.id] = InvoiceItem(
          name: existingItem.name,
          category: existingItem.category,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        );
      } else {
        // Add new product with quantity 1
        itemMap[product.id] = InvoiceItem(
          name: product.name,
          category: product.category,
          price: product.price,
          quantity: 1,
        );
      }
    }

    // Create invoice
    final invoice = Invoice(
      invoiceNumber: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: itemMap.values.toList(),
      total: cartTotal,
    );

    // Show invoice view
    Get.to(() => InvoiceView(invoice: invoice));
  }

  setLoadingCategory(Status value) => loadingCategoryStatus = value.obs;
  setLoadingProduct(Status value) => loadingProductStatus = value.obs;

  @override
  void onInit() {
    getAllCategories();
    getAllProducts();
    super.onInit();
  }

  logout() async {
    var storage = GetStorage();
    await storage.remove("ACCESS_TOKEN");
    await storage.remove("REFRESH_TOKEN");
    Get.offAndToNamed(RouteName.splashView);
  }

  getAllCategories() async {
    try {
      setLoadingCategory(Status.loading);
      var req = PostBaseRequest();
      var response = await articleRepo.getAllCategories(req);
      if (response.isSuccess && response.body != null) {
        categoriesList.clear();
        (response.body as List).forEach((data) {
          categoriesList.add(CategoryResponse.fromJson(data));
        });
        setLoadingCategory(Status.success);
      } else {
        setLoadingCategory(Status.error);
      }
    } catch (e) {
      setLoadingCategory(Status.error);
    }
  }

  getAllProducts() async {
    try {
      setLoadingProduct(Status.loading);
      // Add sample product data
      productsList.clear();
      productsList.addAll([
        ProductResponse(
          id: '1',
          name: 'Cappuccino',
          category: 'Coffee',
          brand: 'Coffee House',
          price: 1.99,
          imagePath: 'https://i.imgur.com/2aBjCR7.jpg',
          description: 'Classic Italian coffee drink',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        ProductResponse(
          id: '2',
          name: 'Latte',
          category: 'Coffee',
          brand: 'Coffee House',
          price: 1.49,
          imagePath: 'https://i.imgur.com/tEf7zGq.jpg',
          description: 'Espresso with steamed milk',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        ProductResponse(
          id: '3',
          name: 'Croissant',
          category: 'Snacks',
          brand: 'Bakery',
          price: 1.99,
          imagePath: 'https://i.imgur.com/2aBjCR7.jpg',
          description: 'Buttery, flaky pastry',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        ProductResponse(
          id: '4',
          name: 'Green Tea',
          category: 'Tea',
          brand: 'Tea House',
          price: 1.49,
          imagePath: 'https://i.imgur.com/HOU9gZO.jpg',
          description: 'Traditional Japanese green tea',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        ProductResponse(
          id: '4',
          name: 'Mocha',
          category: 'Tea',
          brand: 'coffee House',
          price: 1.49,
          imagePath: 'https://i.imgur.com/M73FiE2.jpg',
          description: 'A mocha is a coffee drink that is made with espresso',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        ProductResponse(
          id: '4',
          name: 'Cappuccino',
          category: 'coffee',
          brand: 'coffee House',
          price: 2.00,
          imagePath: 'https://i.imgur.com/wV5AoUV.jpg',
          description: 'A cappuccino is a coffee drink that is made with espresso',
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
      ]);
      setLoadingProduct(Status.success);
    } catch (e) {
      setLoadingProduct(Status.error);
    }
  }
}
