import 'package:flutter/material.dart';

class UnlogedScaffold extends StatelessWidget {
  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool scrollable;
  final EdgeInsetsGeometry padding;

  const UnlogedScaffold({
    super.key,
    required this.body,
    this.showBackButton = false,
    this.onBackPressed,
    this.scrollable = true,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: body);

    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 0, 25),
      appBar: showBackButton ? _buildAppBar(context) : null,
      body: SafeArea(child: content),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: 24,
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      // Para asegurar que el título no ocupe espacio
      title: const SizedBox.shrink(),
      centerTitle: true,
    );
  }
}
