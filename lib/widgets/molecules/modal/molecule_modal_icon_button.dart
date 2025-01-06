import 'package:flutter/material.dart';

class MoleculeModalIconButton extends StatelessWidget {
  final Widget content;
  final IconData icon;
  final bool isDismissible;
  const MoleculeModalIconButton({super.key, required this.content, required this.icon, this.isDismissible = true});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      final Size screenSize = MediaQuery.of(context).size;

      showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: isDismissible,
        builder: (BuildContext context) {
          return SizedBox(
            height: screenSize.height * 0.5,
            width: screenSize.width,
            child: Center(
              child: content,
            ),
          );
        });
    }, icon: Icon(icon));
  }
}