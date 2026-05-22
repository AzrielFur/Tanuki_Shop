import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Search/general_search.dart';
import 'package:flutter_application_1/app_constants.dart';
import 'package:flutter_application_1/cart/cart.dart';
import 'package:flutter_application_1/widgets/product_banner.dart';

class ChargersPage extends StatelessWidget {
  const ChargersPage({super.key});

  final List<Map<String, String>> _items = const [
    {'title': 'Cable USB-C 1m', 'image': kCellImagePath, 'description': 'Carga y datos', 'price': 'USD 5'},
    {'title': 'Cargador 25W Samsung', 'image': kCellImagePath, 'description': 'Carga rápida 25W', 'price': 'USD 19'},
    {'title': 'Power Bank 10000mAh', 'image': kCellImagePath, 'description': 'Batería portátil 10000mAh', 'price': 'USD 29'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFe6f7ff), Color(0xFF008fee)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Title in rounded container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(230),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('CARGADORES / CABLES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              const SizedBox(height: 16),
              // Search bar
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GeneralSearchScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF20b2aa),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('Busca tu dispositivo', style: TextStyle(color: Colors.white))),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withAlpha(77)),
                        child: const Icon(Icons.photo_camera, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return ProductBanner(
                      title: item['title'] ?? '',
                      imagePath: item['image'] ?? '',
                      description: item['description'],
                      price: item['price'],
                      onBuy: (ctx) {
                        final cart = CartService();
                        cart.add(CartItem(title: item['title'] ?? '', description: item['description'] ?? '', price: item['price'] ?? '', image: item['image'] ?? ''));
                        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Añadido al carrito: ${item['title']} - ${item['price']}')));
                        Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => const CartPage()));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Replaced by shared ProductBanner
