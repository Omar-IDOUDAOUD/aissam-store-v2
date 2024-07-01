


import 'package:aissam_store_v2/app/buisness/template/domain/entities/name.dart';

class NameModel extends NameEntity{
  const NameModel({required super.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      id: json['id'],
    );
  }
}