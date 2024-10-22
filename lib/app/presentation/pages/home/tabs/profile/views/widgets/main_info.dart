import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/config/routing/routes.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainInfoSection extends StatelessWidget {
  const MainInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>context.go(AppRoutes.homeProfileMyAccount.fullPath()),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ViewConsts.pagePadding
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 25,
                child: ClipOval(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 25,
                      width: 50,
                      child: ColoredBox(
                        color: Colors.black.withOpacity(.5),
                        child: const Center(
                          child: Icon(
                            FluentIcons.image_edit_16_regular,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Omar Idoudaoud',
                      style: context.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'omar.idoudaoud1@gmail.com',
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.theme.colors.s),
                    ),
                  ],
                ),
              ),
              Icon(
                FluentIcons.chevron_right_24_regular,
                size: 20,
                color: context.theme.colors.s,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
