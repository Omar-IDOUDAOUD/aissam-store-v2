
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/providers.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_grid.dart';

import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_list.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

class DiscoverCategoriesSubScreen extends ConsumerStatefulWidget {
  const DiscoverCategoriesSubScreen({super.key});

  @override
  ConsumerState<DiscoverCategoriesSubScreen> createState() =>
      _DiscoverCategoriesSubScreenState();
}

class _DiscoverCategoriesSubScreenState
    extends ConsumerState<DiscoverCategoriesSubScreen> {
  late final ValueNotifier<String?> _selectedCategoryNotifier;

  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final FocusNode _searchFocusNode;

  bool _searchState = false;

  bool _useGrideProductsFormat = false;

  late final _bottomFreeHeight =
      MediaQuery.sizeOf(context).height - ViewConsts.appBarExpandHeight - 100;

  Future<void> _searchBegin() async {
    setState(() {
      _searchState = true;
    });
    await _scrollController.animateTo(
      ViewConsts.appBarExpandHeight,
      duration: ViewConsts.animationDuration,
      curve: ViewConsts.animationCurve,
    );
    _searchFocusNode.requestFocus();
  }

  void _searchEnd() async {
    await _scrollController.animateTo(
      0,
      duration: ViewConsts.animationDuration,
      curve: ViewConsts.animationCurve,
    );
    setState(() {
      _searchState = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedCategoryNotifier = ValueNotifier(null);
    _searchController = TextEditingController();
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
    _selectedCategoryNotifier.dispose();
    _searchController.dispose();
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
      color: context.theme.colors.b,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar.large(
            pinned: !_searchState,
            expandedHeight: ViewConsts.appBarExpandHeight,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(FluentIcons.chevron_left_24_regular),
            ),
            titleSpacing: 8,
            title: Row(
              children: [
                const Spacer(),
                Text(
                  'Categories',
                  style: context.theme.appBarTheme.titleTextStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: _searchBegin,
                  icon: const Icon(FluentIcons.search_24_regular),
                ),
              ],
            ),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  ViewConsts.pagePadding, 15, ViewConsts.pagePadding, 0),
              child: TextField(
                focusNode: _searchFocusNode,
                style: context.textTheme.bodyLarge,
                onTap: _searchBegin,
                // canRequestFocus: false,
                onSubmitted: (_) => _searchEnd(),
                decoration: InputDecoration(
                  hintText: 'Search for clothes',
                  prefixIcon: const Icon(FluentIcons.search_24_regular),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.mic_24_filled),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ViewConsts.pagePadding, vertical: 15),
                child: _title(
                    _searchState ? 'Search Categories' : 'Main Categories')),
          ),
          _CategoriesLists(
            onSelectCatgory: (category) {
              _selectedCategoryNotifier.value = category;
            },
          ),
          ValueListenableBuilder(
            valueListenable: _selectedCategoryNotifier,
            builder: (context, value, child) {
              return SliverToBoxAdapter(
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
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _selectedCategoryNotifier,
            builder: (context, value, child) {
              if (value == null)
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              return _useGrideProductsFormat
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ViewConsts.pagePadding),
                      sliver: ProductsGride(
                        state: (ref) =>
                            ref.watch(productsByCategoriesProvider(value)),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: ProductsList(
                        state: (ref) =>
                            ref.watch(productsByCategoriesProvider(value)),
                        loadData: (ref) => ref
                            .read(productsByCategoriesProvider(value).notifier)
                            .loadData,
                      ),
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

class _CategoriesLists extends StatefulWidget {
  const _CategoriesLists({super.key, required this.onSelectCatgory});

  final Function(String? category) onSelectCatgory;
  @override
  State<_CategoriesLists> createState() => _CategoriesListsState();
}

class _CategoriesListsState extends State<_CategoriesLists> {
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
            child: _CategoriesSingleList(
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
                          axisAlignment: 1,
                          sizeFactor: an,
                          child: _CategoriesSingleList(
                            categorySelection: removedCategory,
                            onSelectSubCategory: (_, __) {},
                          ),
                        ),
                      );
                    },
                    duration: ViewConsts.animationDuration,
                  );
                  // await Future.delayed(Duration(seconds: 1));
                  _selections.removeAt(i);
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
                    duration: ViewConsts.animationDuration,
                  );
                } else {
                  _selections[index].unsetSubCategory();
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

class _CategoriesSingleList extends ConsumerWidget {
  _CategoriesSingleList({
    super.key,
    required this.categorySelection,
    required this.onSelectSubCategory,
  });
  final CategorySelection categorySelection;
  final Function(bool select, CategorySelection? subCategory)
      onSelectSubCategory;

  late final _provider = categoriesProvider(categorySelection.parentCategory);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_provider);
    final isEmpty = state.valueOrNull?.isEmpty == true;
    return AnimatedSize(
      duration: ViewConsts.animationDuration,
      alignment: Alignment.topCenter,
      curve: ViewConsts.animationCurve,
      child: SizedBox(
        height: categorySelection.hasSubCategory
            ? 130
            : isEmpty
                ? 40
                : 100,
        child: ScrollNotificationListener(
          listener: ref.read(_provider.notifier).loadData,
          scrollAxis: Axis.horizontal,
          child: isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ViewConsts.pagePadding),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ViewConsts.radius),
                          color: Colors.yellow.shade600),
                      child: Center(child: Text('No more sub categories'))),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ViewConsts.pagePadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: buildPaginationListCount(state),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ViewConsts.seperatorSize),
                  itemBuilder: (_, index) {
                    return buildPaginationListItem(
                      asyncValue: state,
                      index: index,
                      onData: (data) {
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
                                    color: Color.fromARGB(255, 255, 30, 0),
                                  ),
                                  child: Center(
                                    child: Text(data.name),
                                  ),
                                ),
                              ),
                            ),
                            if (categorySelection.subCategoryIndex == index)
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  FluentIcons.chevron_down_24_regular,
                                  size: 20,
                                ),
                              ),
                          ],
                        );
                      },
                      onError: (err) => Text(err.toString()),
                      onLoading: (_) => SizedBox.square(
                          dimension: 40, child: CircularProgressIndicator()),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
