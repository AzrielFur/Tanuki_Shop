import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_application_1/cart/cart.dart'; // Ajusta la ruta si es necesario
import 'package:flutter_application_1/cart/verify.dart';
import 'package:flutter_application_1/cart/DBU/d_bank.dart'
;
class DBillPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Map<int, int> quantities;
  final double total;
  final String orderId;

  const DBillPage({
    super.key,
    required this.cartItems,
    required this.quantities,
    required this.total,
    this.orderId = '',
  });

  String get _generatedOrderId {
    if (orderId.isNotEmpty) return orderId;
    return 'TK-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
  }

  String _generateQrData() {
    return '''
Orden: $_generatedOrderId
Total: USD ${total.toStringAsFixed(2)}
Fecha: ${DateTime.now().toString().substring(0, 16)}
Items: ${cartItems.length}
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
        backgroundColor: const Color(0xFF008fee),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera de Factura
            Center(
              child: Column(
                children: [
                  const Icon(Icons.receipt_long, size: 60, color: Color(0xFF008fee)),
                  const SizedBox(height: 8),
                  const Text(
                    'TANUKI FIX',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Factura Electrónica',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Información del Pedido
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Orden:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(_generatedOrderId, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Fecha:'),
                      Text(DateTime.now().toString().substring(0, 16)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        'USD ${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF008fee)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text('Productos Comprados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Lista de Productos
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final qty = quantities[index] ?? 1;
                final price = _parsePrice(item.price);
                final subtotal = price * qty;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: Text('x$qty', textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text(
                        'USD ${subtotal.toStringAsFixed(2)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),

            const Divider(height: 30),

            // Código QR
            Center(
              child: Column(
                children: [
                  const Text(
                    'Escanea para verificar tu compra',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: _generateQrData(),
                      version: QrVersions.auto,
                      size: 220,
                      gapless: false,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Orden: $_generatedOrderId',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Botón de Descargar / Volver
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF20b2aa),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Factura guardada (Simulado)')),
                  );
                  // Aquí puedes agregar lógica para guardar PDF más adelante
                },
                child: const Text(
                  'GUARDAR FACTURA',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _parsePrice(String priceStr) {
    final match = RegExp(r"[0-9]+(?:[.,][0-9]+)?").firstMatch(priceStr.replaceAll(',', '.'));
    return match != null ? double.tryParse(match.group(0) ?? '0') ?? 0.0 : 0.0;
  }
}

