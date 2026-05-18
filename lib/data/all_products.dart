import 'package:flutter_application_1/app_constants.dart';

/// Índice simple de productos usado por la búsqueda general.
final List<Map<String, String>> allProducts = [
  // Phones
  {'title': 'Samsung S24 Ultra', 'category': 'CELULARES', 'image': kCellImagePath},
  {'title': 'Samsung 25 Ultra', 'category': 'CELULARES', 'image': kCellImagePath},
  {'title': 'Samsung S26', 'category': 'CELULARES', 'image': kCellImagePath},
  {'title': 'Iphone 15 Pro Max', 'category': 'CELULARES', 'image': kCellImagePath},

  // Tablets
  {'title': 'SamsungTAB A 10', 'category': 'TABLETS', 'image': kTabletImagePath},
  {'title': 'Samsung Tab-A9', 'category': 'TABLETS', 'image': kTabletImagePath},
  {'title': 'SAMSUNG A9+', 'category': 'TABLETS', 'image': kTabletImagePath},

  // Laptops
  {'title': 'SAMSUNG GALAXY BOOK4', 'category': 'LAPTOPS', 'image': kLaptopImagePath},
  {'title': 'SAMSUNG GALAXY BOOK 5', 'category': 'LAPTOPS', 'image': kLaptopImagePath},
  {'title': 'SAMSUNG GALAXY BOOK5 PRO', 'category': 'LAPTOPS', 'image': kLaptopImagePath},

  // Printers (ejemplo con URL de imagen)
  {'title': 'Impresora Samsung Xpress SL-410W', 'category': 'IMPRESORAS', 'image': 'https://via.placeholder.com/160x110'},
  {'title': 'Manual de usuario Samsung Xpress SL-C410', 'category': 'IMPRESORAS', 'image': 'https://via.placeholder.com/160x110'},
  {'title': 'Samsung M2070W', 'category': 'IMPRESORAS', 'image': 'https://via.placeholder.com/160x110'},
];
