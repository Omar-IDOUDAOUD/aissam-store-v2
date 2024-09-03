import 'package:aissam_store_v2/app/presentation/config/constants.dart';
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
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;
        final screenSize = MediaQuery.sizeOf(context);
        final expandHeight = screenSize.height * 0.8;

        await showGeneralDialog(
          transitionDuration: Duration(seconds: 2),
          context: context,
          barrierDismissible: true,
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
                begin: size.height,
                end: expandHeight,
              ),
            );
            final topAnimation = animation.drive(Tween(
                begin: position.dy,
                end: screenSize.height / 2 - expandHeight / 2));

            final widthAnimation = animation.drive(
                Tween(begin: size.width, end: screenSize.width - 30 * 2));

            final leftAnimation = animation.drive(
              Tween(
                begin: position.dx,
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
