
import 'package:aissam_store_v2/app/buisness/features/products/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/product/products_list.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/categories_section.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/dialy_banner.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/header_greeting.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section_title.dart';
import 'package:aissam_store_v2/app/presentation/config/routing/routes.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {

  void _pushToCategoriesSubScreen() {
    context.go(AppRoutes.homeDiscoverCategories.fullPath());
  }

  void _pushToProductsSubScreen(DiscoverProductsSubScreenParams routeParams) {
      
    context.go(AppRoutes.homeDiscoverProducts.fullPath(), extra: routeParams);
  }

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SafeArea(
              child: SizedBox.square(dimension: 10),
            ),
            const HeaderGreating(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ViewConsts.pagePadding),
              child: TextField(
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
            const SizedBox(height: 8),
            const DialyBanner(),
            const SizedBox(height: 20),

            /// BY CATEGORIES <<<
            CategoriesSection(
              onChangeCategory: (category) {
                _selectedCategory = category;
              },
              onDiscoverAllCategoriesClick: _pushToCategoriesSubScreen,
              onDiscoverAllproductsClick: () {
                _pushToProductsSubScreen(
                  DiscoverProductsSubScreenParams(
                    title: _selectedCategory!,
                    description: 'Discover all $_selectedCategory products',
                    state: (ref) => ref.watch(
                        productsByCategoriesProvider(_selectedCategory!)),
                    loadData: (ref) => ref
                        .read(productsByCategoriesProvider(_selectedCategory!)
                            .notifier)
                        .loadData,
                  ),
                );
              },
            ),

            /// BY CATEGORIES >>>
            const SizedBox(height: 20),

            /// BEST SELLER <<<
            SectionTitle(
              title: 'Best seller',
              onDiscoverAllClick: () {
                _pushToProductsSubScreen(
                  DiscoverProductsSubScreenParams(
                    title: 'Best seller',
                    description: 'Discover all best selled products',
                    state: (ref) => ref.watch(
                      productsByPerformanceProvider(
                        ProductsPerformance.best_sellers,
                      ),
                    ),
                    loadData: (ref) => ref
                        .read(
                          productsByPerformanceProvider(
                            ProductsPerformance.best_sellers,
                          ).notifier,
                        )
                        .loadData,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ProductsList(
              state: (ref) => ref.watch(productsByPerformanceProvider(
                  ProductsPerformance.best_sellers)),
              loadData: (ref) => ref
                  .read(
                    productsByPerformanceProvider(
                            ProductsPerformance.best_sellers)
                        .notifier,
                  )
                  .loadData,
            ),

            /// BEST SELLER >>>
            const SizedBox(height: 20),

            /// TRENDING <<<
            SectionTitle(
              onDiscoverAllClick: () {
                _pushToProductsSubScreen(
                  DiscoverProductsSubScreenParams(
                    title: 'Trending',
                    description: 'Trending products',
                    state: (ref) => ref.watch(
                      productsByPerformanceProvider(
                        ProductsPerformance.trending,
                      ),
                    ),
                    loadData: (ref) => ref
                        .read(
                          productsByPerformanceProvider(
                            ProductsPerformance.trending,
                          ).notifier,
                        )
                        .loadData,
                  ),
                );
              },
              title: 'Trending',
            ),
            const SizedBox(height: 12),
            ProductsList(
              state: (ref) => ref.watch(
                productsByPerformanceProvider(ProductsPerformance.trending),
              ),
              loadData: (ref) => ref
                  .read(
                    productsByPerformanceProvider(ProductsPerformance.trending)
                        .notifier,
                  )
                  .loadData,
            ),

            /// TRENDING >>>
            const SizedBox(height: 20),

            /// TOP RATED <<<
            SectionTitle(
              onDiscoverAllClick: () {
                _pushToProductsSubScreen(
                  DiscoverProductsSubScreenParams(
                    title: 'Top rated',
                    description: 'Top rated products',
                    state: (ref) => ref.watch(
                      productsByPerformanceProvider(
                        ProductsPerformance.top_rated,
                      ),
                    ),
                    loadData: (ref) => ref
                        .read(
                          productsByPerformanceProvider(
                            ProductsPerformance.top_rated,
                          ).notifier,
                        )
                        .loadData,
                  ),
                );
              },
              title: 'Top Rated',
            ),
            const SizedBox(height: 12),
            ProductsList(
              state: (ref) => ref.watch(
                productsByPerformanceProvider(ProductsPerformance.top_rated),
              ),
              loadData: (ref) => ref
                  .read(
                    productsByPerformanceProvider(ProductsPerformance.top_rated)
                        .notifier,
                  )
                  .loadData,
            ),

            /// TOP RATED >>>
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
