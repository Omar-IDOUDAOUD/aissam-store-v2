import 'package:aissam_store_v2/app/buisness/core/langs_and_currencies.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/app/buisness/core/entities/currency.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/bottomsheet/view.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/sub_views/account/views/widgets/link_with_provider.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/sub_views/account/views/widgets/modify_email_bottomsheet.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/profile/views/sub_views/account/views/widgets/sign_in_banner.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/action.dart';
import 'widgets/currency_btn.dart';
import 'widgets/sliver_aware.dart';
import 'widgets/title.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});

  @override
  ConsumerState<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends ConsumerState<MyAccount> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberController;
  late Currency _currency;

  late final Failure? _errorOccurred;
  late final bool _anonymousUser;

  late final User _initialUser;

  String? _oldEmail;

  @override
  void initState() {
    GetUser().call().fold((f) {
      _errorOccurred = f;
    }, (user) {
      _errorOccurred = null;
      _initialUser = user;
      _firstNameController = TextEditingController(text: user.firstName);
      _lastNameController = TextEditingController(text: user.lastName);
      _currency = user.currency ??
          RegionsAndCurrenciesData.lookForCurrencyByLanguage(
              user.language.languageCode) ??
          RegionsAndCurrenciesData.currencies.first;
      if (user.authInfo != null) {
        print('Email is: ${user.authInfo!.email}');
        _emailController = TextEditingController(text: user.authInfo!.email);
        _phoneNumberController =
            TextEditingController(text: user.authInfo!.phoneNumber);
        _anonymousUser = false;
      } else {
        _anonymousUser = true;
      }
    });
    super.initState();
  }

  void _saveModifications() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.scaffoldBackgroundColor,
      child: _errorOccurred != null
          ? ErrorCard(
              error: _errorOccurred,
              addPageMargine: true,
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: IconButton(
                    onPressed: context.pop,
                    icon: const Icon(FluentIcons.chevron_left_24_regular),
                  ),
                  title: const Text('My account'),
                ),
                if (_anonymousUser) const SignInBanner(),
                const Title2(
                    title: 'First name', icon: FluentIcons.person_24_regular),
                SliverAware(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: 'Ali',
                    ),
                  ),
                ),
                const Title2(
                    title: 'Last name', icon: FluentIcons.person_24_regular),
                SliverAware(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: 'Mahfoud',
                    ),
                  ),
                ),
                if (!_anonymousUser) ...[
                  const Title2(
                      title: 'Email', icon: FluentIcons.mail_24_regular),
                  SliverAware(
                    child: TextField(
                      controller: _emailController,
                      readOnly: true,
                      onTap: _modifyEmail,
                      decoration: InputDecoration(
                        hintText: 'ali.mahfoud@example.com',
                        focusedBorder:
                            context.theme.inputDecorationTheme.border,
                      ),
                    ),
                  ),
                  if (_oldEmail != null)
                    SliverAware(
                      child: Text(
                        'Your old email is $_oldEmail, to keep it as the primary account email you have to verify it by click on both links sent to your new and old email!',
                        style: context.textTheme.bodySmall!
                            .copyWith(color: context.theme.colors.s),
                      ),
                    ),
                  const Title2(
                      title: 'Phone number',
                      icon: FluentIcons.phone_24_regular),
                  SliverAware(
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: '+21254847542',
                      ),
                    ),
                  ),
                ],
                const Title2(
                    title: 'Currency', icon: FluentIcons.money_24_regular),
                CurrencyButton(
                  initialSelectedCurrency: _currency,
                  onSelectCurrency: (newCurrency) {
                    _currency = newCurrency;
                  },
                ),
                const Title2(
                    title: 'Link yor acccount with',
                    icon: FluentIcons.link_24_regular),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 5),
                ),
                const LinkAccountWith(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 35),
                ),
                Action2(
                  onSave: _saveModifications,
                  onIgnore: context.pop,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: ViewConsts.pagePadding,
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _modifyEmail() async {
    final newEmail = await showBottomSheet2<String>(
      context: context,
      body: ModifyEmaillBottomSheetContent(
        oldEmail: _emailController!.text,
        context: context,
      ),
    );
    if (newEmail != null) {
      setState(() {
        _oldEmail = _emailController!.text;
      });
      _emailController!.text = newEmail;
    }
  }

  void _modifyPhoneNumber() {}
}
