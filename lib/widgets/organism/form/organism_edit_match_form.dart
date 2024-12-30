import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/atoms/text_atoms/styled_text_atom.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../models/match/full_match.model.dart';
import '../../../style/text_style.dart';
import '../../molecules/buttons/molecule_form_button.dart';

final formKey = GlobalKey<FormBuilderState>();
class OrganismEditMatchForm extends StatelessWidget {
  final FullMatch match;
  const OrganismEditMatchForm({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();

    dateController.text = DateTime.fromMillisecondsSinceEpoch(match.date).toLocal().toString();
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const StyledTextAtom(text: "Edit match", style: presentationTitle),
            const SizedBox(height: 30),
            MoleculeTextField(
              formKey: formKey,
              icon: Icons.abc_rounded,
              name: "title",
              initialValue: match.title,
              label: translate("CREATE_MATCH.MATCH_NAME"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            SimpleCustomInput(
                  iconData: CupertinoIcons.calendar_today,
                  keyboardType: TextInputType.none,
                  placeholder: translate("CREATE_MATCH.DATE"),
                  controller: dateController,
                  onTap: () async {
                    DateTime? dateTime = await showOmniDateTimePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      is24HourMode: false,
                      theme: ThemeData.dark(useMaterial3: true),
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      isForce2Digits: true,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                        maxHeight: 650,
                      ),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return FadeTransition(
                          opacity: anim1.drive(
                            Tween(
                              begin: 0,
                              end: 1,
                            ),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      selectableDayPredicate: (dateTime) {
                        // Disable 25th Feb 2023
                        if (dateTime == DateTime(2023, 2, 25)) {
                          return false;
                        } else {
                          return true;
                        }
                      },
                    );
        
                    dateController.text = dateTime != null
                        ? dateTime.toString().substring(0, 16)
                        : "";
                  },
            ),
            const SizedBox(height: 10),
            MoleculeFormButton(color: Colors.transparent, text: "Update", onPressed:() async {
                final values = formKey.currentState?.instantValue.values.toList();
                final body =  {
                  "title": values?[0].toString(),
                  "date": DateTime.parse(dateController.text).millisecondsSinceEpoch.toString()
                };
                final resp = await MatchService().editMatch(match.id, body);

                print(resp);
            },)
          ],
        ),
      
    );
  }
}