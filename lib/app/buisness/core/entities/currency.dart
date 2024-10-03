// ignore_for_file: public_member_api_docs, sort_constructors_first

class Currency {
  final String currencyName;
  final String currencyCode;
  final String? symbol;
  final List<String> forLanguages;

  Currency(
      {required this.currencyName,
      required this.currencyCode,
      this.symbol,
      required this.forLanguages});

  @override
  String toString() {
    return 'Currency(currencyName: $currencyName, currencyCode: $currencyCode, symbol: $symbol, forLanguages: $forLanguages)';
  }
}
