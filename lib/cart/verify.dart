import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart/cart.dart';
import 'package:flutter_application_1/cart/DBU/d_bank.dart';

class VerifyPage extends StatefulWidget {
	const VerifyPage({super.key});

	@override
	State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
	final CartService _cart = CartService();
	// quantities by item index
	final Map<int, int> _quantities = {};

	double _parsePrice(String priceStr) {
		final match = RegExp(r"[0-9]+(?:[.,][0-9]+)?").firstMatch(priceStr.replaceAll(',', '.'));
		if (match == null) return 0.0;
		return double.tryParse(match.group(0) ?? '0') ?? 0.0;
	}

	double get _total {
		double sum = 0.0;
		for (var i = 0; i < _cart.items.length; i++) {
			final item = _cart.items[i];
			final qty = _quantities[i] ?? 1;
			sum += _parsePrice(item.price) * qty;
		}
		return sum;
	}

	void _ensureQuantities() {
		for (var i = 0; i < _cart.items.length; i++) {
			_quantities.putIfAbsent(i, () => 1);
		}
		// remove any entries for removed items
		_quantities.keys.where((k) => k >= _cart.items.length).toList().forEach(_quantities.remove);
	}

	@override
	Widget build(BuildContext context) {
		_ensureQuantities();

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
							Container(
								padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
								decoration: BoxDecoration(
									color: Colors.white.withAlpha((0.9 * 255).toInt()),
									borderRadius: BorderRadius.circular(20),
								),
								child: const Text('VERIFICAR COMPRA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
							),
							const SizedBox(height: 16),
							Expanded(
								child: AnimatedBuilder(
									animation: _cart,
									builder: (context, _) {
										if (_cart.items.isEmpty) return const Center(child: Text('El carrito está vacío'));
										return ListView.separated(
											itemCount: _cart.items.length,
											separatorBuilder: (c, i) => const SizedBox(height: 12),
											itemBuilder: (c, i) {
												final item = _cart.items[i];
												final qty = _quantities[i] ?? 1;
												return Container(
													padding: const EdgeInsets.all(12),
													decoration: BoxDecoration(
														color: Colors.white.withAlpha((0.95 * 255).toInt()),
														borderRadius: BorderRadius.circular(16),
													),
													child: Column(
														children: [
															Row(
																children: [
																	SizedBox(
																		width: 80,
																		height: 80,
																		child: Image.asset(item.image, fit: BoxFit.contain, errorBuilder: (c,e,s)=>const Icon(Icons.image_not_supported)),
																	),
																	const SizedBox(width: 12),
																	Expanded(
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
																				const SizedBox(height: 4),
																				Text(item.description, style: const TextStyle(color: Colors.black54, fontSize: 12)),
																				const SizedBox(height: 4),
																				Text(item.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF20b2aa))),
																			],
																		),
																	),
																	IconButton(
																		icon: const Icon(Icons.delete, color: Colors.red),
																		onPressed: () {
																			setState(() {
																				_cart.remove(item);
																			});
																		},
																	),
																],
															),
															const SizedBox(height: 8),
															Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	const Text('Cantidad:', style: TextStyle(fontWeight: FontWeight.bold)),
																	Container(
																		decoration: BoxDecoration(color: const Color(0xFF20b2aa), borderRadius: BorderRadius.circular(8)),
																		child: Row(
																			mainAxisSize: MainAxisSize.min,
																			children: [
																				IconButton(
																					icon: const Icon(Icons.remove, color: Colors.white, size: 18),
																					padding: EdgeInsets.zero,
																					constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
																					onPressed: () {
																						setState(() {
																							final newQty = (_quantities[i] ?? 1) - 1;
																							_quantities[i] = newQty < 1 ? 1 : newQty;
																						});
																					},
																				),
																				Padding(
																					padding: const EdgeInsets.symmetric(horizontal: 12),
																					child: Text(qty.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
																				),
																				IconButton(
																					icon: const Icon(Icons.add, color: Colors.white, size: 18),
																					padding: EdgeInsets.zero,
																					constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
																					onPressed: () {
																						setState(() {
																							_quantities[i] = (_quantities[i] ?? 1) + 1;
																						});
																					},
																				),
																			],
																		),
																	),
																],
															),
														],
													),
												);
											},
										);
									},
								),
							),
							const SizedBox(height: 12),

							// ==================== NUEVA SECCIÓN DE TOTAL Y PAGO ====================
							Container(
								padding: const EdgeInsets.all(20),
								decoration: BoxDecoration(
									color: Colors.white.withAlpha((0.95 * 255).toInt()),
									borderRadius: BorderRadius.circular(20),
								),
								child: Column(
									children: [
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: [
												const Text('Total a pagar:', style: TextStyle(fontSize: 18)),
												Text(
													'USD ${_total.toStringAsFixed(2)}',
													style: const TextStyle(
														fontSize: 26,
														fontWeight: FontWeight.bold,
														color: Color(0xFF008fee),
													),
												),
											],
										),
										const SizedBox(height: 24),

										Row(
											children: [
												Expanded(
													child: OutlinedButton(
														style: OutlinedButton.styleFrom(
															padding: const EdgeInsets.symmetric(vertical: 16),
														),
														onPressed: () => Navigator.pop(context),
														child: const Text('Volver', style: TextStyle(fontSize: 16)),
													),
												),
												const SizedBox(width: 12),
												Expanded(
													flex: 2,
													child: ElevatedButton(
														style: ElevatedButton.styleFrom(
															backgroundColor: const Color(0xFF008fee),
															padding: const EdgeInsets.symmetric(vertical: 16),
															shape: RoundedRectangleBorder(
																borderRadius: BorderRadius.circular(12),
															),
														),
														onPressed: () {
															if (_cart.items.isEmpty) {
																ScaffoldMessenger.of(context).showSnackBar(
																	const SnackBar(content: Text('El carrito está vacío')),
																);
																return;
															}

															Navigator.push(
																context,
																MaterialPageRoute(
																	builder: (context) => DBankPage(
																		cartItems: List.from(_cart.items),
																		quantities: Map.from(_quantities),
																		total: _total,
																	),
																),
															);
														},
														child: const Text(
															'PROCEDER AL PAGO',
															style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
														),
													),
												),
											],
										),
									],
								),
							),
							const SizedBox(height: 12),
						],
					),
				),
			),
		);
	}
}