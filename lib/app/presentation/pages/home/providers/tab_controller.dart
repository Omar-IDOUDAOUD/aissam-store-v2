 
import 'package:flutter/material.dart' show TabController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabControllerProvider = AutoDisposeProvider<_Provider>((_)=>_Provider());


class _Provider{
  late final TabController tabController; 
}