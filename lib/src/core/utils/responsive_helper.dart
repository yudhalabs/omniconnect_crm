import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Responsive design helper for OmniConnect CRM
/// Provides utilities for adapting UI across different screen sizes
class ResponsiveHelper {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Screen size helpers
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  // Screen type enum
  enum ScreenType { mobile, tablet, desktop, largeDesktop }

  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) return ScreenType.mobile;
    if (width < tabletBreakpoint) return ScreenType.tablet;
    if (width < desktopBreakpoint) return ScreenType.desktop;
    return ScreenType.largeDesktop;
  }

  // Adaptive builder
  static Widget builder({
    required BuildContext context,
    required Widget mobile,
    required Widget tablet,
    required Widget desktop,
  }) {
    final screenType = getScreenType(context);
    switch (screenType) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet;
      case ScreenType.desktop:
      case ScreenType.largeDesktop:
        return desktop;
    }
  }

  // Width calculations
  static double getContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isDesktop(context)) {
      return width * 0.9;
    }
    return width;
  }

  static double getSidebarWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 280;
    }
    return 0;
  }

  // Padding calculations
  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  // Grid columns
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  // Spacing
  static double getSpacing(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 20;
    return 24;
  }

  // Text scale factor
  static double getTextScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) return 0.9;
    if (width < tabletBreakpoint) return 1.0;
    return 1.1;
  }

  // Orientation aware builder
  static Widget orientationBuilder(
      BuildContext context, Widget portrait, Widget landscape) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? portrait : landscape;
      },
    );
  }

  // Layout builder with constraints
  static Widget constrainedBuilder(
    BuildContext context,
    Widget Function(BoxConstraints constraints) builder,
  ) {
    return LayoutBuilder(builder: builder);
  }

  // Aspect ratio helpers
  static double getAspectRatio(BuildContext context, double ratio) {
    final width = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return ratio;
    }
    return ratio * 1.2;
  }
}

/// Extension for ScreenType
extension ScreenTypeExtension on ResponsiveHelper.ScreenType {
  bool get isMobile => this == ResponsiveHelper.ScreenType.mobile;
  bool get isTablet =>
      this == ResponsiveHelper.ScreenType.tablet;
  bool get isDesktop =>
      this == ResponsiveHelper.ScreenType.desktop || this == ResponsiveHelper.ScreenType.largeDesktop;
}

/// Device info helpers
class DeviceInfo {
  static bool isWeb() {
    return kIsWeb;
  }

  static bool isAndroid() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  static bool isIOS() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool isMacOS() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;
  }

  static bool isWindows() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;
  }

  static bool isLinux() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;
  }

  static TargetPlatform get currentPlatform {
    return defaultTargetPlatform;
  }

  static String get platformName {
    if (isWeb()) return 'web';
    if (isAndroid()) return 'android';
    if (isIOS()) return 'ios';
    if (isMacOS()) return 'macos';
    if (isWindows()) return 'windows';
    if (isLinux()) return 'linux';
    return 'unknown';
  }
}
