import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';   // ← Importante


class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF81D4FA),
              Color(0xFF0288D1),
              Color(0xFF01579B),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Título principal
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'ACCESIBILIDAD',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Lista de opciones
                _buildOption('Cambiar foto de perfil'),
                const SizedBox(height: 12),
                _buildOption('Configuración de cuenta'),
                const SizedBox(height: 12),
                _buildOption('Notificaciones'),
                const SizedBox(height: 12),
                _buildOption('Privacidad y seguridad'),
                const SizedBox(height: 12),
                _buildOption('Idioma'),
                const SizedBox(height: 12),
                _buildOption('Ayuda y soporte'),
                const SizedBox(height: 12),
                _buildOption('Acerca de la aplicación'),
                const SizedBox(height: 12),
                _buildOption('Cerrar sesión'),

                const Spacer(),

                // Botón de volver (opcional)
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  label: const Text(
                    'Volver',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}