
import 'package:equatable/equatable.dart';

class NameEntity extends Equatable {
  final String id;

  const NameEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
