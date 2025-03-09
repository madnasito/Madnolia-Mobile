import 'package:flutter/material.dart';

class MoleculeModalIconButton extends StatelessWidget {
  final Widget content;
  final IconData icon;
  final bool isDismissible;
  const MoleculeModalIconButton({super.key, required this.content, required this.icon, this.isDismissible = true});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){

      showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),   
              child: Center(
                child: content,
              ),
            ),
          );
        });
    }, icon: Icon(icon));
  }
}