import 'package:flutter/material.dart';

class FormDosenPage extends StatefulWidget {
  const FormDosenPage({super.key});

  @override
  State<FormDosenPage> createState() => _FormDosenPageState();
}

class _FormDosenPageState extends State<FormDosenPage> {
  final _formKey = GlobalKey<FormState>();
  final cNidn = TextEditingController();
  final cNama = TextEditingController();
  final cHomeBase = TextEditingController();
  final cEmail = TextEditingController();
  final cTlp = TextEditingController();

  @override
  void dispose() {
    cNidn.dispose();
    cNama.dispose();
    cHomeBase.dispose();
    cEmail.dispose();
    cTlp.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    final data = {
      'NIDN': cNidn.text.trim(),
      'Nama': cNama.text.trim(),
      'Home Base': cHomeBase.text.trim(),
      'Email': cEmail.text.trim(),
      'No Tlp': cTlp.text.trim(),
    };
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Dosen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.entries
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${e.key}: ${e.value}'),
                  ))
              .toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Dosen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cNidn,
                decoration: const InputDecoration(
                  labelText: 'NIDN',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'NIDN wajib diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cNama,
                decoration: const InputDecoration(
                  labelText: 'Nama Dosen',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cHomeBase,
                decoration: const InputDecoration(
                  labelText: 'Home Base',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Home Base wajib diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                  final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                  return ok ? null : 'Format email tidak valid';
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cTlp,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No Telepon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'No telepon wajib diisi';
                  final ok = RegExp(r'^[0-9]{10,15}$').hasMatch(v.trim());
                  return ok ? null : 'Format nomor telepon tidak valid';
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                onPressed: _simpan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
