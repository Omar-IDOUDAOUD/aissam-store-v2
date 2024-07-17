import 'package:aissam_store_v2/app/buisness/products/core/constants.dart';
import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/core/data_pagination.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    test();
  }

  int index = 0;
  Future<void> test() async {
    final res = await GetCategories().call(
      GetCategoriesParams(
        paginationParams: DataPaginationParams(
          indexIdentifierObj: index
        ),
      ),
    );
    print('data: ');
    res.fold(print, (d) => print(d.items.map((e) => e.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                test();
              },
            )
          ],
        ),
      ),
    );
  }
}
