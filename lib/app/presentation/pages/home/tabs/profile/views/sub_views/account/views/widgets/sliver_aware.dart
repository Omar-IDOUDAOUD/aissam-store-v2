import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:flutter/material.dart';



class SliverAware extends StatelessWidget {
  const SliverAware({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
        sliver: SliverToBoxAdapter(child: child));
  }
}

