import 'package:aissam_store_v2/app/buisness/products/data/data_source/products/remote_product_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/products/local_products_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/search/local_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/data_source/search/remote_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/products/data/repositories/products_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/products/data/repositories/search_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/products_repository.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/repositories/search_repository.dart';
import 'package:aissam_store_v2/app/buisness/user/data/data_source/user_datasource.dart';
import 'package:aissam_store_v2/app/buisness/user/data/repositories/user_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/repositories/user_repository.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';
import 'package:aissam_store_v2/config/environment/environment.dart';
import 'package:aissam_store_v2/services/caching/cache_manager.dart';
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

void initServiceLocator() {
  _initServices();
  _initDataSources();
  _initRepositories();
}

void _initServices() {
  // ALL SERVICES ANOTATED WITH (PRIMITIVE) MUST BE INITIALIZED
  // BEFORE USING ANY OF REPOS/DATASOURCE INSTANCES
  print('INIT SERVICES');

  // PRIMITIVE
  sl.registerLazySingletonAsync<FirebaseApp>(
    () async {
      return Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    },
  );

  sl.registerFactory<FirebaseAuth>(() => FirebaseAuth.instanceFor(app: sl()));
  sl.registerFactory<FirebaseFirestore>(
      () => FirebaseFirestore.instanceFor(app: sl()));

  sl.registerLazySingletonAsync<ConnectionChecker>(
    () => ConnectionChecker().init(),
    dispose: (i) => i.dispose(),
  );

  // PRIMITIVE
  sl.registerLazySingletonAsync<LocalDb>(
    () => LocalDb().init(),
    dispose: (i) => i.dispose(),
  );

  // PRIMITIVE
  sl.registerLazySingletonAsync<MongoDb>(
    () async {
      return MongoDb(Environment.mongodbDefName,
              await sl.getAsync<ConnectionChecker>())
          .init();
    },
    dispose: (i) => i.dispose(),
  );

  sl.registerLazySingleton<CacheManager>(
    () => CacheManager(sl()),
    dispose: (i) => i.dispose(),
  );
}

void _initDataSources() {
  print('INIT DATASOURCES');

  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()));
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(sl()));

  //
  sl.registerLazySingleton<ProductsRemoteDatasource>(
      () => ProductsRemoteDatasourceImpl(sl()));
  sl.registerLazySingleton<ProductsLocalDatasource>(
      () => ProductsLocalDatasourceImpl(sl()));

  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(sl(), sl()));
  //
}

void _initRepositories() {
  print('INIT REPOSITORIES');
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl(), sl()));
}
