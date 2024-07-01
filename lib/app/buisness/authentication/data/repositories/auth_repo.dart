import 'package:aissam_store_v2/app/buisness/authentication/core/error/exceptions.dart';
import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/data/data_source/auth_datasource.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/repositories/auth_repo.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl( this._authDataSource);

  @override
  Future<Either<AuthenticationFailure, AuthUser>> signIn(
      String email, String password) async {
    try {
      final user = await _authDataSource.signIn(email, password);
      return Right(user); 
    } on AuthException catch (e) {
      return Left(
                AuthenticationFailure.fromException(e)

      );
    }
  }

  
  
  
  @override
  Future<Either<AuthenticationFailure, AuthUser>> signUp(String email, String password, String username) async {
 try {
      final user = await _authDataSource.signUp(email, password, username);
      return Right(user); 
    } on AuthException catch (e) {
      return Left(
        AuthenticationFailure.fromException(e)
      );
    }
  }


  @override
  Future logOut() async {
    _authDataSource.logOut();
  }

  @override
  Stream<AuthUser?> get stateChanges => throw UnimplementedError();
   
}
