import 'dart:math';

import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    this.extraLabels,
    this.initialSelectedTab = 0,
    required this.labels,
    required this.onSelect,
    this.onUnSelect,
    this.onSelectExtraLabel,
    this.onUnSelectExtraLabel,
  });

  final List<String> labels;
  final List<Widget>? extraLabels;
  final int initialSelectedTab;
  final Function(int index) onSelect;
  final Function(int index)? onUnSelect;
  final Function(int index)? onSelectExtraLabel;
  final Function(int index)? onUnSelectExtraLabel;

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
          return GestureDetector(
            onTap: () {
              if (index < widget.labels.length) {
                if (_selectedIndex == index)
                  widget.onUnSelect?.call(index);
                else
                  widget.onSelect(index);
                _selectedIndex = index;
                return;
              }
              if (_selectedIndex == index)
                widget.onUnSelectExtraLabel?.call(index - widget.labels.length);
              else
                widget.onSelectExtraLabel?.call(index - widget.labels.length);
            },
            child: () {
              if (index < widget.labels.length)
                return Tab2(
                  label: widget.labels[index],
                  selected: _selectedIndex == index,
                );
              return widget.extraLabels?[index - widget.labels.length];
            }.call(),
          );
        },
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({super.key, required this.label, required this.selected});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ViewConsts.animationDuration,
      curve: ViewConsts.animationCurve,
      decoration: BoxDecoration(
        color: selected ? context.theme.colors.d : context.theme.colors.a,
        borderRadius: BorderRadius.circular(ViewConsts.chipHeight / 2),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 2,
            color: Colors.black.withOpacity(selected ? 0 : 0.05),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            label,
            style: context.textTheme.bodyMedium!.copyWith(
              color: selected ? context.theme.colors.a : context.theme.colors.s,
            ),
          ),
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
