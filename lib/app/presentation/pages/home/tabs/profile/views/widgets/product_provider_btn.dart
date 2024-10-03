import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/formats.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/secondary.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ChangeProductProviderButton extends StatelessWidget {
  const ChangeProductProviderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          ViewConsts.pagePadding, 13, ViewConsts.pagePadding, 0),
      sliver: SliverToBoxAdapter(
        child: SecondaryButton( 
          onPressed: (){},
          child: const ButtonFormat1(
            label: 'Change products provider',
            icon: FluentIcons.edit_24_regular,
          ),
        ),
      ),
    );
  }
}
