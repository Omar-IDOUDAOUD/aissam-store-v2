// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

enum ProductsPerformance {
  best_sellers,
  trending,
  top_rated,
  new_arrivals,
  discount;

  @override
  String toString() {
    return name.capitalizeFirst!.replaceAll('_', ' ');
  }
}
