import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../class.dart';
 


class CategoryCart extends StatelessWidget {
  const CategoryCart({
    super.key,
    required this.onSelectSubCategory,
    required this.categorySelection,
    required this.data,
    required this.index,
  });

  final Function(bool select, CategorySelection? subCategory) onSelectSubCategory;
  final CategorySelection categorySelection;
  final Category data; 
  final int index; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onSelectSubCategory(
              categorySelection.subCategoryIndex != index,
              CategorySelection(
                parentCategory:
                    categorySelection.subCategoryName,
                subCategoryName: data.name,
                subCategoryIndex: index,
              ),
            );
          },
          child: SizedBox(
            width: 80,
            height: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    ViewConsts.radius),
                color:
                    const Color.fromARGB(255, 255, 30, 0),
              ),
              child: Center(
                child: Text(data.name),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity:
              categorySelection.subCategoryIndex == index
                  ? 1
                  : 0,
          duration: const Duration(seconds: 2),
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              FluentIcons.chevron_down_24_regular,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
