import 'package:flutter/gestures.dart';

mixin PointerDetector {
  /// Handle pointer down event - returns true if there was a component at the gesture position which handles gestures, false otherwise. Override from super classes but always remember to call super implementation.
  bool onPointerDown(PointerDownEvent event) {
    return false;
  }

  /// Handle pointer move event - returns true if there was a component at the gesture position which handles gestures, false otherwise. Override from super classes but always remember to call super implementation.
  bool onPointerMove(PointerMoveEvent event) {
    return false;
  }

  /// Handle pointer up event - returns true if there was a component at the gesture position which handles gestures, false otherwise. Override from super classes but always remember to call super implementation.
  bool onPointerUp(PointerUpEvent event) {
    return false;
  }

  /// Handle pointer cancel event - returns true if there was a component at the gesture position which handles gestures, false otherwise. Override from super classes but always remember to call super implementation.
  bool onPointerCancel(PointerCancelEvent event) {
    return false;
  }
}
