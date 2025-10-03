import 'package:flutter/material.dart';

class FormMatkulPage extends StatefulWidget {
  const FormMatkulPage({super.key});

  @override
  State<FormMatkulPage> createState() => _FormMatkulPageState();
}

class _FormMatkulPageState extends State<FormMatkulPage> {
  final _formKey = GlobalKey<FormState>();
  final cKode = TextEditingController();
  final cNama = TextEditingController();
  final cSks = TextEditingController();

  @override
  void dispose() {
    cKode.dispose();
    cNama.dispose();
    cSks.dispose();
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
      'Kode Matkul': cKode.text.trim(),
      'Nama Matkul': cNama.text.trim(),
      'SKS': cSks.text.trim(),
    };
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Mata Kuliah'),
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
      appBar: AppBar(title: const Text('Form Mata Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cKode,
                decoration: const InputDecoration(
                  labelText: 'Kode Mata Kuliah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.code),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Kode matkul wajib diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cNama,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama matkul wajib diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cSks,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'SKS',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'SKS wajib diisi';
                  final ok = int.tryParse(v.trim());
                  return (ok != null && ok > 0) ? null : 'SKS harus angka > 0';
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
