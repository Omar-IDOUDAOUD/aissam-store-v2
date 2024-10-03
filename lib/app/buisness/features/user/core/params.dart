




import 'package:aissam_store_v2/app/buisness/core/entities/currency.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/language.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateUserParams{ 
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final Language? language;
  final Currency? currency;

  UpdateUserParams(
      {
        this.language, this.firstName, this.lastName, this.photoUrl, this.currency});
}



class CreateUserAfterAuthParams{
  final User user; 

  CreateUserAfterAuthParams({required this.user}); 
}