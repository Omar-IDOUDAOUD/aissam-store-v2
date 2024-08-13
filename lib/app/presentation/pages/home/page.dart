import 'package:aissam_store_v2/app/buisness/cart/core/params.dart';
import 'package:aissam_store_v2/app/buisness/cart/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/nav_bar.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/cart/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/home/views/view.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/wishlist/wishlist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // SignUp().call(SignUpParams(
    //   email: 'email@email.email', password: 'password', username: 'username'
    // ));
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          const HomeTab(),
          WishlistTab(),
          const HomeTab(),
          CartTab(),
          const HomeTab(),
        ],
      ),
      bottomNavigationBar: HomeNavBar(tabController: _tabController),
    );
  }
}
