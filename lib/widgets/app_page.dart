import 'package:flutter/material.dart';
import 'package:madnolia/widgets/base_layout.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final bool showDrawer;
  final bool showAppBar;
  final bool showBackground;
  final bool showSafeArea;
  final String? title;
  final List<Widget>? appBarActions;

  const AppPage({
    super.key,
    required this.child,
    this.showDrawer = true,
    this.showAppBar = true,
    this.showBackground = true,
    this.showSafeArea = true,
    this.title,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showDrawer: showDrawer,
      showAppBar: showAppBar,
      showBackground: showBackground,
      showSafeArea: showSafeArea,
      title: title,
      actions: appBarActions,
      child: child,
    );
  }
}

// Variaciones específicas para casos comunes
class AppPageWithDrawer extends AppPage {
  const AppPageWithDrawer({
    super.key,
    required super.child,
    super.title,
    super.appBarActions,
  }) : super(
    showDrawer: true,
    showAppBar: true,
    showBackground: true,
    showSafeArea: true,
  );
}

class AppPageWithoutDrawer extends AppPage {
  const AppPageWithoutDrawer({
    super.key,
    required super.child,
    super.title,
    super.appBarActions,
  }) : super(
    showDrawer: false,
    showAppBar: true,
    showBackground: true,
    showSafeArea: true,
  );
}

class AppPageFullScreen extends AppPage {
  const AppPageFullScreen({
    super.key,
    required super.child,
  }) : super(
    showDrawer: false,
    showAppBar: false,
    showBackground: true,
    showSafeArea: false,
  );
}

class AppPageMinimal extends AppPage {
  const AppPageMinimal({
    super.key,
    required super.child,
  }) : super(
    showDrawer: false,
    showAppBar: false,
    showBackground: false,
    showSafeArea: true,
  );
}
