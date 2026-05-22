import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/all_products.dart';

class GeneralSearchScreen extends StatefulWidget {
  const GeneralSearchScreen({super.key});

  @override
  State<GeneralSearchScreen> createState() => _GeneralSearchScreenState();
}

class _GeneralSearchScreenState extends State<GeneralSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _results = [];

  void _onSearchChanged(String q) {
    final qLower = q.trim().toLowerCase();
    setState(() {
      if (qLower.isEmpty) {
        _results = [];
      } else {
        _results = allProducts.where((p) {
          final title = (p['title'] ?? '').toLowerCase();
          final category = (p['category'] ?? '').toLowerCase();
          return title.contains(qLower) || category.contains(qLower);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda general'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar productos, marcas o categorías',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),

            const SizedBox(height: 12),

            // Placeholder para anuncio dentro de la pantalla de búsqueda
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('Anuncio (opcional)')),
            ),

            const SizedBox(height: 12),

            // Resultados
            Expanded(
              child: _results.isEmpty
                    ? const Center(child: Text('Escribe para buscar...'))
                    : ListView.separated(
                      itemCount: _results.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _results[index];
                        final image = item['image'] ?? '';
                        final isNetwork = image.startsWith('http');
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: isNetwork
                                ? Image.network(image, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (c,e,s)=>const Icon(Icons.image_not_supported))
                                : Image.asset(image, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (c,e,s)=>const Icon(Icons.image_not_supported)),
                          ),
                          title: Text(item['title'] ?? ''),
                          subtitle: Text(item['category'] ?? ''),
                          onTap: () {
                            // Por ahora muestra detalles mínimos; se puede expandir para navegar a detalles.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Seleccionado: ${item['title']}')));
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
