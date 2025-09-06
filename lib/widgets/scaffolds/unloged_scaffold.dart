import 'package:flutter/material.dart';
import 'package:madnolia/widgets/background.dart';

class UnlogedScaffold extends StatelessWidget {
  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const UnlogedScaffold({
    super.key, 
    required this.body,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBackButton ? _buildAppBar(context) : null,
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: body,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: 24,
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      // Para asegurar que el título no ocupe espacio
      title: SizedBox.shrink(),
      centerTitle: true,
    );
  }
}