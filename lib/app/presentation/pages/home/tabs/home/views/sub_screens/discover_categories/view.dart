import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';

import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/widgets/categories_list.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'widgets/products.dart';

class DiscoverCategoriesSubScreen extends ConsumerStatefulWidget {
  const DiscoverCategoriesSubScreen({super.key});

  @override
  ConsumerState<DiscoverCategoriesSubScreen> createState() =>
      _DiscoverCategoriesSubScreenState();
}

class _DiscoverCategoriesSubScreenState
    extends ConsumerState<DiscoverCategoriesSubScreen> {
  late final ValueNotifier<String?> _selectedCategoryNotifier;
  // late final ValueNotifier<String?> _searchNotifier;

  // late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final FocusNode _searchFocusNode;

  // bool _searchState = false;

  bool _useGrideProductsFormat = false;

  late final _bottomFreeHeight =
      MediaQuery.sizeOf(context).height - ViewConsts.appBarExpandHeight - 100;

  // Future<void> _searchBegin() async {
  //   setState(() {
  //     _searchState = true;
  //   });
  //   await _scrollController.animateTo(
  //     ViewConsts.appBarExpandHeight,
  //     duration: ViewConsts.animationDuration,
  //     curve: ViewConsts.animationCurve,
  //   );
  //   _searchFocusNode.requestFocus();
  // }

  // void _searchEnd() async {
  //   await _scrollController.animateTo(
  //     0,
  //     duration: ViewConsts.animationDuration,
  //     curve: ViewConsts.animationCurve,
  //   );
  //   setState(() {
  //     _searchState = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _searchNotifier = ValueNotifier(null);
    _selectedCategoryNotifier = ValueNotifier(null);
    // _searchController = TextEditingController();
    _scrollController = ScrollController()
      ..addListener(_loadModeDataForGrideFormatListener);
    _searchFocusNode = FocusNode();
  }

  void _loadModeDataForGrideFormatListener() {
    if (_useGrideProductsFormat && _selectedCategoryNotifier.value != null) {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.offset <
          _bottomFreeHeight)
        ref
            .read(productsByCategoriesProvider(_selectedCategoryNotifier.value!)
                .notifier)
            .loadData();
    }
  }

  @override
  void dispose() {
    // _searchNotifier.dispose();
    _selectedCategoryNotifier.dispose();
    // _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget _title(name) => Text(name,
      style:
          context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600));

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.scaffoldBackgroundColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar.large(
            // pinned: !_searchState,
            expandedHeight: ViewConsts.appBarExpandHeight,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(FluentIcons.chevron_left_24_regular),
            ),
            titleSpacing: 8,
            title: Text(
              'Categories',
              style: context.theme.appBarTheme.titleTextStyle,
            ),
            //  Row(

            // children: [
            //   const Spacer(),
            //   Text(
            //     'Categories',
            //     style: context.theme.appBarTheme.titleTextStyle,
            //   ),
            //   const Spacer(),
            //   IconButton(
            //     onPressed: _searchBegin,
            //     icon: const Icon(FluentIcons.search_24_regular),
            //   ),
            // ],
            // ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Categories',
                        style: context.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Discover all kinds of thousands of products by hundereds of categories',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.theme.colors.s,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(
          //         ViewConsts.pagePadding, 15, ViewConsts.pagePadding, 0),
          //     child: TextField(
          //       focusNode: _searchFocusNode,
          //       style: context.textTheme.bodyLarge,
          //       onTap: _searchBegin,
          //       onSubmitted: (_) => _searchEnd(),
          //       onChanged: (value) {
          //         _searchNotifier.value = value.isNotEmpty ? value : null;
          //       },
          //       decoration: InputDecoration(
          //         hintText: 'Search for clothes',
          //         prefixIcon: const Icon(FluentIcons.search_24_regular),
          //         suffixIcon: IconButton(
          //           onPressed: () {},
          //           icon: const Icon(FluentIcons.mic_24_filled),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  ViewConsts.pagePadding, 25, ViewConsts.pagePadding, 15),
              child: _title(
                // _searchState ? 'Search Categories' : 'Main Categories',
                'Main Categories',
              ),
            ),
          ),
          CategoriesList(
            onSelectCatgory: (category) {
              _selectedCategoryNotifier.value = category;
            },
          ),
          ValueListenableBuilder(
            valueListenable: _selectedCategoryNotifier,
            builder: (context, value, child) {
              return SliverAnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: SliverToBoxAdapter(
                  key: ValueKey(value),
                  child: value == null
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(
                              ViewConsts.pagePadding,
                              5,
                              ViewConsts.pagePadding - 10,
                              5),
                          child: Row(
                            children: [
                              Expanded(child: _title(value)),
                              IconButton(
                                icon: Icon(_useGrideProductsFormat
                                    ? FluentIcons.list_24_regular
                                    : FluentIcons.grid_24_regular),
                                onPressed: () {
                                  _useGrideProductsFormat =
                                      !_useGrideProductsFormat;
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  _selectedCategoryNotifier.notifyListeners();
                                },
                              ),
                            ],
                          ),
                        ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _selectedCategoryNotifier,
            builder: (context, value, child) {
              return Products(
                useGrideProductsFormat: _useGrideProductsFormat,
                parentCategory : value, 
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: _bottomFreeHeight),
          ),
        ],
      ),
    );
  }
}
