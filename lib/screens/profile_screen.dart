import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/auth_cubit.dart';
import 'package:my_app/screens/wrapper_screen.dart';

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
        body: Center(child: Text('Profıl')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text("BAŞLIK TASARIMI",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                title: Text("FAVORİLERİM"),
                onTap: () {},
              ),
              ListTile(
                title: Text("AJANDAM"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
