import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/repositories/auth_repo.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/firebase_options.dart';

final sl = GetIt.I;

Future<void> initServiceLocator() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _initDataSources(); 
  _initRepositories(); 
  _initServices(); 
}

void _initServices() {}

void _initDataSources() {
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(FirebaseAuth.instance));
}

void _initRepositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl( sl()));
}
