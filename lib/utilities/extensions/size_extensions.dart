import 'package:flutter/cupertino.dart';

extension SizeExtension on BuildContext {
  /// ===============  [ Sized Box ]

  SizedBox sizeBoxHeight(double factor) {
    return SizedBox(height: MediaQuery.sizeOf(this).height * factor);
  }

  SizedBox sizeBoxWidth(double factor) {
    return SizedBox(width: MediaQuery.sizeOf(this).width * factor);
  }

  /// ===============  [ Container ]
  double containerHeight(double factor) {
    return MediaQuery.sizeOf(this).height * factor;
  }

  double containerWidth(double factor) {
    return MediaQuery.sizeOf(this).width * factor;
  }
}
