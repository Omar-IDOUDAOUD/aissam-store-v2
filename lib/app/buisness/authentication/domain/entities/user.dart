
import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;
  final String fullname;

  const AuthUser({required this.id, required this.email, required this.fullname});

  @override
  List<Object?> get props => [id, email, fullname];
}
