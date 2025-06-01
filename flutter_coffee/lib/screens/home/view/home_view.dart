import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:flutter_coffee/screens/home/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text('Coffee-POS',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: badges.Badge(
              badgeContent: Obx(() => Text(
                    viewModel.cartItemCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              child: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.defaultDialog(
                title: 'Logout',
                titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                content: const Text('Are you sure you want to logout?'),
                confirmTextColor: Colors.white,
                onConfirm: () {
                  // Clear any stored credentials
                  GetStorage().erase();
                  // Navigate to login screen
                  Get.offAllNamed(RouteName.loginView);
                },
                onCancel: () {},
                textConfirm: 'Logout',
                textCancel: 'Cancel',
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Categories
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDD835),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.local_cafe, size: 16),
                      SizedBox(width: 4),
                      Text('All'),
                    ],
                  ),
                ),
                _buildCategoryChip('Coffee', Icons.coffee),
                _buildCategoryChip('Tea', Icons.emoji_food_beverage),
                _buildCategoryChip('Snacks', Icons.lunch_dining),
                _buildCategoryChip('Desserts', Icons.cake),
                _buildCategoryChip('Smoothie', Icons.local_drink),
                _buildCategoryChip('Juice', Icons.local_bar),
              ],
            ),
          ),
          // Products Grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[100],
              child: Obx(() {
                switch (viewModel.loadingProductStatus.value) {
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.success:
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: viewModel.productsList.length,
                      itemBuilder: (context, index) {
                        final product = viewModel.productsList[index];
                        return _buildProductCard(product);
                      },
                    );
                  case Status.error:
                    return const Center(child: Text('Error loading products'));
                }
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A237E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed(RouteName.homeView);
              break;
            case 1:
              Get.toNamed(RouteName.productView);
              break;
            case 2:
              Get.toNamed(RouteName.categoryView);
              break;
            case 3:
              Get.toNamed(RouteName.customerView);
              break;
          }
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (bool selected) {},
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                image: DecorationImage(
                  image: NetworkImage(product.imagePath ?? 'https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'USD ${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.blue, size: 28),
                      onPressed: () {
                        viewModel.cartItemCount++;
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
