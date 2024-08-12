




import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AnimatedScaleFade extends StatelessWidget {
  final bool show; 
  final Widget child; 
  
  const AnimatedScaleFade({super.key, required this.show, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
            scale: show ? 1 : 0,
            duration: ViewConsts.animationDuration,
            curve: ViewConsts.animationCurve,
            child: AnimatedOpacity(
              opacity: show ? 1 : 0,
              duration: ViewConsts.animationDuration,
              curve: ViewConsts.animationCurve,
              child: child
            ),
          ); 
  }
}