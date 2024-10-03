import 'package:aissam_store_v2/app/buisness/features/user/domain/entities/user.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userChangesProvider = StreamProvider<User>(
  (ref) {
    final subscription = UserChanges().call();
    return subscription.map(
      (event) {
        return event.fold((failure) {
          throw failure;
        }, (user) {
          return user;
        });
      },
    );
  },
);
