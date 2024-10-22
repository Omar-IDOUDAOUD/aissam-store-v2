import 'package:aissam_store_v2/app/buisness/features/products/domain/entities/product_preview.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

const double regularProductWidth = 155;
const double regularProductHeight = 230;

class ProductWidget extends StatelessWidget {
  const ProductWidget(
      {super.key, this.expandWidth = false, required this.data});
  final bool expandWidth;
  final ProductPreview data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: regularProductHeight,
      width: expandWidth ? null : regularProductWidth,
      child:  DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.colors.b, 
           borderRadius: BorderRadius.circular(ViewConsts.radius),
          border: Border.all(
            width: ViewConsts.borderSideWidth,
            color: context.theme.colors.t,
          ),
        ),
        child: Column(
          children: [
            const Expanded(
              flex: 5,
              child: ImagePreview(),
            ),
            Expanded(
              flex: 6,
              child: _Info(data: data),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.data});
  final ProductPreview data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, maxLines: 2),
          const Spacer(),
          Text(
            'Available • ${data.sales} sales',
            style: context.textTheme.bodyMedium!
                .copyWith(color: context.theme.colors.s),
          ),
          Text(
            'no colors • Mliffa',
            style: context.textTheme.bodyMedium!
                .copyWith(color: context.theme.colors.s),
          ),
          const Spacer(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.price.toString(),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.theme.colors.d,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '- 20%',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.theme.colors.d),
              ),
            ],
          ),
        ],      
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // image: imageHere
        color: Colors.grey,
        borderRadius: BorderRadius.circular(ViewConsts.radius),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NewBadge(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ReviewsBadge(),
                _FavoriteButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ReviewsBadge extends StatelessWidget {
  const _ReviewsBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Row(
          children: [
            const Icon(
              FluentIcons.star_24_filled,
              color: Colors.orangeAccent,
              size: 12,
            ),
            const SizedBox(width: 2),
            Text(
              '2.5 • 21',
              style: context.textTheme.bodySmall!.copyWith(
                color: Colors.orangeAccent,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 17,
      backgroundColor: Colors.white,
      child: Icon(
        FluentIcons.heart_24_regular,
        color: Colors.orange,
        size: 18,
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(
          'New',
          style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
