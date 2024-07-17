import 'package:aissam_store_v2/app/presentation/test.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mongo_db_driver/mongo_db_driver.dart';
import 'package:mongo_db_query/mongo_db_query.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  runApp(const ProviderScope(child: AissamStoreV2()));
}

class AissamStoreV2 extends StatelessWidget {
  const AissamStoreV2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestPage(),
    );
  }
}
