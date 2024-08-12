import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/checkbox.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final double _height = 105;

class WishlistCard extends StatefulWidget {
  const WishlistCard(
      {super.key, required this.onSelect, required this.seleted});
  final Function(bool) onSelect;
  final bool seleted;

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
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
                                    boxShadow: [
                    // BoxShadow(
                    //   offset: const Offset(0, -2),
                    //   blurRadius: 5,
                    //   color: Colors.black.withOpacity(.05),
                    // )
                  ],
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

}
