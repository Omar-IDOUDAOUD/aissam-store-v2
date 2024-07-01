import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/app/buisness/template/domain/entities/name.dart';
import 'package:aissam_store_v2/app/buisness/template/domain/repositories/name.dart';
import 'package:aissam_store_v2/app/core/errors/failures.dart';
import 'package:aissam_store_v2/app/core/usecase/usecase.dart';

class NameParams {
  late final String id;

  NameParams({ required this.id});
}

class Name implements UseCase<NameEntity, NameParams> {
  final NameRepository repository;

  Name(this.repository);

  @override
  Future<Either<Failure, NameEntity>> call(NameParams params) async {
    return await repository.operation();
  }
}