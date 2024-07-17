import 'package:aissam_store_v2/app/buisness/products/domain/usecases/usecases.dart';
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
    final res = await GetProduct().call('66902f041077b56518b8b3e3');

    print('data: ----------------------------------------------');
    res.fold(
      print,
      (d) { 
        print(
          d
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: const Text('clock me'),
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
