import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:flutter/material.dart';

class Title2 extends StatelessWidget {
  const Title2({
    super.key,
    required this.title,
    required this.suffix,
  });

  final String title;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium,
        ),
        Expanded(
          child: Text(
            suffix,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium!
                .copyWith(color: context.theme.colors.s),
          ),
        ),
      ],
    );
  }
}
