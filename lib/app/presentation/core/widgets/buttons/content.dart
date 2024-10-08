import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ButtonFormat1 extends StatelessWidget {
  const ButtonFormat1({super.key, required this.label, this.icon});
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = DefaultTextStyle.of(context).style.color!;
    Widget text() => Text(
          label,
          style: context.textTheme.bodyMedium!.copyWith(color: color),
        );
    return icon == null
        ? Center(child: text())
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.theme.iconTheme.size,
              ),
              text(),
              Icon(
                icon,
                color: color.withOpacity(.5),
                size: 20,
              ),
            ],
          );
  }
}

class ButtonFormat2 extends StatelessWidget {
  const ButtonFormat2(
      {super.key,
      required this.label,
      required this.icon,
      this.subLabel});
  final String label;
  final String? subLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = DefaultTextStyle.of(context).style.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.textTheme.bodyLarge!
                  .copyWith(color: color, fontWeight: FontWeight.w600),
            ),
            if (subLabel != null)
            Text(
              subLabel!,
              style: context.textTheme.bodySmall!
                  .copyWith(color: color!.withOpacity(.8)),
            ),
          ],
        ),
        Icon(
          icon,
          color: color,
        ),
      ],
    );
  }
}

class ButtonFormat3 extends StatelessWidget {
  const ButtonFormat3({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: DefaultTextStyle.of(context).style.color,
    );
  }
}
