import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.mobileLandscapeBuilder,
    super.key,
  });

  final Widget Function(BuildContext context, BoxConstraints constraints)
  mobileBuilder;

  final Widget Function(BuildContext context, BoxConstraints constraints)
  tabletBuilder;

  final Widget Function(BuildContext context, BoxConstraints constraints)
  mobileLandscapeBuilder;

  static bool isMobile(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portraitWidth = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width
        : mediaQuery.size.height;
    return portraitWidth < 650;
  }

  static bool isTablet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portraitWidth = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width
        : mediaQuery.size.height;
    return portraitWidth >= 650 && portraitWidth < 1250;
  }

  static bool isMobileLandscape(BuildContext context) {
    return isMobile(context) &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobileLandscape(context)) {
          return mobileLandscapeBuilder(context, constraints);
        } else if (isTablet(context)) {
          return tabletBuilder(context, constraints);
        } else {
          return mobileBuilder(context, constraints);
        }
      },
    );
  }
}

class ResponsiveUtils {
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isTablet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portraitWidth = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width
        : mediaQuery.size.height;
    return portraitWidth >= 600 && portraitWidth < 1000; 
  }

  static bool isMobile(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portraitWidth = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width
        : mediaQuery.size.height;
    return portraitWidth < 600;
  }
}
