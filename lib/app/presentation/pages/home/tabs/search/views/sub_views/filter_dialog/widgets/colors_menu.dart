import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/animated_scale_fade.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ColorsMenu extends StatefulWidget {
  const ColorsMenu(
      {super.key, required this.selectedColors, required this.onSelectColor});
  final List<int> selectedColors;
  final Function(List<int> colorIndex) onSelectColor;

  @override
  State<ColorsMenu> createState() => _ColorsMenuState();
}

class _ColorsMenuState extends State<ColorsMenu> {
  late final List<int> _selectedColors = widget.selectedColors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colors.a,
      elevation: 40,
      shadowColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.builder(
        itemCount: Colors.accents.length,
        itemExtent: ViewConsts.buttonHeight,
        cacheExtent: 0,
        itemBuilder: (context, index) {
          if (index == 0)
            return Center(
              child: Text(
                'Select colors',
                style: context.textTheme.displaySmall,
              ),
            );

          final color = Colors.accents[index];
          return _ListTile(
            selected: _selectedColors.contains(index),
            color: color,
            title: color.value.toString(),
            onTap: () {
              setState(() {
                _selectedColors.contains(index)
                    ? _selectedColors.remove(index)
                    : _selectedColors.add(index);
              });
              widget.onSelectColor(_selectedColors);
            },
          );
        },
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(
      {super.key,
      required this.title,
      required this.color,
      required this.selected,
      required this.onTap});
  final String title;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 12),
          SizedBox(
            width: 40,
            height: 14,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2), color: color)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Color name',
                style: context.textTheme.bodyMedium,
              ),
              Text(
                title,
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.theme.colors.s,
                ),
              ),
            ],
          ),
          const Spacer(),
          AnimatedScaleFade(
            show: selected,
            child: const Icon(
              FluentIcons.checkmark_24_regular,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
