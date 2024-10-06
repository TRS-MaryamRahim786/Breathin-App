import 'package:flutter/cupertino.dart';

/// ====================== [SizedBox Extension]
extension SizedExtension on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}
