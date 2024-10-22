import 'package:aissam_store_v2/app/buisness/core/langs_and_currencies.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/currency.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/animated_scale_fade.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/tertiary.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'sliver_aware.dart';

class CurrencyButton extends StatefulWidget {
  const CurrencyButton(
      {super.key,
      required this.initialSelectedCurrency,
      required this.onSelectCurrency});
  final Currency initialSelectedCurrency;
  final Function(Currency) onSelectCurrency;

  @override
  State<CurrencyButton> createState() => _CurrencyButtonState();
}

class _CurrencyButtonState extends State<CurrencyButton> {
  final GlobalKey _buttonKey = GlobalKey();
  late Currency _selectedCurrecy = widget.initialSelectedCurrency;

  @override
  Widget build(BuildContext context) {
    return SliverAware(
      child: TertiaryButton(
        onPressed: _showList,
        key: _buttonKey,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 25,
              child: FittedBox(
                child: Text(
                  _selectedCurrecy.symbol ?? '',
                  style: context.textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(_selectedCurrecy.currencyName),
            const Spacer(),
            const Icon(
              FluentIcons.chevron_up_down_24_regular,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showList() {
    final renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final btnPosition = renderBox.localToGlobal(Offset.zero);
    final btnSize = renderBox.size;
    var screenSize = MediaQuery.sizeOf(context);
    screenSize =
        Size(screenSize.width, screenSize.height - ViewConsts.toolbarHeight);
    final topPadding = MediaQuery.paddingOf(context).top;
    print(topPadding);
    final expandHeight = screenSize.height - topPadding - 30 * 2;
    showGeneralDialog(
      transitionDuration: const Duration(seconds: 2),
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      barrierLabel: 'filter-dialog-list',
      barrierColor: Colors.black.withOpacity(.4),
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

        final widthAnimation = animation.drive(Tween(
            begin: btnSize.width,
            end: screenSize.width - ViewConsts.pagePadding * 2));

        final leftAnimation = animation.drive(
          Tween(
            begin: btnPosition.dx,
            end: screenSize.width / 2 -
                (screenSize.width - ViewConsts.pagePadding * 2) / 2,
          ),
        );

        final fadeAnimation =
            animation.drive(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));

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
                  child: Opacity(opacity: fadeAnimation.value, child: child!),
                );
              },
              child: child,
            )
          ],
        );
      },
      pageBuilder: (context, an1, an2) {
        return CurrenciesMenu(
          selectedCurrency: _selectedCurrecy,
          onSelectCurrency: (currency) {
            setState(() {
              _selectedCurrecy = currency;
              widget.onSelectCurrency(currency);
            });
          },
        );
      },
    );
  }
}

class CurrenciesMenu extends StatefulWidget {
  const CurrenciesMenu(
      {super.key,
      required this.selectedCurrency,
      required this.onSelectCurrency});
  final Currency selectedCurrency;
  final Function(Currency selectedCurrency) onSelectCurrency;

  @override
  State<CurrenciesMenu> createState() => _CurrenciesMenuState();
}

class _CurrenciesMenuState extends State<CurrenciesMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colors.a,
      elevation: 10,
      shadowColor: Colors.black.withOpacity(.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.builder(
        itemCount: RegionsAndCurrenciesData.currencies.length,
        // itemExtent: ViewConsts.buttonHeight,
        cacheExtent: 0,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (index == 0)
            return SizedBox(
              height: 66,
              child: Center(
                child: Text(
                  'Select currency',
                  style: context.textTheme.displaySmall,
                ),
              ),
            );
          final currency = RegionsAndCurrenciesData.currencies[index - 1];
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 25,
                    child: FittedBox(
                      child: Text(
                        currency.symbol ?? '',
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    currency.currencyName,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  AnimatedScaleFade(
                    show: currency == widget.selectedCurrency,
                    child: const Icon(
                      FluentIcons.checkmark_24_regular,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
             
              widget.onSelectCurrency(currency);
              context.pop();
            },
          );
        },
      ),
    );
  }
}
