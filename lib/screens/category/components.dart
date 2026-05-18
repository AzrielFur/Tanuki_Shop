import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Search/general_search.dart';
import 'package:flutter_application_1/app_constants.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  final List<Map<String, String>> _items = const [
    {'title': 'Resistencia SMD', 'image': kLaptopImagePath},
    {'title': 'Capacitor 10uF', 'image': kLaptopImagePath},
    {'title': 'IC reparacion', 'image': kLaptopImagePath},
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
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('REFACCIONES', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
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
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _DeviceRow(title: item['title'] ?? '', imagePath: item['image'] ?? '');
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

class _DeviceRow extends StatelessWidget {
  final String title;
  final String imagePath;

  const _DeviceRow({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final maxImageWidth = MediaQuery.of(context).size.width * 0.28;
    final isNetwork = imagePath.startsWith('http');
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFe6f3ff), Color(0xFF8fc9ff)],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxImageWidth),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: isNetwork
                  ? Image.network(imagePath, width: maxImageWidth, fit: BoxFit.cover, errorBuilder: (c,e,s)=>Container(width: maxImageWidth, height: maxImageWidth*0.8, color: Colors.white24, child: const Icon(Icons.image_not_supported)))
                  : Image.asset(imagePath, width: maxImageWidth, fit: BoxFit.contain, errorBuilder: (c,e,s)=>Container(width: maxImageWidth, height: maxImageWidth*0.8, color: Colors.white24, child: const Icon(Icons.image_not_supported))),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
