import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _u = TextEditingController();
  final _p = TextEditingController();
  final _p2 = TextEditingController();
  String? _msg;

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
    _p2.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_p.text != _p2.text) {
      setState(() => _msg = 'Şifreler aynı değil');
      return;
    }
    final ok = await _auth.signUp(_u.text.trim(), _p.text);
    setState(() => _msg = ok ? 'Kayıt başarılı! Girişe dönülüyor...' : 'Bu kullanıcı adı mevcut.');
    if (ok) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _u,
                decoration: const InputDecoration(labelText: 'Kullanıcı adı', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Zorunlu' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _p,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Şifre', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.length < 4) ? 'En az 4 karakter' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _p2,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Şifre (tekrar)', border: OutlineInputBorder()),
                validator: (v) => (v != _p.text) ? 'Şifreler aynı değil' : null,
              ),
              const SizedBox(height: 12),
              if (_msg != null)
                Text(_msg!, style: TextStyle(color: _msg!.startsWith('Kayıt') ? Colors.green : Colors.red)),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: FilledButton(onPressed: _submit, child: const Text('Kayıt Ol'))),
            ],
          ),
        ),
      ),
    );
  }
}
