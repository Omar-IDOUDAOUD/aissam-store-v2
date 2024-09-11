import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_grid.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'route_params.dart';

class DiscoverProductsSubScreen extends StatelessWidget {
  const DiscoverProductsSubScreen({super.key, required this.routeParams});
  final DiscoverProductsSubScreenParams routeParams;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ColoredBox(
      color: context.theme.colors.b,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: ViewConsts.appBarExpandHeight,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(FluentIcons.chevron_left_24_regular),
            ),
            titleSpacing: 8,
            title: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(FluentIcons.search_24_regular),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  routeParams.description,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.theme.colors.s,
                  ),
                ),
              ),
              title: Text(
                routeParams.title,
                style: context.theme.appBarTheme.titleTextStyle,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ViewConsts.pagePadding, vertical: 15),
              child: TextField(
                canRequestFocus: false,
                style: context.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Search for clothes',
                  prefixIcon: const Icon(FluentIcons.search_24_regular),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(FluentIcons.mic_24_filled)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(ViewConsts.pagePadding, 0,
                ViewConsts.pagePadding, ViewConsts.pagePadding),
            sliver: ProductsGride(
              state: routeParams.state,
              loadData: (ref) => routeParams.loadData(ref),
            ),
          ),
        ],
      ),
    );
  }
}
