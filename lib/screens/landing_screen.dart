import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'profile_screen.dart';

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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
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
