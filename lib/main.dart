import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/sesion.dart';
import 'package:flutter_application_1/screens/register.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/phones.dart';
import 'package:flutter_application_1/screens/tablets.dart';
import 'package:flutter_application_1/screens/laptops.dart';
import 'package:flutter_application_1/screens/printers.dart';
import 'package:flutter_application_1/screens/category/category.dart';
import 'package:flutter_application_1/cart/cart.dart';
import 'package:flutter_application_1/screens/Search/SWC/Camera.dart';
void main() {
  runApp(const MyApp());
}

/// Ruta/paths donde puedes cambiar las imágenes usadas en la app.
/// - Reemplaza estos valores por las rutas de tus assets (por ejemplo
///   'assets/images/logo.png') y añade las entradas en `pubspec.yaml`.
const String kLogoImagePath = 'assets/images/logo.png'; // <-- cambiar aquí
const String kCellImagePath = 'assets/images/celular.png'; // <-- cambiar aquí
const String kTabletImagePath = 'assets/images/tablet.png'; // <-- cambiar aquí
const String kLaptopImagePath = 'assets/images/laptop.png'; // <-- cambiar aquí
const String kPrinterImagePath =
    'assets/images/impresora.png'; // <-- cambiar aquí

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanuki Fix - Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/terms': (context) => const TermsPage(),
        '/home': (context) => const HomePage(),
        '/phones': (context) => const PhonesPage(),
        '/tablets': (context) => const TabletsPage(),
        '/laptops': (context) => LaptopsPage(),
        '/printers': (context) => const PrintersPage(),
        '/category': (context) => const CategoryPage(),
        '/cart': (context) => const CartPage(),
        '/camera': (context) => const CameraPage(),
      },
    );
  }
}
