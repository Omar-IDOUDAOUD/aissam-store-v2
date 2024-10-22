import 'package:aissam_store_v2/app/buisness/features/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/buisness/features/products/domain/usecases/search_usecases.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/formats.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/tertiary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/core/views/product/product.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'widgets/tile.dart';
import 'widgets/title.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: const [
        Title2(title: 'Popular'),
        _PopularSearchedProducts(),
        _Divider(),
        Title2(title: 'Trending keywords'),
        _TrendingKeywords(),
        _Divider(),
        Title2(title: 'History'),
        _History(),
        SizedBox(height: ViewConsts.pagePadding)
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: ViewConsts.pagePadding,
      endIndent: ViewConsts.pagePadding,
      height: 20,
      color: context.theme.colors.t,
    );
  }
}

class _PopularSearchedProducts extends ConsumerWidget {
  const _PopularSearchedProducts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(popularSearchedProductsProvider);
    return SizedBox(
      height: ViewConsts.buttonHeight,
      child: data.when(
        data: (data) {
          return ListView.separated(
            padding:
                const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) =>
                _PopularSearchedProductCard(data: data[index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: ViewConsts.seperatorSize,
            ),
          );
        },
        error: (error, stackTrace) => ErrorCard(
          showDescription: true,
          addPageMargine: true,
          onRety: () => ref.refresh(popularSearchedProductsProvider),
          error: error,
        ),
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class _PopularSearchedProductCard extends ConsumerWidget {
  const _PopularSearchedProductCard({required this.data});
  final PopularProductSearchType data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: regularProductWidth,
      child: TertiaryButton(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            SizedBox.square(
              dimension: ViewConsts.buttonHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ViewConsts.radius),
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: ViewConsts.seperatorSize),
            Expanded(
              child: Text(
                data.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: ViewConsts.seperatorSize),
          ],
        ),
      ),
    );
  }
}

class _History extends ConsumerStatefulWidget {
  const _History();

  @override
  ConsumerState<_History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<_History> {
  bool _showFullHistory = false;

  @override
  Widget build(BuildContext context) {
    return ref.watch(historyProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => ErrorCard(
            error: error,
            height: 50,
            addPageMargine: true,
            showDescription: true,
            onRety: () => ref.refresh(historyProvider),
          ),
          data: (data) {
            final moreThan5Items = data.length > 5;
            if (!_showFullHistory && moreThan5Items) data = data.sublist(1, 5);
            return SliverAnimatedPaintExtent(
              duration: const Duration(seconds: 2),
              child: SliverList.builder(
                itemCount:
                    data.length + (moreThan5Items && !_showFullHistory ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == data.length && moreThan5Items) return _button();
                  return Tile2(
                    label: data[index].keywords,
                    icon: FluentIcons.history_24_regular,
                    onPressed: () {
                      ref
                          .read(viewProvider.notifier)
                          .searchSubmit(useFilters: data[index]);
                    },
                  );
                },
              ),
            );
          },
        );
  }

  _button() {
    return _LoadMoreHistory(
      onClick: () {
        setState(() {
          _showFullHistory = true;
        });
      },
    );
  }
}

class _LoadMoreHistory extends StatelessWidget {
  const _LoadMoreHistory({required this.onClick});
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
      child: TertiaryButton(
        onPressed: onClick,
        child: const ButtonFormat1(
          label: 'Load more history',
          icon: FluentIcons.chevron_down_24_regular,
        ),
      ),
    );
  }
}

class _TrendingKeywords extends ConsumerWidget {
  const _TrendingKeywords();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(suggestionsProvider(''));
    return res.when(
      data: (data) => SliverList.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Tile2(
            icon: FluentIcons.arrow_trending_24_regular,
            label: data[index],
            onPressed: () {
              ref.read(viewProvider.notifier).searchSubmit(
                  useFilters:
                      SearchProductFilterParams.suggestion(data[index]));
            },
          );
        },
      ),
      error: (error, stackTrace) {
        return ErrorCard(
          showDescription: true,
          error: error,
          height: 60,
          addPageMargine: true,
          onRety: () => ref.refresh(suggestionsProvider('')),
        );
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
