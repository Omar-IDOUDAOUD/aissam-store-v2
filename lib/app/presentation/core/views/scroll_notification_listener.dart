import 'package:flutter/widgets.dart';

class ScrollNotificationListener extends StatelessWidget {
  const ScrollNotificationListener(
      {super.key,
      required this.child,
      required this.listener,
      this.scrollAxis = Axis.vertical});
  final Widget child;
  final VoidCallback listener;
  final Axis scrollAxis;

  AxisDirection get _getScrollAccess =>
      scrollAxis == Axis.horizontal ? AxisDirection.right : AxisDirection.down;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollEndNotification notification) {
        if (notification.metrics.atEdge &&
            notification.metrics.axisDirection == _getScrollAccess) {
          listener();
        }
        return false;
      },
      child: child,
    );
  }
}
