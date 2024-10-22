import 'entities/country.dart';
import 'entities/currency.dart';
import 'entities/language.dart';






abstract class RegionsAndCurrenciesData {
  static Currency? lookForCurrency(String? currencyCode) {
    if (currencyCode == null) return null; 
    return currencies
        .where((element) => element.currencyCode == currencyCode)
        .firstOrNull;
  }

  static Currency? lookForCurrencyByLanguage(String? languageCode) {
    if (languageCode == null) return null; 
    return currencies
        .where((element) => element.forLanguages.contains(languageCode))
        .firstOrNull;
  }

  static Language? lookForLanguage(String? languageCode) {
    if (languageCode == null) return null; 
    return languages
        .where((element) => element.languageCode == languageCode)
        .firstOrNull;
  }

  static Country? lookForCountry(String? countryCode) {
    if (countryCode == null) return null; 
    return countries
        .where((element) => element.countryCode == countryCode)
        .firstOrNull;
  }

  static final List<Country> countries = [
    Country(countryName: 'United States', countryCode: 'US'),
    Country(countryName: 'Saudi Arabia', countryCode: 'SA'),
    Country(countryName: 'Morocco', countryCode: 'MA'),
    Country(countryName: 'France', countryCode: 'FR'),
    Country(countryName: 'Spain', countryCode: 'ES'),
  ];
  static final List<Language> languages = [
    Language(languageName: 'English', languageCode: 'en'),
    Language(languageName: 'Arabic', languageCode: 'ar'),
    Language(languageName: 'French', languageCode: 'fr'),
    Language(languageName: 'Spanish', languageCode: 'es'),
    Language(languageName: 'Moroccan Arabic', languageCode: 'ary'),
    Language(languageName: 'Moroccan Tamazight', languageCode: 'zgh'),
  ];
  static final List<Currency> currencies = [
    Currency(
      currencyName: 'US Dollar',
      currencyCode: 'USD',
      symbol: '\$',
      forLanguages: ['en'],
    ),
    Currency(
      currencyName: 'Saudi Riyal',
      currencyCode: 'SAR',
      symbol: '﷼',
      forLanguages: ['ar'],
    ),
    Currency(
      currencyName: 'Moroccan Dirham',
      currencyCode: 'MAD',
      symbol: 'د.م.',
      forLanguages: ['ary', 'zgh'],
    ),
    Currency(
      currencyName: 'Euro',
      currencyCode: 'EUR',
      symbol: '€',
      forLanguages: ['es', 'fr'],
    ),
  ];
}
