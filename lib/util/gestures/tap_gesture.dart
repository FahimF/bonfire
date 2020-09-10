import 'dart:ui';

import 'package:bonfire/base/game_component.dart';

mixin TapGesture {
  bool enableTap = true;
  int _pointer;

  void onTap();

  /// Handle tap down events - return true if handled or false if not handled.
  bool onTapDown(int pointer, Offset position) {
    if (!(this is GameComponent) || !enableTap) {
      return false;
    }
    if (_gameComponent.isHud()) {
      if (_gameComponent.position.contains(position)) {
        _pointer = pointer;
        return true;
      }
    } else {
      final absolutePosition =
          _gameComponent.gameRef.gameCamera.cameraPositionToWorld(position);
      if (_gameComponent.position.contains(absolutePosition)) {
        _pointer = pointer;
        return true;
      }
    }
    return false;
  }

  /// Handle tap up events - return true if handled or false if not handled.
  bool onTapUp(int pointer, Offset position) {
    if (!enableTap || pointer != _pointer) {
      return false;
    }
    var handled = false;
    if (_gameComponent.isHud()) {
      if (_gameComponent.position.contains(position)) {
        onTap();
        handled = true;
      } else {
        onTapCancel();
      }
    } else {
      final absolutePosition =
          _gameComponent.gameRef.gameCamera.cameraPositionToWorld(position);
      if (_gameComponent.position.contains(absolutePosition)) {
        onTap();
        handled = true;
      } else {
        onTapCancel();
      }
    }
    _pointer = null;
    return handled;
  }

  void onTapCancel() {}

  GameComponent get _gameComponent => (this as GameComponent);
}
