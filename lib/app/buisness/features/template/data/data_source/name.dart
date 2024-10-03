

import 'package:aissam_store_v2/app/buisness/features/template/data/models/name.dart';

abstract class NameDataSource {
  Future<NameModel> getData(params); 
}

class NameDataSourceImpl implements NameDataSource {

  @override
  Future<NameModel> getData(params) {
    throw UnimplementedError();
  }

}
