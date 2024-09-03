import 'package:aissam_store_v2/app/buisness/products/domain/entities/category.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/sub_views/filter_dialog/discover_categories_page/widgets/card.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoriesPage extends ConsumerStatefulWidget {
  const SelectCategoriesPage({super.key, required this.selectedCategories});
  final List<Category> selectedCategories;

  @override
  ConsumerState<SelectCategoriesPage> createState() =>
      _DiscoverCategoriesSubScreenState();
}

class _DiscoverCategoriesSubScreenState
    extends ConsumerState<SelectCategoriesPage> {
  String get _title {
    return widget.selectedCategories.isEmpty
        ? 'Categories'
        : '${widget.selectedCategories.length} selected';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // controller: _scrollController,
        slivers: [
          SliverAppBar.large(
            expandedHeight: ViewConsts.appBarExpandHeight,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FluentIcons.chevron_left_24_regular),
            ),
            actions: [
              if (widget.selectedCategories.isNotEmpty)
                IconButton(
                  onPressed: () {
                    widget.selectedCategories.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    FluentIcons.dismiss_24_regular,
                  ),
                ),
              const SizedBox(width: 8),
            ],
            titleSpacing: 8,
            title: Text(
              _title,
              style: context.theme.appBarTheme.titleTextStyle,
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
                        _title,
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
                  ViewConsts.pagePadding, 25, ViewConsts.pagePadding, 15),
              child: Text(
                // _searchState ? 'Search Categories' : 'Main Categories',
                'Main Categories',
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
            sliver: buildStateAwareChild(
              addPageMargine: false,
              isSliver: true,
              asyncValue: ref.watch(categoriesProvider(null)),
              child: SliverGrid.builder(
                itemCount: calculatePaginationItemCount(
                  ref.watch(categoriesProvider(null)),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: ViewConsts.seperatorSize,
                  crossAxisSpacing: ViewConsts.seperatorSize,
                ),
                itemBuilder: (context, index) {
                  return buildPaginatedListItem(
                    asyncValue: ref.watch(categoriesProvider(null)),
                    index: index,
                    loadData:
                        ref.read(categoriesProvider(null).notifier).loadData,
                    onDataBuilder: (data) => CategoryCard(
                      data: data,
                      index: index,
                      selected: widget.selectedCategories.contains(data),
                      onSelect: (select) {
                        if (select)
                          widget.selectedCategories.add(data);
                        else
                          widget.selectedCategories.remove(data);
                        setState(() {});
                      },
                    ),
                    onErrorBuilder: (err) => ErrorCard(
                      error: err,
                      onRety:
                          ref.read(categoriesProvider(null).notifier).loadData,
                    ),
                    onLoadingBuilder: (index) =>
                        const CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: ViewConsts.pagePadding))
        ],
      ),
    );
  }
}
