import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var sayfaListe =[SayfaBir(),SayfaIki()];

  int secilenIndeks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Profilim')),
      body: Center(child: Text('Profıl')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [],
        ),
      ),
    );
  }
}
