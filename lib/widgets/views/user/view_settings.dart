import 'package:flutter/material.dart';
import '../../../i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:toast/toast.dart';

class ViewSettings extends StatelessWidget {
  const ViewSettings({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        CenterTitleAtom(text: t.HEADER.SETTINGS, textStyle: neonTitleText),
        const SizedBox(height: 10),
        _Card(
          icon: Icons.person,
          title: t.PROFILE.YOU,
          routeName: "/settings/edit-profile",
        ),
        _Card(
          icon: Icons.gamepad_outlined,
          title: t.PROFILE.PLATFORMS,
          routeName: "/settings/platforms",
        ),
        _Card(
          routeName: "/settings/reports",
          icon: Icons.bug_report_outlined,
          title: t.REPORTS.FEEDBACK,
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;
  const _Card({
    required this.routeName,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(routeName),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: ListTile(
          leading: Icon(icon, size: 30),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Mashetic",
              color: Colors.white,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
