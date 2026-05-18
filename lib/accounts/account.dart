import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Account {
  final String name;
  final String email;
  final String password;

  Account({required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        password: json['password'] as String? ?? '',
      );
}

Future<Directory> _accountsDirectory() async {
  final base = await getApplicationDocumentsDirectory();
  final dir = Directory('${base.path}/accounts');
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
  return dir;
}

String _safeFileName(String email) {
  return email.replaceAll(RegExp(r"[^a-zA-Z0-9_@.-]"), '_');
}

Future<File> saveAccount(Account account) async {
  final dir = await _accountsDirectory();
  final filename = _safeFileName(account.email) + '.json';
  final file = File('${dir.path}/$filename');
  return file.writeAsString(jsonEncode(account.toJson()));
}

Future<Account?> readAccountByEmail(String email) async {
  final dir = await _accountsDirectory();
  final filename = _safeFileName(email) + '.json';
  final file = File('${dir.path}/$filename');
  if (!await file.exists()) return null;
  final content = await file.readAsString();
  return Account.fromJson(jsonDecode(content) as Map<String, dynamic>);
}

Future<List<Account>> readAllAccounts() async {
  final dir = await _accountsDirectory();
  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.json'));
  final List<Account> accounts = [];
  for (final f in files) {
    try {
      final content = await f.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;
      accounts.add(Account.fromJson(json));
    } catch (_) {
      // Ignorar archivos inválidos
    }
  }
  return accounts;
}
