import 'dart:ui';

import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire/game_interface/interface_component.dart';
import 'package:bonfire/util/priority_layer.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameInterface extends GameComponent with TapGesture {
  List<InterfaceComponent> _components = List();
  final textConfigGreen = TextConfig(color: Colors.green, fontSize: 14);
  final textConfigYellow = TextConfig(color: Colors.yellow, fontSize: 14);
  final textConfigRed = TextConfig(color: Colors.red, fontSize: 14);

  @override
  bool isHud() => true;

  @override
  int priority() => PriorityLayer.GAME_INTERFACE;

  @override
  void render(Canvas c) {
    _components.forEach((i) => i.render(c));
    _drawFPS(c);
  }

  @override
  void update(double t) {
    _components.forEach((i) {
      i.gameRef = gameRef;
      i.update(t);
    });
  }

  void add(InterfaceComponent component) {
    removeById(component.id);
    _components.add(component);
  }

  void removeById(int id) {
    if (_components.isEmpty) return;
    _components.removeWhere((i) => i.id == id);
  }

  @override
  bool handlerPointerDown(int pointer, Offset position) {
    var handled = false;
    _components.forEach((i) {
      if (i.handlerPointerDown(pointer, position)) {
        handled = true;
      }
    });
    if (super.handlerPointerDown(pointer, position)) {
      handled = true;
    }
    return handled;
  }

  @override
  bool handlerPointerUp(int pointer, Offset position) {
    var handled = false;
    _components.forEach((i) {
      if (i.handlerPointerUp(pointer, position)) {
        handled = true;
      }
    });
    if (super.handlerPointerUp(pointer, position)) {
      handled = true;
    }
    return handled;
  }

  void _drawFPS(Canvas c) {
    if (gameRef?.showFPS == true && gameRef?.size != null) {
      double fps = gameRef.fps(100);
      getTextConfigFps(fps).render(
        c,
        'FPS: ${fps.toStringAsFixed(2)}',
        Position(gameRef.size.width - 100, 20),
      );
    }
  }

  TextConfig getTextConfigFps(double fps) {
    if (fps >= 58) {
      return textConfigGreen;
    }

    if (fps >= 48) {
      return textConfigYellow;
    }

    return textConfigRed;
  }

  @override
  void onTap() {}
}
