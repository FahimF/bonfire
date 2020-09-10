import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/util/gestures/tap_gesture.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class InterfaceComponent extends GameComponent with TapGesture {
  final int id;
  final Sprite sprite;
  final Sprite spriteSelected;
  final VoidCallback onTapComponent;
  final double width;
  final double height;
  Sprite spriteToRender;

  @override
  bool isHud() => true;

  InterfaceComponent({
    @required this.id,
    @required Position position,
    @required this.width,
    @required this.height,
    this.sprite,
    this.spriteSelected,
    this.onTapComponent,
  }) {
    this.position = Rect.fromLTWH(position.x, position.y, width, height);
    spriteToRender = sprite;
  }

  void render(Canvas canvas) {
    if (spriteToRender != null &&
        this.position != null &&
        spriteToRender.loaded())
      spriteToRender.renderRect(canvas, this.position);
  }

  @override
  bool onTapDown(int pointer, Offset position) {
    if (spriteSelected != null) {
      spriteToRender = spriteSelected;
    }
    return super.onTapDown(pointer, position);
  }

  @override
  void onTapCancel() {
    spriteToRender = sprite;
    super.onTapCancel();
  }

  @override
  void onTap() {
    if (onTapComponent != null) onTapComponent();
    spriteToRender = sprite;
  }

  @override
  void update(double t) {}
}
