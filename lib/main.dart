import 'package:aissam_store_v2/app/presentation/test.dart';
import 'package:aissam_store_v2/service_locator.dart';
import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mongo_db_driver/mongo_db_driver.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

// void testTransaction() async {
//   final client = MongoClient(
//       'mongodb+srv://omaridoudaoud:4qV9!T2Qi772-SW@cluster0.ytc4tjd.mongodb.net/');
//   await client.connect();
//   final db = client.db(dbName: 'aissam_store_v2');
//   final collection = db.collection('products');
//   final session = client.startSession(
//     clientSessionOptions: SessionOptions()..retryWrites = true..,
//   );

//   try {
//     session.startTransaction(transactionOptions: TransactionOptions());
//     final doc = await collection.findOne(
//       filter: where..id(ObjectId.fromHexString('6695333eb09758b641618fbb')),
//       session: session,
//     );
//     final currentViews = doc!['views'];

//     print(
//         'Wating 20 seconds'); // At this moment, I am changing the views value in MongoDB Compass.
//     await Future.delayed(20.seconds);

//     await collection.updateOne(
//       where..id(ObjectId.fromHexString('6695333eb09758b641618fbb')),
//       UpdateExpression()..$set('views', currentViews + 1),
//       session: session,
//     );

//     final transactionResult = await session.commitTransaction();
//     print('Transaction finished: ');
//     print(transactionResult);
//   } catch (e) {
//     session.abortTransaction();
//     session.endSession();
//     print('Transaction aborted, error: ');
//     print(e);
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  // testTransaction();


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
