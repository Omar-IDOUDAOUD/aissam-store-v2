








import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Divider2 extends StatelessWidget {
  const Divider2({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      endIndent: ViewConsts.pagePadding,
      indent: ViewConsts.pagePadding,
      color: context.theme.colors.t,
    );
  }
}