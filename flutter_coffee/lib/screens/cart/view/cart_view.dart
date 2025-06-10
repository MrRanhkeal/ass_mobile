import 'package:flutter/material.dart';
import 'package:flutter_coffee/screens/home/view_model/home_view_model.dart';
import 'package:get/get.dart';

import '../../../data/models/invoice.dart';
import '../../invoice/view/invoice_view.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  final viewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text('Cart',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (viewModel.cartList.isEmpty) {
          return const Center(
            child: Text('Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: viewModel.cartList.length,
          itemBuilder: (context, index) {
            final product = viewModel.cartList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imagePath ?? 'https://via.placeholder.com/50',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(product.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('USD ${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.remove_circle,
                          color: Colors.red, size: 24),
                      onPressed: () => viewModel.removeFromCart(product),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (viewModel.cartList.isEmpty) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    'USD ${viewModel.cartTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E)),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Get current cart items before clearing
                  final cartItems = viewModel.cartList.toList();
                  final total = viewModel.cartTotal;
                  
                  // Create invoice data
                  final invoice = Invoice(
                    invoiceNumber: DateTime.now().millisecondsSinceEpoch.toString(),
                    date: DateTime.now(),
                    items: cartItems.map((product) => InvoiceItem(
                      name: product.name,
                      category: product.category,
                      price: product.price,
                      quantity: 1, // For now each item has quantity 1
                    )).toList(),
                    total: total,
                  );

                  // Clear cart
                  viewModel.clearCart();
                  
                  // Navigate to invoice view
                  Get.to(() => InvoiceView(invoice: invoice));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Checkout',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
