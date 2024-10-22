import 'package:aissam_store_v2/app/buisness/features/cart/data/data_source/cart_data_source.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/features/cart/domain/repositories/cart_repository.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/data_source/products/product_remote_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/data_source/products/products_local_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/data_source/search/local_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/data_source/search/remote_search_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/products/data/repositories/products_repo_impl.dart';

import 'package:aissam_store_v2/app/buisness/features/products/data/repositories/search_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/repositories/products_repository.dart';

import 'package:aissam_store_v2/app/buisness/features/products/domain/repositories/search_repository.dart';
import 'package:aissam_store_v2/app/buisness/features/user/data/data_source/user/remote.dart';

import 'package:aissam_store_v2/app/buisness/features/user/data/repositories/user_impl.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/repositories/user.dart';
import 'package:aissam_store_v2/app/buisness/features/wishlist/data/data_source/wishlist_local_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/wishlist/data/data_source/wishlist_remote_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/wishlist/data/repositories/wishlist_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/features/wishlist/domain/repositories/whishlist_repository.dart';

import 'package:aissam_store_v2/core/databases/local_db.dart';
import 'package:aissam_store_v2/core/databases/mongo_db.dart';
import 'package:aissam_store_v2/environment/environment.dart';
import 'package:aissam_store_v2/core/services/caching/cache_manager.dart';

import 'package:aissam_store_v2/core/services/connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/repositories/auth_repo.dart';
import 'package:aissam_store_v2/environment/firebase_options.dart';

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

  sl.registerLazySingleton<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton<WishlistLocalDataSource>(
      () => WishlistLocalDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton<CartDataSource>(() => CartDataSourceImpl(sl()));
}

void _initRepositories() {
  print('INIT REPOSITORIES');
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()).init(),
    dispose: (param) => (param as UserRepositoryImpl).dispose(),
  );
  sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
}
