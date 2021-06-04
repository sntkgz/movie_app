import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/auth_cubit.dart';

import 'wrapper_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WrapperScreen()),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profilim'),
          actions: [
            IconButton(
                onPressed: () async {
                  await context.read<AuthCubit>().signOut();
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 60,
                  ),
                  Center(
                    child: Text('Profil'),
                  ),
                  Container(
                    color: Colors.blue,
                    child: ListTile(
                      title: Text('Notlarım'),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                    ),
                  )
                ],
              ),
            ),
            Text('Favori Filmlerim'),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 200,
                            width: 200,
                          ),
                        )),
                        Text(
                          'movie.title!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'movie.genre!',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
