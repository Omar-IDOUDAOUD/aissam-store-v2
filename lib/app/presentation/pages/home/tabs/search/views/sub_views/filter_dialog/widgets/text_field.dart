import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class TextField2 extends StatelessWidget {
  const TextField2({
    super.key,
    required this.hint,
    required this.onChange,
    this.controller,
     this.onSubmitted,
  });
  final String hint;
  final Function(String value) onChange;
  final TextEditingController? controller;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: context.textTheme.bodyMedium,
      onChanged: onChange,
      onSubmitted: (_) => onSubmitted?.call(),
      decoration: InputDecoration(
        hintStyle: context.textTheme.bodyMedium!
            .copyWith(color: context.theme.colors.s),
        hintText:hint,
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ViewConsts.radius),
          borderSide: BorderSide(
            color: context.theme.colors.t,
            width: 2,
          ),
        ),
      ),
    );
  }
}
