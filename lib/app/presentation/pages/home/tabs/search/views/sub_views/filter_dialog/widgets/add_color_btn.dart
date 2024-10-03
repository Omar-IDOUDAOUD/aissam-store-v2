import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/config/routing/config.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'colors_menu.dart';

class AddColorsButton extends StatefulWidget {
  const AddColorsButton(
      {super.key, required this.onSelectColors, required this.selectedColors});
  final Function(List<int> colors) onSelectColors;
  final List<int> selectedColors;

  @override
  State<AddColorsButton> createState() => _AddColorsButtonState();
}

class _AddColorsButtonState extends State<AddColorsButton> {
  final GlobalKey _buttonKey = GlobalKey();
  List<int>? _selectedNewColors;

  @override
  Widget build(BuildContext context) {
    return Button(
      key: _buttonKey,
      label: 'Add colors',
      icon: FluentIcons.add_24_regular,
      onTap: () async {
        final renderBox =
            _buttonKey.currentContext!.findRenderObject() as RenderBox;
        final btnPosition = renderBox.localToGlobal(Offset.zero);
        final btnSize = renderBox.size;
        var screenSize = MediaQuery.sizeOf(context);
        screenSize = Size(
            screenSize.width, screenSize.height - ViewConsts.toolbarHeight);
        final topPadding = MediaQuery.paddingOf(rootNavigatorKey.currentContext!).top; 
        print(topPadding);
        final expandHeight = screenSize.height - topPadding - 30*2;

        await showGeneralDialog(
          transitionDuration: const Duration(seconds: 2),
          context: context,
          barrierDismissible: true,
          useRootNavigator: false,
          barrierLabel: 'filter-dialog-list',
          barrierColor: Colors.transparent,
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: ViewConsts.animationCurve,
              reverseCurve: ViewConsts.animationCurve.flipped,
            );
            final heightAnimation = animation.drive(
              Tween(
                begin: btnSize.height,
                end: expandHeight,
              ),
            );
            final topAnimation = animation.drive(
              Tween(
                begin: btnPosition.dy,
                end: screenSize.height / 2 - expandHeight / 2 + topPadding / 2,
              ),
            );

            final widthAnimation = animation.drive(
                Tween(begin: btnSize.width, end: screenSize.width - 30 * 2));

            final leftAnimation = animation.drive(
              Tween(
                begin: btnPosition.dx,
                end: screenSize.width / 2 - (screenSize.width - 30 * 2) / 2,
              ),
            );

            final fadeAnimation = animation
                .drive(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));

            return Stack(
              children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Positioned(
                      height: heightAnimation.value,
                      top: topAnimation.value,
                      width: widthAnimation.value,
                      left: leftAnimation.value,
                      child:
                          Opacity(opacity: fadeAnimation.value, child: child!),
                    );
                  },
                  child: child,
                )
              ],
            );
          },
          pageBuilder: (context, an1, an2) {
            return ColorsMenu(
              selectedColors: widget.selectedColors,
              onSelectColor: (selectedColors) {
                _selectedNewColors = selectedColors;
              },
            );
          },
        );
        if (_selectedNewColors != null)
          widget.onSelectColors(_selectedNewColors!);
      },
    );
  }
}
