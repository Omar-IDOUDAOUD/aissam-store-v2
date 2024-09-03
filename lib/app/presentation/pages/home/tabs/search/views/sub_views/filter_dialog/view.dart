import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/buttons/content.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/buttons/primary_button.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/buttons/secondary_button.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'discover_categories_page/view.dart';
import 'widgets/add_color_btn.dart';
import 'widgets/button.dart';
import 'widgets/chip.dart';
import 'widgets/selectable_chip.dart';
import 'widgets/text_field.dart';
import 'widgets/title.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.filters});

  final SearchProductFilterParams filters;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late final SearchProductFilterParams _newFilters = widget.filters;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colors.b,
      elevation: 20,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                const _Appbar(),
                _Body(
                  filters: _newFilters,
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: context.theme.colors.t,
          ),
          _Action(
            onSave: () {
              Navigator.pop(context, _newFilters);
            },
          ),
        ],
      ),
    );
  }
}

class _Appbar extends ConsumerWidget {
  const _Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      primary: false,
      pinned: true,
      title: Text(
        'Filter search',
        style: context.textTheme.displaySmall,
      ),
      automaticallyImplyLeading: false,
      actions: ref.read(viewProvider).searchFilters.isEmpty
          ? null
          : [
              IconButton(
                onPressed: () {
                  ref.read(viewProvider.notifier).searchFilters =
                      SearchProductFilterParams.empty();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FluentIcons.delete_24_regular,
                  size: 25,
                ),
              ),
              const SizedBox(width: 5)
            ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({super.key, required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const ButtonFormat1(label: 'Cancel'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: PrimaryButton(
              onPressed: onSave,
              child: const ButtonFormat1(label: 'Save'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key, required this.filters});

  final SearchProductFilterParams filters;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController _minPriceController = TextEditingController(
    text:
        widget.filters.minPrice == 0 ? '' : widget.filters.minPrice.toString(),
  );
  late final TextEditingController _maxPriceController = TextEditingController(
    text: widget.filters.maxPrice.isInfinite
        ? ''
        : widget.filters.maxPrice.toString(),
  );

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList.list(
        children: [
          Title2(
            title: 'Size',
            suffix: widget.filters.sizes.isNotEmpty
                ? '${widget.filters.sizes.length} sizes'
                : 'all',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _sizeChip('M'),
              _sizeChip('S'),
              _sizeChip('L'),
              _sizeChip('XL'),
              _sizeChip('XXL'),
            ],
          ),
          const SizedBox(height: 12),
          Title2(
              title: 'Price',
              suffix: widget.filters.minPrice == 0 &&
                      widget.filters.maxPrice.isInfinite
                  ? 'no boundries'
                  : "${widget.filters.minPrice} - ${widget.filters.maxPrice}"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField2(
                  hint: 'min price',
                  controller: _minPriceController,
                  onSubmitted: () {
                    if (widget.filters.minPrice > widget.filters.maxPrice) {
                      widget.filters.maxPrice = widget.filters.minPrice;
                      _maxPriceController.text =
                          widget.filters.minPrice.toString();
                      setState(() {});
                    }
                  },
                  onChange: (str) {
                    if (str.isEmpty)
                      widget.filters.minPrice = 0;
                    else {
                      try {
                        widget.filters.minPrice = double.parse(str);
                      } catch (e) {
                        _minPriceController.text =
                            widget.filters.minPrice.toString();
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField2(
                  hint: 'max price',
                  controller: _maxPriceController,
                  onSubmitted: () {
                    if (widget.filters.maxPrice < widget.filters.minPrice) {
                      widget.filters.minPrice = widget.filters.maxPrice;
                      _minPriceController.text =
                          widget.filters.maxPrice.toString();
                      setState(() {});
                    }
                  },
                  onChange: (str) {
                    if (str.isEmpty)
                      widget.filters.maxPrice = double.infinity;
                    else {
                      try {
                        widget.filters.maxPrice = double.parse(str);
                      } catch (e) {
                        _maxPriceController.text =
                            widget.filters.maxPrice.toString();
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Title2(
              title: 'Categories',
              suffix: widget.filters.categories.isNotEmpty
                  ? '${widget.filters.categories.length} categories'
                  : 'all'),
          if (widget.filters.categories.isNotEmpty) const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              widget.filters.categories.length,
              (index) => Chip2(
                label: widget.filters.categories[index].name,
                onRemove: () {
                  setState(() {
                    widget.filters.categories.removeAt(index);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Button(
            label: 'Add category',
            icon: FluentIcons.add_24_regular,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCategoriesPage(
                    selectedCategories: widget.filters.categories,
                  ),
                ),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 12),
          Title2(
              title: 'Colors',
              suffix: widget.filters.colorNames.isNotEmpty == true
                  ? '${widget.filters.colorNames.length} colors'
                  : 'all'),
          if (widget.filters.colorNames.isNotEmpty == true)
            const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              widget.filters.colorNames.length,
              (index) => Chip2(
                label: widget.filters.colorNames[index].toString(),
                leadingColor: Colors.accents[widget.filters.colorNames[index]],
                onRemove: () {
                  setState(() {
                    widget.filters.colorNames.removeAt(index);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          AddColorsButton(
            selectedColors: List.from(widget.filters.colorNames),
            onSelectColors: (colors) {
              setState(() {
                widget.filters.colorNames = colors;
              });
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _sizeChip(String label) {
    return SelectableChip(
      label: label,
      selected: widget.filters.sizes.contains(label),
      onPressed: () {
        if (widget.filters.sizes.contains(label))
          widget.filters.sizes.remove(label);
        else
          widget.filters.sizes.add(label);
        setState(() {});
      },
    );
  }
}
