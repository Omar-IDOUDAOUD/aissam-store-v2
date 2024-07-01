


import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/template/domain/entities/name.dart';
import 'package:aissam_store_v2/app/buisness/template/domain/repositories/name.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';

class NameRepositoryImpl implements NameRepository{
  
  @override
  Future<Either<Failure, NameEntity>> operation() {
    throw UnimplementedError();
  }

}