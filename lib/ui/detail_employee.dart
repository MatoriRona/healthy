import 'package:flutter/material.dart';

class DetailEmployee extends StatelessWidget {
  // Data pegawai yang akan ditampilkan
  final String nama;
  final String no_bp;
  final String no_telp;
  final String tgl_input;

  // Constructor untuk menerima data pegawai
  const DetailEmployee({
    Key? key,
    required this.nama,
    required this.no_bp,
    required this.no_telp,
    required this.tgl_input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pegawai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nama: $nama'),
            Text('No. BP: $no_bp'),
            Text('No. HP: $no_telp'),
            Text('tgl_input: $tgl_input'),
          ],
        ),
      ),
    );
  }
}
