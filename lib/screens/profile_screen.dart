import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/const.dart';
import 'package:my_app/cubit/auth_cubit.dart';
import 'package:my_app/cubit/favorite_movie_cubit.dart';
import 'package:my_app/widgets/movie_image.dart';

import 'wrapper_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteMovieCubit>().initialFetchFavoriteMovies();
  }

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
                  context
                      .read<FavoriteMovieCubit>()
                      .emit(FavoriteMovieLoading());
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
              height: 250,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 60,
                  ),
                  Center(
                    child: Text('Profil'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileItem(
                    icon: Icon(Icons.notes_outlined),
                    title: 'Notlarım',
                    onTap: () {
                      Navigator.of(context).pushNamed('/notes_screen');
                    },
                  ),
                ],
              ),
            ),
            Text('Favori Filmlerim'),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<FavoriteMovieCubit, FavoriteMovieState>(
              builder: (context, state) {
                if (state is FavoriteMovieLoading) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: CircularProgressIndicator(
                      color: kBlueColor,
                    ),
                  );
                } else if (state is FavoriteMovieIsEmptyLoaded) {
                  return Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Text('Favori filmleriniz bulunmamaktadır'),
                  );
                } else if (state is FavoriteMovieLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.favoriteMovies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3.5,
                    ),
                    itemBuilder: (context, index) {
                      final movie = state.favoriteMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              '/movie_detail_screen',
                              arguments: movie);
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: movieImage(movie.poster),
                              )),
                              Text(
                                movie.title!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movie.genre!,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            SizedBox(
              height: 40,
            ),
          ],
        )),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;

  const ProfileItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: ListTile(
                leading: icon,
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: onTap,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.4,
            color: Colors.black45,
          )
        ],
      ),
    );
  }
}
