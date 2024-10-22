import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extentions/theme.dart';
import 'package:flutter/material.dart';

Future<T?> showDialog2<T>({
  required BuildContext context,
  required Widget body,
  bool dismissible = true,
}) {
  return showGeneralDialog<T>(
    transitionDuration: ViewConsts.animationDuration2,
    context: context,
    useRootNavigator: false,
    barrierDismissible: dismissible,
    barrierLabel: 'barrier-label-dialog',
    barrierColor: Colors.black.withOpacity(.4),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final an = CurvedAnimation(
        parent: animation,
        curve: ViewConsts.animationCurve,
        reverseCurve: ViewConsts.animationCurve.flipped,
      );
      final scaleAn = an.drive(Tween(begin: 0.95, end: 1.0));
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FadeTransition(
            opacity: an,
            child: ScaleTransition(
              scale: scaleAn,
              child: child,
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => Center(
      widthFactor: 0,
      child: Material(
        color: context.theme.colors.a,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        child: body,
      ),
    ),
  );
}

class Dialog2Title extends StatelessWidget {
  const Dialog2Title({
    super.key,
    required this.title,
    // this.onSave,
    // this.onCancel,
    // this.cancelIcon,
    // this.saveIcon,
    // this.applySaveIcon = false,
    // this.applyCancelIcon = true,
  });
  // final bool applySaveIcon;
  // final bool applyCancelIcon;
  // final Function()? onSave;
  // final Function()? onCancel;
  // final IconData? cancelIcon;
  // final IconData? saveIcon;

  /// it can be text or widget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          style: context.textTheme.displaySmall,
          textAlign: TextAlign.center,
          maxLines: 2,
          title,
        ),
      ),
    );
  }
}

class Dialog2Skeleton extends StatelessWidget {
  const Dialog2Skeleton(
      {super.key, this.title, required this.body, this.action});
  final Widget? title;
  final Widget body;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 5),
        if (title != null) title!,
        body,
        if (action != null)
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end, children: action!),
          )
          else const SizedBox(height: 10),
      ],
    );
  }
}
