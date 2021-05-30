import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../repositories/cloud_firestore_repository.dart';
import '../../repositories/firebase_auth_repository.dart';
import 'shared_prefs.dart';

GetIt getIt = GetIt.instance;
Future setupLocators() async {
  var instance = await SharedPrefs.getInstance();
  getIt.registerSingleton<SharedPrefs>(instance!);
  getIt.registerLazySingleton(() => FirebaseAuthRepository());
  getIt.registerLazySingleton(() => CloudFirestoreRepository());
  await hiveAndHydratedBlocInitialize();
}

Future hiveAndHydratedBlocInitialize() async {
  final dir = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
}
