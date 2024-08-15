import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/nav_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: correct duration and curve for every animation
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _snackbarAnimationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _snackbarAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _snackbarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SnackBarEvent?>(snackBarProvider, (previous, next) {
      if (next != null) {
        final state = ref.read(snackBarProvider)!;
        state.controller = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            action: state.action != null
                ? SnackBarAction(
                    label: state.action!,
                    onPressed: state.onActionPress ?? () {},
                  )
                : null,
            duration: state.duration,
          ),
          snackBarAnimationStyle: AnimationStyle(
            curve: ViewConsts.animationCurve,
            duration: ViewConsts.animationDuration,
          ),
        );
      }
      if (previous != null) {
        previous.controller.close();
      }
    });

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTab(),
          WishlistTab(),
          HomeTab(),
          CartTab(),
          HomeTab(),
        ],
      ),
      bottomNavigationBar: HomeNavBar(tabController: _tabController),
    );
  }
}
