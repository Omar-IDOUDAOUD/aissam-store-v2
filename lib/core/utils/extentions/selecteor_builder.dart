
import 'package:mongo_dart/mongo_dart.dart';




extension SelectorBuilderExtension on SelectorBuilder {
  /// shortcut for: where..id(ObjectId.fromHexString(hexString))
  SelectorBuilder id2(String hexString) {
    return id(ObjectId.fromHexString(hexString));
  }
}
