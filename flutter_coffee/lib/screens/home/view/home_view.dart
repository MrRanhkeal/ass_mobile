import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:flutter_coffee/screens/home/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left sidebar
          Container(
            width: 200,
            color: const Color(0xFF1A237E),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Row(
                //     children: [
                //       Image.asset('assets/logo.png', width: 40, height: 40),
                //       const SizedBox(width: 8),
                //       const Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             'Coffee-POS',
                //             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                //           ),
                //           Text(
                //             'coffee shop POS',
                //             style: TextStyle(color: Colors.white70, fontSize: 12),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                const Divider(color: Colors.white24),
                _buildMenuItem(Icons.dashboard, 'Home', true),
                _buildMenuItem(Icons.person, 'Customer', false),
                _buildMenuItem(Icons.shopping_bag, 'Product', false),
                _buildMenuItem(Icons.shopping_cart, 'Supplier', false),
                _buildMenuItem(Icons.shopping_bag, 'Category', false),
                _buildMenuItem(Icons.inventory, 'Stock', false),
                _buildMenuItem(Icons.bar_chart, 'Report', false),
                _buildMenuItem(Icons.person_outline, 'User', false),
                _buildMenuItem(Icons.settings, 'Setting', false),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDD835),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.shopping_cart, size: 16),
                                SizedBox(width: 4),
                                Text('All'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip('Coffee', Icons.coffee),
                          _buildCategoryChip('Tea', Icons.emoji_food_beverage),
                          _buildCategoryChip('Smoothie', Icons.local_drink),
                          _buildCategoryChip('Juice', Icons.local_bar),
                          // _buildCategoryChip('Cookies', Icons.cookie),
                          // _buildCategoryChip('Soda', Icons.local_drink),
                          // _buildCategoryChip('Fruit', Icons.food_bank),
                          // _buildCategoryChip('Snack', Icons.lunch_dining),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     const CircleAvatar(
                      //       radius: 16,
                      //       backgroundImage: AssetImage('assets/avatar.png'),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Text('ranh',
                      //             style: TextStyle(fontWeight: FontWeight.bold)),
                      //         Text('Admin',
                      //             style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                // Products grid
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[100],
                    child: Obx(() {
                      switch (viewModel.loadingProductStatus.value) {
                        case Status.loading:
                          return const Center(child: CircularProgressIndicator());
                        case Status.success:
                          return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
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
          ),
          // Right sidebar - Cart
          Container(
            width: 300,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          badges.Badge(
                            badgeContent: const Text('0',
                                style: TextStyle(color: Colors.white)),
                            child: const Icon(Icons.shopping_cart),
                          ),
                          const SizedBox(width: 8),
                          const Text('Cart'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildCartSummaryRow('Total Qty:', '0 Items'),
                      _buildCartSummaryRow('Sub Total:', '0'),
                      _buildCartSummaryRow('Tax(0%):', '0'),
                      _buildCartSummaryRow('Total:', '0'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text('Checkout',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    String route = _getRouteForTitle(title);
    return Container(
      color: isSelected ? Colors.white.withOpacity(0.1) : null,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        onTap: () {
          if (route.isNotEmpty && route != RouteName.homeView) {
            Get.toNamed(route);
          }
        },
      ),
    );
  }

  String _getRouteForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'home':
        return RouteName.homeView;
      case 'customer':
        return RouteName.customerView;
      case 'product':
        return RouteName.productView;
      case 'category':
        return RouteName.categoryView;
      case 'supplier':
        return RouteName.supplierView;
      case 'category':
        return RouteName.categoryView;
      default:
        return '';
    }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                image: DecorationImage(
                  image: NetworkImage(product.imagePath ?? 'https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(product.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.blue),
                      onPressed: () {},
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

  Widget _buildCartSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
