import 'package:aissam_store_v2/core/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ListTile2 extends StatelessWidget {
  const ListTile2(
      {super.key,
      required this.icon,
      required this.label,
      this.trainingCount,
      this.traininglabel});
  final IconData icon;
  final String label;
  final int? trainingCount;
  final String? traininglabel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(label, style: context.textTheme.bodyLarge),
      trailing: _training(context),
      onTap: () {},
    );
  }

  _training(BuildContext context) {
    if (trainingCount != null)
      return CircleAvatar(
        radius: 10,
        backgroundColor: context.theme.colors.t,
        child: Text(
          trainingCount.toString(),
          style: context.textTheme.bodySmall,
        ),
      );
    if (traininglabel != null)
      return Text(
        traininglabel!,
        style: context.textTheme.bodyMedium!.copyWith(
          color: context.theme.colors.s
        ),
      );
    return Icon(
      FluentIcons.chevron_right_24_regular,
      size: 20,
      color: context.theme.colors.s,
    );
  }
}
