import 'package:aissam_store_v2/app/buisness/authentication/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/authentication/domain/entities/user.dart'; 

abstract class AuthRepository {

  Future<Either<AuthenticationFailure, AuthUser>> signIn(String email, String password); 
  Future<Either<AuthenticationFailure, AuthUser>> signUp(String email, String password, String username); 
  Future logOut(); 
  Stream<AuthUser?> get stateChanges; 

}
