import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/checkbox.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.data,
    required this.index,
    required this.selected,
    required this.onSelect,
  });

  final Category data;
  final int index;
  final bool selected;
  final Function(bool) onSelect;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.selected);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ViewConsts.radius),
          color: Colors.grey.shade500,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.data.name),
              ],
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Checkbox2(
                selected: widget.selected,
                onChange: widget.onSelect,
              ),
            )
          ],
        ),
      ),
    );
  }
}
