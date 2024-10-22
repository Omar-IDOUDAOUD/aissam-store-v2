import 'package:aissam_store_v2/app/buisness/core/langs_and_currencies.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/currency.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/language.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.displayName,
    super.authInfo,
    super.firstName,
    super.lastName,
    super.photoUrl,
    super.currency,
    required super.language,
  });
  factory UserModel.fromJson(Map<String, dynamic> json, AuthInfo? authInfo) {

    
    
    return UserModel(
        id: json['user_id'],
        displayName: json['display_name'],
        authInfo: authInfo,
        // authInfo: AuthInfo(
        //   email: json['email'],
        //   phoneNumber: json['phone_number'],
        // ),
        firstName: json['first_name'],
        lastName: json['last_name'],
        photoUrl: json['photo_url'],
        currency: RegionsAndCurrenciesData.lookForCurrency(json['currency']) ??
            RegionsAndCurrenciesData.lookForCurrencyByLanguage(
                json['language']) ??
            RegionsAndCurrenciesData.currencies.first,
        language: RegionsAndCurrenciesData.lookForLanguage(json['language']) ??
            RegionsAndCurrenciesData.languages.first,
      );
  }

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'display_name': displayName,
        // 'email': authInfo?.email,
        // 'phone_number': authInfo?.phoneNumber,
        'first_name': firstName,
        'last_name': lastName,
        'photo_url': photoUrl,
        'currency': currency?.currencyCode,
        'language': language.languageCode,
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
    Currency? currency,
    Language? language,
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
