// abstract class DisposablService{
//   FutureOr
// }

import 'dart:async';

abstract class ServiceInterface {
  FutureOr<void> init() {}
  FutureOr<void> close() {}
}
