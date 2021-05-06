import 'package:flutter/material.dart';
import 'package:my_app/film.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.blue, 
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Filmler>> filmlerGetir() async{

    var filmlerListesi = <Filmler>[];

    var f1 = Filmler(1, "Divercent", "images2.jpeg", 2014, "139 dk" , "Aksiyon/Macera" , "Neil Burger", "Shailene Woodley,Theodore Peter James Kinnaird Taptiklis", " English ", "USA", 6.6 );
    var f2 = Filmler(2, "Iron Man", "images3.jpeg", 2008, "126 dk" , "Aksiyon/Macera" , "Jon Favreau", "Robert Downey Jr.,Gwyneth Paltrow", " English", "USA", 8.9 );
    var f3 = Filmler(3, "Children of Heaven", "images4.jpeg", 1997, "90 dk" , "Dram/Çocuk" , "Mecid Mecidi", "Mir Farrokh Hashemian,Bahare Seddiqi", " Persian", "Iran", 8.3 );
    var f4 = Filmler(4, "Taare Zaamen Par", "images5.jpeg", 2007, "164 dk" , "Müzikal/Dram" , "Aamir Khan, Amole Gupte", "Darsheel Safary,Aamir Khan", " English | Hindi", "Hindistan", 8.5 );
    var f5 = Filmler(5, "İnception", "images6.jpeg", 2010, "148 dk" , "Aksiyon/Bilim Kurgu" , "Christopher Nolan", "Leonardo DiCaprio", " English ", "USA", 8.8 );
    var f6 = Filmler(6, "7.Koğuştaki Mucize", "images7.jpeg", 2019, "132 min" , "Dram " , "Mehmet Ada Öztekin", "Aras Bulut İynemli,Nisa Sofiya Aksongur", " Turkish", "Turkey", 7.6 );

    filmlerListesi.add(f1);
    filmlerListesi.add(f2);
    filmlerListesi.add(f3);
    filmlerListesi.add(f4);
    filmlerListesi.add(f5);
    filmlerListesi.add(f6);

    return filmlerListesi;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmler')
        ),
      body: FutureBuilder<List<Filmler>>(

        future: filmlerGetir(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){ 
              return Center(child: CircularProgressIndicator(),);
          } 
          if(snapshot.hasData){

            var filmlerListesi= snapshot.data;

            return SingleChildScrollView(
                          child: GridView.builder(
                        shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                itemCount: filmlerListesi.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3.5,
                ),
                itemBuilder: (context,indeks){
                  var film = filmlerListesi[indeks];

                  return Card(
                    child: Column(
                      children: [
                        Image.asset('assets/images/${film.filmResimAdi}'),
                        Text(film.filmAdi, style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(film.filmGenre, style:TextStyle(fontSize: 14,),),
                      ],
                    ),
                  );
                },
              ),
            );

          }else{
            return Center();
          }
        },
      ),
    );
  }
}