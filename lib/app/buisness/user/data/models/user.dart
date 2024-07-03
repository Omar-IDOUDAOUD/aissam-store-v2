import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';


class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    super.phoneNumber,
    super.currency,
    super.photoUrl,
    super.language,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['user_id'],
        email: json['email'],
        fullName: json['full_name'],
        phoneNumber: json['phone_number'],
        photoUrl: json['photo_url'],
        currency: json['currency'],
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'email' : email, 
        'phone_number' : phoneNumber, 
        'full_name' : fullName, 
        'photo_url': photoUrl, 
        'language': language,
        'currency': currency
      };

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      photoUrl: user.photoUrl,
      phoneNumber: user.phoneNumber,
      currency: user.currency,
      language: user.language,
    );
  }
}
