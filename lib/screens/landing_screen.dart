import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/profile_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var sayfaListesi = [HomeScreen(), ProfileScreen()];

  int secilenIndexs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: sayfaListesi[secilenIndexs],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_two), label: 'profile'),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: secilenIndexs,
        onTap: (indexs) {
          setState(() {
            secilenIndexs = indexs;
          });
        },
      ),
    );
  }
}
