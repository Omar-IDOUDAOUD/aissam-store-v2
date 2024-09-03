import 'package:aissam_store_v2/app/presentation/config/constants.dart';

import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/widgets/category_list.dart';
import 'package:flutter/material.dart';

import '../class.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key, required this.onSelectCatgory});
  final Function(String? category) onSelectCatgory;
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final List<CategorySelection> _selections = [
    CategorySelection(parentCategory: null)
  ];

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      initialItemCount: _selections.length,
      itemBuilder: (context, index, animation) {
        
        final an =
            animation.drive(CurveTween(curve: ViewConsts.animationCurve));
        return SizeTransition(
          sizeFactor: an,
          axisAlignment: 2,
          child: FadeTransition(
            opacity: an,
            child: CategoryList(
              categorySelection: _selections[index],
              onSelectSubCategory:
                  (bool select, CategorySelection? newSubCategory) async {
                for (var i = _selections.length - 1; i > index; i--) {
                  final removedCategory = _selections[i];
                  SliverAnimatedList.of(context).removeItem(
                    i,
                    (_, an) {
                      return FadeTransition(
                        opacity: an,
                        child: SizeTransition(
                          axisAlignment: -1,
                          sizeFactor: an,
                          child: CategoryList(
                            categorySelection: removedCategory,
                            onSelectSubCategory: (_, __) {},
                          ),
                        ),
                      );
                    },
                    duration: const Duration(seconds: 2),
                  );
                  _selections.removeAt(i);
                  await Future.delayed(Duration(seconds: 2));
                }
                if (select) {
                  print('SELECTE');
                  _selections[index].setSubCategory(
                    name: newSubCategory!.subCategoryName!,
                    index: newSubCategory.subCategoryIndex!,
                  );
                  _selections.add(
                    CategorySelection(
                      parentCategory: newSubCategory.subCategoryName,
                    ),
                  );
                  SliverAnimatedList.of(context).insertItem(
                    index + 1,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  _selections[index].unsetSubCategory();
                  // if (_selections.length > 1)
                  //   widget.onSelectCatgory(_selections.last.parentCategory);
                  setState(() {});
                }
                widget.onSelectCatgory(_selections[index].subCategoryName);
              },
            ),
          ),
        );
      },
    );
  }
}
