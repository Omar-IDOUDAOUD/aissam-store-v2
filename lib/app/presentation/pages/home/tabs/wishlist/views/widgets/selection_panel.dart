import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/formats.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/primary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/secondary.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/providers/data.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/selection.dart';

class SelectionPanel extends ConsumerWidget {
  const SelectionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colors.a,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(ViewConsts.pagePadding),
        child: Row(
          children: [
            SecondaryButton(
              onPressed:  ref.read(wishlistSelectionsProvider.notifier).moveToTrach,
              child: const ButtonFormat3(icon: FluentIcons.delete_24_regular),
            ),
            const SizedBox(width: ViewConsts.seperatorSize),
            const Expanded(
              child: PrimaryButton(
                child: ButtonFormat2(
                  subLabel: "400.00 DH",
                  label: 'Checkout now',
                  icon: FluentIcons.cart_24_regular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
