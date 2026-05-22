import 'package:flutter/material.dart';
import 'package:flutter_application_1/accounts/account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;

    try {
      final account = await readAccountByEmail(email);
      if (account == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta no encontrada. Regístrese primero.')),
        );
        return;
      }

      if (account.password != password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña incorrecta')),
        );
        return;
      }

      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFdff4ff), Color(0xFF0084d0)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 32),
                    // User icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF008b8b), Color(0xFF20b2aa)],
                        ),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(51), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(Icons.person, size: 60, color: Color(0xFF7fffd4)),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'INICIA SESIÓN',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 32),
                    // Email field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(178),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'correo electronico',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => (v == null || v.isEmpty) ? 'Ingrese correo' : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(178),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: _passCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'password',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        obscureText: true,
                        validator: (v) => (v == null || v.isEmpty) ? 'Ingrese contraseña' : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Forgot password
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(128),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: const Text(
                        'olvidaste tu contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Bottom buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF87ceeb),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Terminos y condiciones', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF87ceeb),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pushNamed('/register'),
                              child: const Text('REGISTRATE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Login button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF87ceeb),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(51), blurRadius: 8, offset: const Offset(0, 4))],
                      ),
                      child: TextButton(
                        onPressed: _login,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Entrar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
