import 'package:aissam_store_v2/app/buisness/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/products_usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: const Text('click me'),
              onPressed: () async {
                // final res = await AddToCart().call(
                //   AddAndModifyCartItemParams(
                //     quantity: 0,
                //     color: '',
                //     size: 'size',
                //     productId: "66a2c369126c44a07ed89e54",
                //   ),
                // );
                final res =
                    await GetCart().call(DataPaginationParams(pageSize: 100));

                print(res);
              },
            )
          ],
        ),
      ),
    );
  }
}
