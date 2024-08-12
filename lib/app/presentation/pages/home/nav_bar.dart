import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<HomeNavBar> createState() => HomeNavBarState();
}

class HomeNavBarState extends State<HomeNavBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.tabController.animation?.addListener(_listener);
  }

  @override
  void dispose() {
    widget.tabController.animation?.removeListener(_listener);
    super.dispose();
  }

  int _currentPage = 0;
  void _listener() {
    if (widget.tabController.indexIsChanging) {
      final index = widget.tabController.index;
      if (_currentPage != index) {
        setState(() {
          _currentPage = index;
        });
      }
      return;
    }
    final offset = widget.tabController.animation!.value.round();
    if (offset != _currentPage)
      setState(() {
        _currentPage = offset;
      });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvoked: (_) {
        widget.tabController.animateTo(0);
      },
      child: SizedBox(
        height: context.theme.appBarTheme.toolbarHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.colors.a,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, -1),
                blurRadius: 20,
                color: Colors.black12,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TabBar(
              controller: widget.tabController,
              indicatorPadding: EdgeInsets.only(
                  bottom: context.theme.appBarTheme.toolbarHeight! - 2),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.theme.colors.d,
              ),
              indicatorWeight: 5,
              unselectedLabelStyle: context.textTheme.bodyMedium,
              labelStyle: context.textTheme.bodyMedium!.copyWith(
                color: context.theme.colors.d,
                fontWeight: FontWeight.w700,
              ),
              labelColor: context.theme.colors.d,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              labelPadding: EdgeInsets.zero,
              overlayColor: const WidgetStatePropertyAll(Colors.black12),
              splashBorderRadius: BorderRadius.circular(50),
              tabs: [
                _Tab(
                  label: 'Home',
                  isActive: _currentPage == 0,
                  icon: FluentIcons.home_24_filled,
                  unselectedIcon: FluentIcons.home_24_regular,
                ),
                _Tab(
                  label: 'Wishlist',
                  isActive: _currentPage == 1,
                  icon: FluentIcons.heart_24_filled,
                  unselectedIcon: FluentIcons.heart_24_regular,
                ),
                 _Tab(
                  label: 'Search',
                  isActive: _currentPage == 2,
                  icon: FluentIcons.search_24_filled,
                  unselectedIcon: FluentIcons.search_24_regular,
                ),
                _Tab(
                  label: 'Cart',
                  isActive: _currentPage == 3,
                  icon: FluentIcons.cart_24_filled,
                  unselectedIcon: FluentIcons.cart_24_regular,
                ),
                _Tab(
                  label: 'Profile',
                  isActive: _currentPage ==4,
                  icon: FluentIcons.person_24_filled,
                  unselectedIcon: FluentIcons.person_24_regular,
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatefulWidget {
  const _Tab({
    super.key,
    required this.isActive,
    required this.icon,
    required this.unselectedIcon,
    required this.label,
  });
  final bool isActive;
  final IconData icon;
  final IconData unselectedIcon;
  final String label;

  @override
  State<_Tab> createState() => __TabState();
}

class __TabState extends State<_Tab> {
  IconData get _icon => widget.isActive ? widget.icon : widget.unselectedIcon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: Tab(
        text: widget.label,
        icon: AnimatedSwitcher(
          duration: ViewConsts.animationDuration,
          child: Icon(
            _icon,
            key: ValueKey(widget.isActive),
          ),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    );
  }
}
