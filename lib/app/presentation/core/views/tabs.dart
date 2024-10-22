import 'dart:math';

import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class TabLabel {
  final String text;
  final Widget? prefix;

  TabLabel({required this.text, this.prefix});
}

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    this.extraLabels,
    this.initialSelectedTab = 0,
    required this.labels,
    required this.onSelect,
    this.onUnSelect,
    // this.onSelectExtraLabel,
    // this.onUnSelectExtraLabel,
  });

  final List<dynamic> labels;
  final List<Widget>? extraLabels;
  final int initialSelectedTab;
  final Function(int index) onSelect;
  final Function(int index)? onUnSelect;
  // final Function(int index)? onSelectExtraLabel;
  // final Function(int index)? onUnSelectExtraLabel;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late int _selectedIndex = widget.initialSelectedTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ViewConsts.chipHeight,
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
        scrollDirection: Axis.horizontal,
        itemCount: widget.labels.length + (widget.extraLabels?.length ?? 0),
        separatorBuilder: (_, __) =>
            const SizedBox(width: ViewConsts.seperatorSize),
        itemBuilder: (BuildContext _, int index) {
          if (index < widget.labels.length) {
          final label = widget.labels[index];
            if (label is TabLabel)
              return _Tab(
                label: widget.labels[index],
                selected: _selectedIndex == index,
                onTap: () {
                  if (_selectedIndex == index)
                    widget.onUnSelect?.call(index);
                  else
                    widget.onSelect(index);
                  _selectedIndex = index;
                  return;
                },
              );
            else
              return label;
          }
          else if (widget.extraLabels != null){
           index -=  widget.labels.length;
           return widget.extraLabels![index];
          }
          return null;
        },
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab(
      {required this.label,
      required this.onTap,
      required this.selected});
  final TabLabel label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap, 
      child: AnimatedContainer(
        duration: ViewConsts.animationDuration, 
        
        height: ViewConsts.chipHeight,
        decoration: BoxDecoration(
        color: selected ? context.theme.colors.d : context.theme.colors.b,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: ViewConsts.borderSideWidth,
            color: selected
                ? Color.lerp(Colors.black, context.theme.colors.d, 0.95)!
                : context.theme.colors.t,
          ),
        ),
        child: Row(
          children: [
            if (label.prefix != null) ...[
              const SizedBox(width: 5),
              label.prefix!,
              const SizedBox(width: 5)
            ] else
              const SizedBox(width: 20),
            Text(
              label.text,
              style: context.textTheme.bodyMedium!.copyWith(
                color: selected ? Colors.white : context.theme.colors.p,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class TabLoading extends StatefulWidget {
  const TabLoading({super.key});

  @override
  State<TabLoading> createState() => _TabLoadingState();
}

class _TabLoadingState extends State<TabLoading> {
  late final double _w = max(Random.secure().nextDouble() * 90, 50);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colors.t,
        borderRadius: BorderRadius.circular(ViewConsts.chipHeight / 2),
      ),
      child: SizedBox(
        width: _w,
      ),
    );
  }
}
