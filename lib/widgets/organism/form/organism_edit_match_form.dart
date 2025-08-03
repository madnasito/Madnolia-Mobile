import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/match/edit_match_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:madnolia/widgets/molecules/modal/molecule_modal_icon_button.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toast/toast.dart';

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
    bool isLoading = false;
    dateController.text = DateTime.fromMillisecondsSinceEpoch(match.date).toLocal().toString().substring(0, 16);
    ToastContext().init(context);
    return MoleculeModalIconButton(
      content: FormBuilder(
          key: formKey,
          initialValue: {
            "title": match.title,
            "description": match.description,
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                const AtomStyledText(text: "Edit match", style: presentationTitle),
                const SizedBox(height: 30),
                MoleculeTextField(
                  icon: Icons.abc_rounded,
                  name: "title",
                  initialValue: match.title,
                  label: translate("CREATE_MATCH.MATCH_NAME"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                    FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'}))
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
                MoleculeTextField(
                  icon: Icons.description_outlined,
                  name: "description",
                  initialValue: match.description,
                  label: translate("CREATE_MATCH.DESCRIPTION"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.maxLength(80, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '80'}), checkNullOrEmpty: false),
                  ]),
                ),
                const SizedBox(height: 10),
                MoleculeFormButton(
                  isLoading: isLoading,
                  color: Colors.transparent,
                  text: "Update",
                  onPressed:() async {
                    try {
                      
                      isLoading = true;

                      if (formKey.currentState?.saveAndValidate() == false) {
                        isLoading = false;
                        return;
                      }
                      
                      final String name = formKey.currentState?.fields['title']?.value ?? '';
                      final String description = formKey.currentState?.fields['description']?.value ?? '';
                      final EditMatchModel body = EditMatchModel(
                        title: name,
                        description: description,
                        date: DateTime.parse(dateController.text).millisecondsSinceEpoch
                        );
                      final Map resp = await MatchService().editMatch(match.id, body.toJson());
                      isLoading = false;

                      if(!context.mounted) return;

                      if(!resp.containsKey("_id")) return showErrorServerAlert(context, resp);

                      match.date = resp["date"];
                      match.title = name;
                      match.description = description;

                      debugPrint(resp.toString());

                      context.pop();
                      Toast.show(translate("MATCH.MATCH_UPDATED"), border: Border.all(color: Colors.greenAccent), duration: 4,gravity: 5 );
                    } catch (e) {
                      isLoading = false;
                    }
                },),
                const SizedBox(height: 10),
              ],
            ),
          ),
        
      ), icon: Icons.edit_outlined,
    );
  }
}