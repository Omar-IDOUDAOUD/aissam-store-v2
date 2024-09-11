import 'dart:ui';

import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/products_list.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_categories/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/route_params.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/sub_screens/discover_products/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/categories_section.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/dialy_banner.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/header_greeting.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/widgets/section_title.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
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
  /// TODO: use Navigator widget to handle sub-screens, see [Navigator];

  Widget Function()? _pushToScreen;
  bool _showPushScreen = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return _HomeScreen(
      pushSubScreenRequest: (screen) {
        context.go('/discover_all_products', extra: screen);
      },
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({super.key, required this.pushSubScreenRequest});
  final Function(dynamic params) pushSubScreenRequest;

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
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
              onDiscoverAllCategoriesClick: () => widget.pushSubScreenRequest(
                () => const DiscoverCategoriesSubScreen(),
              ),
              onDiscoverAllproductsClick: () => widget.pushSubScreenRequest(
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
                
              ),
            ),

            /// BY CATEGORIES >>>
            const SizedBox(height: 20),

            /// BEST SELLER <<<
            SectionTitle(
              title: 'Best seller',
              onDiscoverAllClick: () => widget.pushSubScreenRequest(
        
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
            
              ),
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
              onDiscoverAllClick: () => widget.pushSubScreenRequest(
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
               
              ),
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
              onDiscoverAllClick: () => widget.pushSubScreenRequest(
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
              ),
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
