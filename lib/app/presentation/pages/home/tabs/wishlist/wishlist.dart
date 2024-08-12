import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/widgets/wishlist_card.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/animated_scale_fade.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/buttons/content.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/buttons/primary_button.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/buttons/secondary_button.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class WishlistTab extends StatefulWidget {
  WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  List<int> _selections = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _Content(
            selections: _selections,
            onChange: (p0) {
              setState(() {
                _selections = p0;
              });
            },
          ),
        ),
        AnimatedPositioned(
          duration: ViewConsts.animationDuration2,
          curve: ViewConsts.animationCurve,
          bottom: _selections.isEmpty ? -100 : 0,
          right: 0,
          left: 0,
          child: const _SelectionButtons(),
        )
      ],
    );
  }
}

class _SelectionButtons extends StatelessWidget {
  const _SelectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colors.a,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(ViewConsts.pagePadding),
        child: Row(
          children: [
            SecondaryButton(
              child: ButtonFormat3(icon: FluentIcons.delete_24_regular),
            ),
            SizedBox(width: ViewConsts.seperatorSize),
            Expanded(
              child: PrimaryButton(
                child: ButtonFormat2(
                  subLabel: "2 elements • 400.00 DH",
                  label: 'Add to Cart',
                  icon: FluentIcons.cart_24_regular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content(
      {super.key, show, required this.onChange, required this.selections});

  final Function(List<int>) onChange;
  final List<int> selections;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool get _isThereSelcetions => widget.selections.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Wishlist'),
          leadingWidth: MediaQuery.sizeOf(context).width * 0.3,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: ViewConsts.pagePadding),
              child: Text.rich(
                TextSpan(
                  children: [
                    if (widget.selections.isNotEmpty) ...[
                      TextSpan(
                        text: widget.selections.length.toString(),
                        style: context.textTheme.displayMedium,
                      ),
                      TextSpan(
                        text: ' selected',
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: context.theme.colors.s),
                      )
                    ] else ...[
                      TextSpan(
                        text: '100',
                        style: context.textTheme.displayMedium,
                      ),
                      TextSpan(
                        text: ' items',
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: context.theme.colors.s),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
          actions: [
            AnimatedScaleFade(
              show: _isThereSelcetions,
              child: IconButton(
                onPressed: () {
                  widget.onChange([]);
                },
                icon: const Icon(
                  FluentIcons.dismiss_24_regular,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
              horizontal: ViewConsts.pagePadding, vertical: 10),
          sliver: SliverList.separated(
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(
              height: ViewConsts.seperatorSize,
            ),
            itemBuilder: (context, index) => WishlistCard(
              seleted: widget.selections.contains(index),
              onSelect: (select) {
                if (select)
                  widget.selections.add(index);
                else if (!select) widget.selections.remove(index);
                widget.onChange(widget.selections);
              },
            ),
          ),
        ),
      ],
    );
  }
}
