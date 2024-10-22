import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/formats.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/primary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/secondary.dart';
import 'package:flutter/material.dart';

import 'sliver_aware.dart';


class Action2 extends StatelessWidget {
  const Action2({super.key, required this.onSave, required this.onIgnore});
final Function() onSave; 
final Function() onIgnore; 


  @override
  Widget build(BuildContext context) {
    return SliverAware (
      child: Row(

        children: [
          Expanded(
            child: SecondaryButton(
              onPressed: onIgnore,
              child: const ButtonFormat1(label: 'Ignore'),
            ),
          ),
          const   SizedBox(width: ViewConsts.seperatorSize),
          Expanded(
            child: PrimaryButton(
              onPressed: onSave,
              child: const ButtonFormat1(label: 'Save'),
            ),
          ),
        ],
      ),
    );
  }
}
