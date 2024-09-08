import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.displayName,
    super.authInfo,
    super.firstName,
    super.lastName,
    super.photoUrl,
    super.currency,
    super.language,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['user_id'],
        displayName: json['display_name'],
        authInfo: AuthInfo(
          email: json['email'],
          phoneNumber: json['phone_number'],
        ),
        firstName: json['first_name'],
        lastName: json['last_name'],
        photoUrl: json['photo_url'],
        currency: json['currency'],
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'display_name': displayName,
        'email': authInfo?.email,
        'phone_number': authInfo?.phoneNumber,
        'first_name': firstName,
        'last_name': lastName,
        'photo_url': photoUrl,
        'currency': currency,
        'language': language,
      };

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      displayName: user.displayName,
      firstName: user.firstName,
      lastName: user.lastName,
      photoUrl: user.photoUrl,
      currency: user.currency,
      language: user.language,
    );
  }
  UserModel copyWith({
    String? displayName,
    AuthInfo? authInfo,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? currency,
    String? language,
  }) {
    return UserModel(
      id: id,
      displayName: displayName ?? this.displayName,
      authInfo: authInfo ?? this.authInfo,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      language: language ?? this.language,
      currency: currency ?? this.currency,
    );
  }
}
