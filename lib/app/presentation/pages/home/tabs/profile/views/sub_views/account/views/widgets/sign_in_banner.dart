import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'sliver_aware.dart';

class SignInBanner extends StatelessWidget {
  const SignInBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAware(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ViewConsts.radius),
          color: Colors.orange.shade50,
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Sign-In for more features',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'You are currently using a guest account, sign in now to sync your data on cloud',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
