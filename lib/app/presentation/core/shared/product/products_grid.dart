import 'package:aissam_store_v2/app/buisness/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/pagination_loader.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/product/product.dart';
import 'package:aissam_store_v2/app/presentation/core/shared/scroll_notification_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsGride extends ConsumerWidget {
  const ProductsGride({super.key, required this.state});
  final AsyncValue<List<ProductPreview>> Function(WidgetRef ref) state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ViewConsts.seperatorSize,
        crossAxisSpacing: ViewConsts.seperatorSize,
        mainAxisExtent: regularProductHeight,
      ),
      itemCount: buildPaginationListCount(state(ref)),
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
    );
  }
}
