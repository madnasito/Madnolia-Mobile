import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/style/text_style.dart';

import '../../widgets/organism/form/organism_create_report_form.dart';

class PageReports extends StatelessWidget {
  const PageReports({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CenterTitleAtom(text: t.REPORTS.FEEDBACK, textStyle: neonTitleText),
          const SizedBox(height: 30),
          const OrganismCreateReportForm(),
        ],
      ),
    );
  }
}
