




class UpdateUserParams{
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final String? languageCode;
  final String? currency;

  UpdateUserParams(
      {this.languageCode, this.email, this.phoneNumber, this.photoUrl, this.currency});
}