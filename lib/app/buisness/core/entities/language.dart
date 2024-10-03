// ignore_for_file: public_member_api_docs, sort_constructors_first

class Language {
  final String languageName;
  final String languageCode;

  Language({required this.languageName, required this.languageCode});

  @override
  String toString() => 'Language(languageName: $languageName, languageCode: $languageCode)';
}
