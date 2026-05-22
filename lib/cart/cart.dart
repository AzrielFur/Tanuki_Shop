import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart/verify.dart';

class CartItem {

	final String title;
	final String description;
	final String price;
	final String image;

	CartItem({required this.title, required this.description, required this.price, required this.image});
}

class CartService extends ChangeNotifier {
	static final CartService _instance = CartService._internal();

	factory CartService() => _instance;

	CartService._internal();

	final List<CartItem> _items = [];

	List<CartItem> get items => List.unmodifiable(_items);

	void add(CartItem item) {
		_items.add(item);
		notifyListeners();
	}

	void remove(CartItem item) {
		_items.remove(item);
		notifyListeners();
	}

	void clear() {
		_items.clear();
		notifyListeners();
	}
}

class CartPage extends StatelessWidget {
	const CartPage({super.key});

	@override
	Widget build(BuildContext context) {
		final cart = CartService();
		return Scaffold(
			appBar: AppBar(
				title: const Text('Carrito'),
				leading: IconButton(
					icon: const Icon(Icons.arrow_back),
					onPressed: () => Navigator.of(context).pop(),
				),
			),
			body: AnimatedBuilder(
				animation: cart,
				builder: (context, _) {
					if (cart.items.isEmpty) {
						return const Center(child: Text('El carrito está vacío'));
					}
					return ListView.separated(
						padding: const EdgeInsets.all(12),
						itemCount: cart.items.length,
						separatorBuilder: (context, index) => const SizedBox(height: 12),
						itemBuilder: (context, index) {
							final item = cart.items[index];
							return ListTile(
								leading: SizedBox(width: 56, child: Image.asset(item.image, fit: BoxFit.contain, errorBuilder: (c,e,s)=>const Icon(Icons.image_not_supported))),
								title: Text(item.title),
								subtitle: Text(item.description),
								trailing: Text(item.price),
							);
						},
					);
				},
			),
			floatingActionButton: FloatingActionButton.extended(
				onPressed: () {
					Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VerifyPage()));
				},
				label: const Text('Pagar'),
				icon: const Icon(Icons.payment),
			),
		);
	}
}
