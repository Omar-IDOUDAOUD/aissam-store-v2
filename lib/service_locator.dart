import 'package:aissam_store_v2/app/buisness/products/data/data_source/mongodb/mongodb_product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/repositories/products_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/user/data/data_source/user_datasource.dart';
import 'package:aissam_store_v2/app/buisness/user/data/repositories/user_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/config/databases/mongo_db.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/repositories/auth_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/config/environment/firebase_options.dart';

final sl = GetIt.I;

Future<void> initServiceLocator() async {
  await _initServices();
  _initDataSources();
  _initRepositories();
}

Future<void> _initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sl.registerLazySingletonAsync<ConnectionChecker>(
    () => ConnectionChecker().init(),
    dispose: (i) => i.dispose(),
  );

  sl.registerLazySingleton<MongoDb>(
    () => MongoDb(sl.getAsync<ConnectionChecker>()),
    dispose: (i) => i.dispose(),
  );
}

void _initDataSources() {
  sl.registerSingleton<AuthDataSource>(
      AuthDataSourceImpl(FirebaseAuth.instance));
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(FirebaseFirestore.instance));
  sl.registerLazySingleton<ProductsDatasource>(
    () => ProductsRemoteDatasourceImpl(sl()),
  );
}

void _initRepositories() {
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(sl()));
}
