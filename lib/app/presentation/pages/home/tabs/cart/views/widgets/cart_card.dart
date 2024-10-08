import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/card_states.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/checkbox.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final double _height = 115;

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.index,
    required this.onSelect,
    required this.doSelectOnTap,
    required this.state,
  });
  final String index;
  final CardStates state;
  final bool doSelectOnTap;
  final Function(bool) onSelect;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      value: 1.0,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: ViewConsts.animationCurve);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CartCard oldWidget) {
    if (widget.state == CardStates.restored) {
      _animationController.forward();
    } else if (widget.state == CardStates.trash) {
      _animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final doAnimation = widget.state.isTrash || widget.state.isRestored;
    return doAnimation
        ? AnimatedBuilder(
            animation: _animation,
            builder: (_, __) => SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1,
              child: _child,
            ),
          )
        : widget.state.isDeleted
            ? const SizedBox.shrink()
            : _child;
  }

  Widget get _child => Padding(
        padding: const EdgeInsets.only(bottom: ViewConsts.seperatorSize),
        child: GestureDetector(
          onTap: () {
            if (widget.state.isSelected) {
              widget.onSelect(false);
            } else if (widget.doSelectOnTap) {
              widget.onSelect(true);
            }
          },
          onLongPress: () => widget.onSelect(!widget.state.isSelected),
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
                      color: widget.state.isSelected
                          ? context.theme.focusColor
                          : context.theme.colors.a,
                      border: Border.all(
                        color: widget.state.isSelected
                            ? context.theme.colors.d
                            : context.theme.colors.a,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.index.toString()),
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
                              selected: widget.state.isSelected,
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
        ),
      );
  Widget _quantityButton(IconData icon) {
    return SizedBox.square(
      dimension: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              widget.state.isSelected ? context.theme.colors.a : context.theme.colors.t,
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

   