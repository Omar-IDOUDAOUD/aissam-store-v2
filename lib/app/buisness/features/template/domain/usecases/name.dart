import 'package:aissam_store_v2/app/buisness/features/template/domain/entities/name.dart';
import 'package:aissam_store_v2/app/buisness/features/template/domain/repositories/name.dart';
import 'package:dartz/dartz.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/buisness/core/interfaces/usecase.dart';

class NameParams {
  late final String id;

  NameParams({ required this.id});
}

class Name implements FutureUseCase<NameEntity, NameParams> {
  final NameRepository repository;

  Name(this.repository);

  @override
  Future<Either<Failure, NameEntity>> call(NameParams params) async {
    return await repository.operation();
  }
}