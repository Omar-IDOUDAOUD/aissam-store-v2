import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/widgets/animated_scale_fade.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/nav_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/tab_controller.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/fab.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/snackbar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/views/view.dart';
import 'package:aissam_store_v2/config/routing/config.dart';
import 'package:aissam_store_v2/config/routing/routes.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:aissam_store_v2/utils/extentions/current_route.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'providers/back_action.dart';
import 'tabs/profile/views/view.dart';
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
    ref.read(tabControllerProvider).tabController ??= _tabController;

    // ref.listen(back, listener)
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

class HomeMainBody extends ConsumerStatefulWidget {
  const HomeMainBody({super.key});

  @override
  ConsumerState<HomeMainBody> createState() => _HomeMainBodyState();
}

class _HomeMainBodyState extends ConsumerState<HomeMainBody> {  
  TabController get _tabController =>
      ref.read(tabControllerProvider).tabController!;

  @override
  void initState() {
    super.initState();
    _rootRoute = rootNavigatorKey.currentContext!.currentRoute;
    BackButtonInterceptor.add(
      _backClickListener,
      context: context,
      ifNotYetIntercepted: true,
    );
  }

  late final Route _rootRoute;

  bool _backClickListener(_,RouteInfo routeInfo) {
    if (!_rootRoute.isCurrent || !routeInfo.routeWhenAdded!.isCurrent)
      return false;

    if (_tabController.index != 0) {
      _tabController.animateTo(0);
      return true;
    } else
      return false;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_backClickListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colors.b,
      child: TabBarView(
        controller: _tabController,
        children: [
          const HomeTab(),
          const WishlistTab(),
          const SearchTab(),
          const CartTab(),
          // HomeTab(),
          Center(
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    showGeneralDialog(
                      useRootNavigator: false,
                      context: context,
                      pageBuilder: (_, __, ___) {
                        return Center(
                          child: MaterialButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('back'),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Click me'),
                ),
                MaterialButton(
                  onPressed: () {
                    showGeneralDialog(
                      useRootNavigator: true,
                      context: rootNavigatorKey.currentContext!,
                      routeSettings: RouteSettings(name: 'sssss'),
                      pageBuilder: (_, __, ___) {
                        return Center(
                          child: MaterialButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('back'),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Click me'),
                ),
              ],
            ),
          )
        ],
      ),
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
