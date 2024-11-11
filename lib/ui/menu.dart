import 'package:flutter/material.dart';
import 'package:healthy/CRUD/read_berita.dart';
import 'package:healthy/ui/Employee.dart';
import 'package:healthy/ui/gambar_page.dart';
import 'package:healthy/ui/profile_page_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  final String username; // Tambahkan parameter username
  final String email; // Tambahkan parameter email

  const MenuPage({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int? userId;

  @override
  void initState() {
    super.initState();
    getUserIdFromStorage();
  }

  Future<void> getUserIdFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        email: widget.email,
                        username: widget.username,
                        id: userId ?? 8, // Gunakan userId yang diambil dari sesi
                      ),
                    ),
                  );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(22.0),
                child: Center(
                  child: ListTile(
                    leading: Image(
                      image: AssetImage(
                        "images/doctor.png",
                      ),
                    ),
                    title: Text(
                      "How do you feel?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Fill out your medical right now!",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Life Update on HealthCare",
              style:
                  TextStyle(color: Colors.green.withOpacity(0.6), fontSize: 24),
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: BeritaPage(),
            ),
          ],
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
                      email: widget.email,
                      username: widget.username,
                    ),
                  ),
                );
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
                  ),
                );
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
                  ),
                );
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
