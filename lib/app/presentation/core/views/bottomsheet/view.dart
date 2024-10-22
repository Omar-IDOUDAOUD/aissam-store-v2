import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

Future<T?> showBottomSheet2<T>({
  required BuildContext context,
  required Widget body,
  bool dismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: context.theme.scaffoldBackgroundColor,
    elevation: 20,
    isScrollControlled: true,
    useRootNavigator: false,
    barrierLabel: 'barrier-label-bottomsheet',
    barrierColor: Colors.black.withOpacity(.4),
    isDismissible: dismissible,
    sheetAnimationStyle: AnimationStyle(
      duration: ViewConsts.animationDuration2,
      curve: ViewConsts.animationCurve,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (ctx) => body,
  );
}

class _DragHandler extends StatelessWidget {
  const _DragHandler();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.theme.colors.t,
          ),
        ),
      ),
    );
  }
}

class BottomSheet2Title extends StatelessWidget {
  const BottomSheet2Title(
      {super.key,
      this.title,
      this.onSave,
      this.onCancel,
      this.cancelIcon,
      this.saveIcon,
      this.applySaveIcon = false,
      this.applyCancelIcon = true});
  final bool applySaveIcon;
  final bool applyCancelIcon;
  final Function()? onSave;
  final Function()? onCancel;
  final IconData? cancelIcon;
  final IconData? saveIcon;

  /// it can be text or widget;
  final dynamic title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        if (applyCancelIcon)
          IconButton(
            onPressed: onCancel,
            icon: Icon(
              cancelIcon ?? FluentIcons.dismiss_24_regular,
              size: 26,
              // color: context.theme.colors.p,
            ),
          )
        else
          const SizedBox.square(
            dimension: 38,
          ),
        const Spacer(),
        if (title is String)
          Text(
            title,
            style: context.textTheme.displayMedium,
          )
        else if (title is Widget)
          title,
        const Spacer(),
        if (applySaveIcon)
          IconButton(
            onPressed: onSave,
            icon: Icon(
              saveIcon ?? FluentIcons.checkmark_24_regular,
              size: 26,
              // color: context.theme.colors.p,
            ),
          )
        else
          const SizedBox.square(
            dimension: 38,
          ),
        const SizedBox(width: 5),
      ],
    );
  }
}

class Bottomsheet2Skeleton extends StatelessWidget {
  const Bottomsheet2Skeleton(
      {super.key, this.dragHandler = true, this.title, required this.body});
  final bool dragHandler;
  final Widget? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 5),
        if (dragHandler) const _DragHandler(),
        if (title != null) title!,
        const SizedBox(height: 5),
        body,
        const SizedBox(height: ViewConsts.pagePadding),
      ],
    );
  }
}
