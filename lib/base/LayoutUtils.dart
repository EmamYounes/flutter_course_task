import 'package:flutter/material.dart';

class LayoutUtils {
  static bool english = false;

  static TextDirection getLayoutDirection() {
    return english ? TextDirection.ltr : TextDirection.rtl;
  }

  static Widget wrapWithtinLayoutDirection(Widget widget) {
    return new Directionality(
        textDirection: getLayoutDirection(), child: widget);
  }
}
