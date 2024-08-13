import 'package:aissam_store_v2/app/presentation/pages/home/page.dart';
import 'package:aissam_store_v2/core/exceptions.dart';
import 'package:aissam_store_v2/databases/local_db.dart';
import 'package:aissam_store_v2/databases/mongo_db.dart' show MongoDb;
import 'package:aissam_store_v2/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum _SplashLoadingStates {
  loading(message: 'Loading...'),
  errored(message: 'Unknown error!'),
  finished(message: 'Loading finished!');

  const _SplashLoadingStates({
    required this.message,
  });
  final String message;
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    
    final firebaseInit = sl.getAsync<FirebaseApp>();
    final monogdbInit = sl.getAsync<MongoDb>();
    final localdbInit = sl.getAsync<LocalDb>();

    try {
      await Future.wait([firebaseInit, monogdbInit, localdbInit]);
      _loadingState = _SplashLoadingStates.finished;
    } on NetworkException {
      _loadingState = _SplashLoadingStates.finished;
    } catch (e) {
      print(e);

      _loadingState = _SplashLoadingStates.errored;
    }

    setState(() {});
    if (_loadingState == _SplashLoadingStates.finished) proceed();
  }

  void proceed() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  _SplashLoadingStates _loadingState = _SplashLoadingStates.loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Screen'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            switch (_loadingState) {
              _SplashLoadingStates.loading => const SizedBox.square(
                  dimension: 30,
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3,
                    color: Colors.grey,
                  ),
                ),
              _SplashLoadingStates.errored => const Icon(
                  Icons.close_rounded,
                  color: Colors.redAccent,
                  size: 30,
                ),
              _ => const Icon(
                  Icons.check_rounded,
                  color: Colors.greenAccent,
                  size: 30,
                ),
            },
            const SizedBox(height: 20),
            Text(_loadingState.message),
            // IconButton(
            //     onPressed: init, icon: Icon(Icons.radio_button_checked)),
          ],
        ),
      ),
    );
  }
}
