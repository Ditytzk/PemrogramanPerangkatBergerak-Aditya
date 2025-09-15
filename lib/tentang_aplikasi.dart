import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: const Center(
        child: Text(
          'Aplikasi Demo Form Mahasiswa\nVersi 1.0.0',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}