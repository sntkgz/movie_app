import 'package:flutter/material.dart';

import 'landing_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
        
        body: SingleChildScrollView(
                  child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 80.0,bottom: 30.0),
                  
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Mapp.png')
                      ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(ekranYuksekligi/50),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Kullanıcı Adı",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(ekranYuksekligi/50),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(ekranYuksekligi/30),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingScreen()));
                    },
                                      child: Container(
                      margin: const EdgeInsets.only(top:3.0,left:30.0,right:30.0),
                      width: 200,
                      height: 30,
                      child: Center(
                        child: 
                        Text('Giriş Yap',
                        style: TextStyle(color: Colors.white)
                        ),
                      ),
                      
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingScreen()));
                },  child: Text('ok'),)
              ],
            ),
          ),
        ),
      );
  }
}

