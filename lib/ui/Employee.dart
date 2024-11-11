import 'package:flutter/material.dart';
import 'package:healthy/CRUD/add_employee.dart';
import 'package:healthy/CRUD/read_employee.dart';
import 'package:healthy/ui/gambar_page.dart';
import 'package:healthy/ui/menu.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
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
                  //     builder: (context) => ProfilePage(id: id),
                  //   ),
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
              child: EmployeePage(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEmployee()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
