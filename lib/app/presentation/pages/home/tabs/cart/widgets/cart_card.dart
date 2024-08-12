import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/checkbox.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final double _height = 115;

class CartCard extends StatefulWidget {
  const CartCard({super.key, required this.onSelect, required this.seleted});
  final Function(bool) onSelect;
  final bool seleted;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.seleted) {
          widget.onSelect(false);
        }
      },
      child: SizedBox(
        height: _height,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ViewConsts.radius),
                child: Image.network(
                  'https://treasuresofmorocco.com/wp-content/uploads/2015/10/djellaba-black-h-415x644.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: AnimatedContainer(
                padding: const EdgeInsets.all(10),
                duration: ViewConsts.animationDuration,
                curve: ViewConsts.animationCurve,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ViewConsts.radius),
                  color: widget.seleted
                      ? context.theme.focusColor
                      : context.theme.colors.a,
                  border: Border.all(
                    color: widget.seleted
                        ? context.theme.colors.d
                        : context.theme.colors.a,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Djellaba wa3ra, Z3em takol lham'),
                    Text(
                      'Available • 25 sales',
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.theme.colors.s),
                    ),
                    Text(
                      '5 colors • Mliffa',
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.theme.colors.s),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            '200.00 DH',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.theme.colors.d,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _quantityButton(FluentIcons.subtract_24_regular),
                        const SizedBox(width: 5),
                        Text(
                          '2',
                          style: context.textTheme.bodyMedium!.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 5),
                        _quantityButton(FluentIcons.add_24_regular),
                        const SizedBox(width: 5),
                        Checkbox2(
                          selected: widget.seleted,
                          onChange: (bool b) {
                            widget.onSelect(b);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon) {
    return SizedBox.square(
      dimension: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              widget.seleted ? context.theme.colors.a : context.theme.colors.t,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          color: context.theme.colors.p,
          size: 18,
        ),
      ),
    );
  }
}
