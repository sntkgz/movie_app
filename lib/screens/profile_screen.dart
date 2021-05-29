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
          children: [
            DrawerHeader(
              child: Text("BAŞLIK TASARIMI",style: TextStyle(color: Colors.white,fontSize: 30)),
              decoration: BoxDecoration(
                color: Colors.blue),
                
            ),
            ListTile(
              title: Text("FAVORİLERİM"),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("AJANDAM"),
              onTap: (){
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
