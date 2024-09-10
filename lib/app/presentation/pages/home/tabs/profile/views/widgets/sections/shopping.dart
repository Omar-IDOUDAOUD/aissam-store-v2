import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/widgets/divider.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/widgets/list_tile.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ShoppingSection extends StatelessWidget {
  const ShoppingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const [
        ListTile2(
          icon: FluentIcons.location_24_regular,
          label: 'Addresses',
        ),
        Divider2(),
        ListTile2(
          icon: FluentIcons.payment_24_regular,
          label: 'Payment methods',
          trainingCount: 2,
        ),
        Divider2(),
        ListTile2(
          icon: FluentIcons.location_live_24_regular,
          label: 'Discout coupon',
          traininglabel: 'dark',
        ),
      ],
    );
  }
}
