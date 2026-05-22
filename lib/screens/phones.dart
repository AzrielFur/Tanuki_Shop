import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants.dart';
import 'package:flutter_application_1/screens/Search/general_search.dart';
import 'package:flutter_application_1/cart/cart.dart';
import 'package:flutter_application_1/widgets/product_banner.dart';

class PhonesPage extends StatelessWidget {
  const PhonesPage({super.key});
  final List<Map<String, String>> _items = const [
    {'title': 'Samsung S24 Ultra', 'image': kCellImagePath, 'description': 'Pantalla 6.8", 12GB RAM', 'price': 'USD 1199'},
    {'title': 'Samsung 25 Ultra', 'image': kCellImagePath, 'description': 'Excelente cámara y batería', 'price': 'USD 999'},
    {'title': 'Samsung S26', 'image': kCellImagePath, 'description': 'Rendimiento mejorado', 'price': 'USD 899'},
    {'title': 'Iphone 15 Pro Max', 'image': kCellImagePath, 'description': 'iOS 18, cámara Pro', 'price': 'USD 1299'},
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              // Title in rounded container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.9 * 255).toInt()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('CELULARES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
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
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withAlpha((0.3 * 255).toInt())),
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
                      imagePath: item['image'] ?? kCellImagePath,
                      description: item['description'],
                      price: item['price'],
                      onBuy: (ctx) {
                        final cart = CartService();
                        cart.add(CartItem(title: item['title'] ?? '', description: item['description'] ?? '', price: item['price'] ?? '', image: item['image'] ?? kCellImagePath));
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

// Replaced by shared ProductBanner widget
