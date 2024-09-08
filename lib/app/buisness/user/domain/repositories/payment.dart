import 'dart:async';

import 'package:aissam_store_v2/app/buisness/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/user/domain/entities/user.dart';
import 'package:aissam_store_v2/services/connection_checker.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb show User;


abstract interface class PaymentRepository {
  Future<Either<Failure, int>> countCards(); 
}
