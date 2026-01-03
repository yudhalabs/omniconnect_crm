import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.centerTitle = true,
    this.backgroundColor,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: isDesktop ? null : drawer,
      appBar: appBar ?? _buildAppBar(context),
      body: Row(
        children: [
          if (isDesktop && drawer != null) drawer!,
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (title == null && actions == null && !showBackButton) {
      return null;
    }

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;
  final Widget? mobileNavigation;
  final Widget? tabletNavigation;
  final Widget? desktopNavigation;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
    this.mobileNavigation,
    this.tabletNavigation,
    this.desktopNavigation,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = ResponsiveHelper.getScreenType(context);

    switch (screenType) {
      case ResponsiveHelper.ScreenType.mobile:
        return mobileNavigation != null
            ? Scaffold(
                body: mobileBody,
                bottomNavigationBar: mobileNavigation,
              )
            : mobileBody;

      case ResponsiveHelper.ScreenType.tablet:
        return Row(
          children: [
            tabletNavigation ?? const SizedBox.shrink(),
            Expanded(child: tabletBody),
          ],
        );

      case ResponsiveHelper.ScreenType.desktop:
      case ResponsiveHelper.ScreenType.largeDesktop:
        return Row(
          children: [
            desktopNavigation ?? const SizedBox.shrink(),
            Expanded(child: desktopBody),
          ],
        );
    }
  }
}

class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const AdaptiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: maxWidth != null
            ? BoxConstraints(maxWidth: maxWidth!)
            : const BoxConstraints(maxWidth: 1400),
        padding: ResponsiveHelper.getScreenPadding(context),
        child: child,
      ),
    );
  }
}
