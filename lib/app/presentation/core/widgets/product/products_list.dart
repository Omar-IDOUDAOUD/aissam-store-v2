import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/product/product.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/scroll_notification_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({super.key, required this.state, required this.loadData});
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;
  final VoidCallback Function(WidgetRef ref) loadData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: regularProductHeight,
      child: ScrollNotificationListener(
        listener: loadData(ref),
        scrollAxis: Axis.horizontal,
        child: ListView.separated(
          clipBehavior: Clip.none,
          padding:
              const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
          itemCount: buildPaginationListCount(state(ref)),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: ViewConsts.seperatorSize),
          itemBuilder: (_, i) => buildPaginationListItem(
            asyncValue: state(ref),
            index: i,
            onData: (data) {
              return ProductWidget(data: data);
            },
            onError: (err) => SizedBox(
              width: 200,
              child: ColoredBox(
                color: Colors.grey,
                child: Text(err.toString()),
              ),
            ),
            onLoading: (i) => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
