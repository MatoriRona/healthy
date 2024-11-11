import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy/api/constan.dart';
import 'package:healthy/ui/Employee.dart';
import 'package:healthy/ui/menu.dart';
import 'package:http/http.dart' as http;

class GambarPage extends StatefulWidget {
  @override
  _GambarPageState createState() => _GambarPageState();
}

class _GambarPageState extends State<GambarPage> {
  late List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.getBerita));
      final responseData = json.decode(response.body);

      if (responseData['isSuccess']) {
        setState(() {
          _imageUrls = List<String>.from(
              responseData['data'].map((item) => item['gambar']));
        });
      } else {
        print('Gagal mengambil gambar: ${responseData['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _showImageAlert(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(BaseUrl.gambar + imageUrl),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup alert
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "HealthCare",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProfilePage(id: id,)),
                  // );
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 14.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: _imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            final imageUrl = _imageUrls[index];
            return GestureDetector(
              onTap: () => _showImageAlert(imageUrl),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(BaseUrl.gambar + imageUrl,
                      fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage(
                        username: 'username',
                        email: 'email',
                      ),
                    ));
              },
              child: Container(
                child: const Column(
                  children: [
                    Icon(Icons.home),
                    Text("Home"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GambarPage(),
                    ));
              },
              child: Container(
                child: const Column(
                  children: [
                    Icon(Icons.photo),
                    Text("Gallery"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeScreen(),
                    ));
              },
              child: Container(
                child: const Column(
                  children: [
                    Icon(Icons.person),
                    Text("Employee"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
