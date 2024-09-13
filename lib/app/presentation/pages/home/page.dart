import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/animated_scale_fade.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/nav_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/tab_controller.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/fab.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/view.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tabs/search/views/view.dart';

// TODO: correct duration and curve for every animation
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.child});
  final Widget child;

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
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    ref.read(tabControllerProvider).tabController = _tabController;
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
      body: widget.child,
      bottomNavigationBar: HomeNavBar(tabController: _tabController),
      floatingActionButton: _Fab(),
    );
  }
}

class HomeMainBody extends ConsumerWidget {
  const HomeMainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabBarView(
      controller: ref.read(tabControllerProvider).tabController,
      children: const [
        HomeTab(),
        WishlistTab(),
        SearchTab(),
        CartTab(),
        HomeTab(),
      ],
    );
  }
}

class _Fab extends ConsumerStatefulWidget {
  _Fab({super.key});

  @override
  ConsumerState<_Fab> createState() => _FabState();
}

class _FabState extends ConsumerState<_Fab> {
  var _previousIcon;

  @override
  Widget build(BuildContext context) {
    final icon = _previousIcon;
    final fabEvent = ref.watch(fabProvider).fabEvent;
    _previousIcon = fabEvent?.icon;

    return AnimatedScaleFade(
      show: fabEvent != null,
      child: SizedBox.square(
        dimension: ViewConsts.buttonHeight,
        child: Material(
          type: MaterialType.circle,
          color: context.theme.colors.a,
          shadowColor: Colors.black87.withOpacity(.1),
          elevation: 10,
          child: InkWell(
            onTap: fabEvent?.onPressed,
            borderRadius: BorderRadius.circular(50),
            child: Icon(
              fabEvent?.icon ?? icon,
              color: context.theme.colors.d,
            ),
          ),
        ),
      ),
    );
  }
}
