import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/chargers.dart';
import 'package:flutter_application_1/screens/category/adapters.dart';
import 'package:flutter_application_1/screens/category/components.dart';
import 'package:flutter_application_1/screens/category/matery.dart';
import 'package:flutter_application_1/screens/category/machines.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  Widget _pill(String text) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFF0f1720), Color(0xFFbde0ff)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      'CARGADORES / CABLES',
      'ADAPTADORES',
      'REFACCIONES',
      'MATERIALES DE REPARACION',
      'MAQUINAS DE REPARACION',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFdff4ff), Color(0xFF0ea5e9)],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 48),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                final name = items[index];
                Widget? page;
                if (name == 'CARGADORES / CABLES') page = const ChargersPage();
                if (name == 'ADAPTADORES') page = const AdaptersPage();
                if (name == 'REFACCIONES') page = const ComponentsPage();
                if (name == 'MATERIALES DE REPARACION') page = const MateryPage();
                if (name == 'MAQUINAS DE REPARACION') page = const MachinesPage();

                if (page != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
                }
              },
              child: _pill(items[index]),
            );
          },
        ),
      ),
    );
  }
}
