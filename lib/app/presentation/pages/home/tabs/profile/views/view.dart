import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/widgets/main_info.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/widgets/product_provider_btn.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/widgets/sections/shopping.dart';
import 'package:flutter/widgets.dart';

import 'widgets/appbar.dart';
import 'widgets/section_title.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    // Logout().call(); 
    
    return const CustomScrollView(
      slivers: [
        Appbar(),
        // MainInfoSection(),
        ChangeProductProviderButton(),
        SectionTitle(title: 'SHOPPING'),
        ShoppingSection(),
        SectionTitle(title: 'SHOPPING'),
        ShoppingSection(),
        SectionTitle(title: 'SHOPPING'),
        ShoppingSection(),
      ],
    );
  }
}
