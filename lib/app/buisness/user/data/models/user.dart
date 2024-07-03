import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
 

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    super.phoneNumber, 
    super.currency,
    super.language
  });
factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        fullName: json['full_name'],
        phoneNumber: json['phone_number'],
   
        currency: json['currency'],
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'currency': currency,
        'language': language,
      };

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      phoneNumber: user.phoneNumber, 
      currency: user.currency,
      language: user.language,
    );
  }


}
