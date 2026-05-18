import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Search/general_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildCard(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        final route = {
          'CELULARES': '/phones',
          'TABLETS': '/tablets',
          'LAPTOPS/ PC': '/laptops',
          'IMPRESORAS': '/printers',
        }[label];

        if (route != null) Navigator.of(context).pushNamed(route);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFe6f3ff), Color(0xFFbde0ff)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87ceeb), Color(0xFF0066cc)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header with logo and user
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('TANUKI Fix', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF20b2aa),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: () => Navigator.of(context).pushNamed('/login'),
                    ),
                  ),
                ],
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
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3)),
                        child: const Icon(Icons.photo_camera, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildCard(context, Icons.phone_android, 'CELULARES'),
                    _buildCard(context, Icons.tablet, 'TABLETS'),
                    _buildCard(context, Icons.laptop_mac, 'LAPTOPS/ PC'),
                    _buildCard(context, Icons.print, 'IMPRESORAS'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Bottom navigation|
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _navButton(context, Icons.home, 'INICIO', () => Navigator.of(context).pushReplacementNamed('/home'), true),
                    _navButton(context, Icons.shopping_bag, 'FUNDAS', () {}, false),
                    _navButton(context, Icons.shopping_cart, 'ACCESORIOS', () {}, false),
                    _navButton(context, Icons.grid_view, 'CATEGORIAS', () => Navigator.of(context).pushNamed('/category'), false),
                    _navButton(context, Icons.menu, 'MÁS', () {}, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, IconData icon, String label, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF0066cc) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.white : Colors.black54, size: 24),
          ),
          Text(label, style: TextStyle(fontSize: 10, color: isActive ? const Color(0xFF0066cc) : Colors.black54)),
        ],
      ),
    );
  }
}
