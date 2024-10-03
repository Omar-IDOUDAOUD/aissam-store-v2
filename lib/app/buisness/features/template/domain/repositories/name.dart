import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/features/template/domain/entities/name.dart';
import 'package:aissam_store_v2/core/failure.dart';


abstract class NameRepository {

  Future<Either<Failure, NameEntity>> operation(); 

}