import 'package:flutter/material.dart';

class ScreenSizes {
  final BuildContext context;
  ScreenSizes(this.context);
  bool isSemi() => MediaQuery.of(context).size.width <= 300;
  bool isSmall() =>
      MediaQuery.of(context).size.width >= 300 &&
      MediaQuery.of(context).size.width < 480;
  bool isMedium() =>
      MediaQuery.of(context).size.width >= 480 &&
      MediaQuery.of(context).size.width < 720;
  bool isLarg() =>
      MediaQuery.of(context).size.width >= 720 &&
      MediaQuery.of(context).size.width < 1024;
  bool isExtraLarg() => MediaQuery.of(context).size.width >= 1024;
}
