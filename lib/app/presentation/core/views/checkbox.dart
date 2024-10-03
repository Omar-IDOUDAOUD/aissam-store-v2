import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/animated_scale_fade.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class Checkbox2 extends StatefulWidget {
  const Checkbox2({super.key, required this.selected, required this.onChange});
  final bool selected;
  final Function(bool) onChange;

  @override
  State<Checkbox2> createState() => _Checkbox2State();
}

class _Checkbox2State extends State<Checkbox2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChange(!widget.selected),
      child: SizedBox.square(
        dimension: 20,
        child: AnimatedContainer(
          duration: ViewConsts.animationDuration,
          curve: ViewConsts.animationCurve,
          decoration: BoxDecoration(
            color:
                widget.selected ? context.theme.colors.d : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: widget.selected
                ? null
                : Border.all(color: context.theme.colors.t, width: 1.5),
          ),
          child: AnimatedScaleFade(
            show: widget.selected,
            child: const Icon(
              FluentIcons.checkmark_24_regular,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
