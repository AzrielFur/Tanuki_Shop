import 'package:flutter/material.dart';
// cart is not directly used here; buy action is provided by caller

class ProductBanner extends StatelessWidget {
  final String title;
  final String imagePath;
  final String? description;
  final String? price;
  final void Function(BuildContext)? onBuy;

  const ProductBanner({super.key, required this.title, required this.imagePath, this.description, this.price, this.onBuy});

  @override
  Widget build(BuildContext context) {
    final isNetwork = imagePath.startsWith('http');
    final hasDescription = (description ?? '').trim().isNotEmpty;
    final hasPrice = (price ?? '').trim().isNotEmpty;
    final height = hasDescription ? 140.0 : 110.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [Color(0xFFe6f3ff), Color(0xFF8fc9ff)]),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Imagen izquierda
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isNetwork
                ? Image.network(imagePath, width: 110, height: height - 24, fit: BoxFit.cover, errorBuilder: (c,e,s)=>Container(width:110, height:height-24, color: Colors.white24, child: const Icon(Icons.image_not_supported)))
                : Image.asset(imagePath, width: 110, height: height - 24, fit: BoxFit.contain, errorBuilder: (c,e,s)=>Container(width:110, height:height-24, color: Colors.white24, child: const Icon(Icons.image_not_supported))),
          ),
          const SizedBox(width: 12),
          // Contenido derecho - expandible
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Título - usa Flexible para no deformarse
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Descripción - solo si existe
                if (hasDescription) ...[
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      description!,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                // Espaciador flexible
                const Spacer(),
                // Fila precio y botón - totalmente adaptable
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Precio con máximo espacio flexible
                      if (hasPrice)
                        Flexible(
                          flex: 1,
                          child: Text(
                            price!,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      // Espaciador flexible
                      if (hasPrice && onBuy != null) const SizedBox(width: 6),
                      // Botón comprar con tamaño adaptable
                      if (onBuy != null)
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () => onBuy!(context),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: const Text('Comprar', style: TextStyle(fontSize: 12)),
                            ),
                          ),
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
}
