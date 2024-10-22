import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';


abstract interface class AddressesRepository {
  Future<Either<Failure, int>> count(); 
}
