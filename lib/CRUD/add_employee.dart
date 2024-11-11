import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController nama = TextEditingController();
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  Future<void> addPegawai() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.insertPegawai),
        body: {
          'nama': nama.text, // Isi nama pegawai jika perlu
          'no_bp': noBpController.text,
          'no_telp': noHpController.text, // Ubah key menjadi 'no_telp'
          'email': emailController.text,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil ditambahkan
        print('Pegawai berhasil ditambahkan');

        // Tampilkan dialog berhasil
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Pegawai berhasil ditambahkan'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                    Navigator.of(context)
                        .pop(); // Kembali ke halaman sebelumnya
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Bersihkan inputan pada fielda
        nama.clear();
        noBpController.clear();
        noHpController.clear();
        emailController.clear();
      } else {
        // Pegawai gagal ditambahkan
        print('Pegawai gagal ditambahkan');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nama,
                validator: (value) {
                  return value!.isEmpty ? "Nama tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: noBpController,
                validator: (value) {
                  return value!.isEmpty ? "No Bp tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. BP'),
              ),
              TextFormField(
                controller: noHpController,
                validator: (value) {
                  return value!.isEmpty ? "No Hp tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. HP'),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? "Email tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Validasi sebelum menambah pegawai
                  if (_keyForm.currentState!.validate()) {
                    addPegawai();
                  }
                },
                child: Text('Tambah Pegawai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
