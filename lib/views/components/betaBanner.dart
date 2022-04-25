import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class BetaBanner extends StatelessWidget {
  final Widget child;
  final bool showBetaBanner;
  const BetaBanner({Key? key, required this.child, this.showBetaBanner = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showBetaBanner
        ? Directionality(
            textDirection: TextDirection.ltr,
            child: Banner(
              child: child,
              location: BannerLocation.bottomStart,
              message: 'BETA',
              color: kSuccessGreen,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
            ),
          )
        : child;
  }
}
