import 'package:bonfire/lighting/lighting_config.dart';
import 'package:bonfire/util/camera/camera.dart';
import 'package:flutter/material.dart';

mixin Lighting {
  LightingConfig lightingConfig;

  bool isVisible(Camera camera) {
    if (lightingConfig == null ||
        camera == null ||
        lightingConfig?.gameComponent?.position == null ||
        camera.gameRef.size == null) return false;

    Rect rectLight = Rect.fromLTWH(
      lightingConfig.gameComponent.position.left - lightingConfig.radius,
      lightingConfig.gameComponent.position.top - lightingConfig.radius,
      lightingConfig.radius * 2,
      lightingConfig.radius * 2,
    );

    return camera.cameraRect.overlaps(rectLight) ?? false;
  }
}
