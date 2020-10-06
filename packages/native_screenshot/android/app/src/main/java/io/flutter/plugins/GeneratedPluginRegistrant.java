package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import jpg.ivan.native_screenshot.NativeScreenshotPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    NativeScreenshotPlugin.registerWith(registry.registrarFor("jpg.ivan.native_screenshot.NativeScreenshotPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
