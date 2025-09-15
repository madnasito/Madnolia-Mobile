import 'package:dio/dio.dart' show DioException;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/enums/report-type.enum.dart';
import 'package:madnolia/models/reports/upload-report.model.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/database/providers/user_db.dart';
import 'package:madnolia/services/reports_service.dart';
import 'package:madnolia/style/form_style.dart';
import 'package:madnolia/database/services/user-db.service.dart';
import 'package:madnolia/widgets/alert_widget.dart' show showErrorServerAlert, showSuccesfulAlert;
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_connection_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:flutter_translate/flutter_translate.dart';

class UserProfilePage extends StatefulWidget {
  final String id;
  
  const UserProfilePage({super.key, required this.id});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: FutureBuilder(
        future: getUserDb(widget.id),
        builder: (BuildContext context, AsyncSnapshot<UserDb> snapshot) {
          if (snapshot.hasData) {
            final SimpleUser user = simpleUserFromJson(snapshot.data!.toJson());
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MoleculeProfileHeader(user: user),
                  MoleculeConnectionButton(simpleUser: user),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                backgroundColor: Colors.black38,
                                insetPadding: const EdgeInsets.all(20),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 500,
                                    maxHeight: 600,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.flag, size: 24),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${translate("REPORTS.REPORT_TO")} ${user.name}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FormBuilderDropdown<ReportType>(
                                                  validator: FormBuilderValidators.compose([
                                                    FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                                                  ]),
                                                  hint: Text(
                                                    translate('REPORTS.SELECT_TYPE'),
                                                    style: const TextStyle(decoration: TextDecoration.none),
                                                  ),
                                                  dropdownColor: Colors.black54,
                                                  alignment: Alignment.center,
                                                  borderRadius: BorderRadius.circular(20),
                                                  focusColor: Colors.yellow,
                                                  elevation: 20,
                                                  isDense: true,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                  decoration: InputDecoration(
                                                    errorBorder: errorBorder,
                                                    border: focusedBorder,
                                                    prefixIcon: const Icon(Icons.report_gmailerrorred_rounded),
                                                  ),
                                                  name: 'type',
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: ReportType.spam,
                                                      child: Text(translate('REPORTS.SPAM'), style: TextStyle(decoration: TextDecoration.none)),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: ReportType.childAbuse,
                                                      child: Text(translate('REPORTS.CHILD_ABUSE'), style: TextStyle(decoration: TextDecoration.none)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                MoleculeTextField(
                                                  name: 'description',
                                                  label: translate('UTILS.DESCRIPTION'),
                                                  icon: Icons.description_outlined,
                                                  validator: FormBuilderValidators.compose([
                                                    FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED')),
                                                    FormBuilderValidators.maxLength(100, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '100'}))
                                                  ]),
                                                ),
                                                const SizedBox(height: 20),
                                                FormBuilderFilePicker(
                                                  allowMultiple: false,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(Icons.image_outlined),
                                                    labelText: translate('UTILS.FILE'),
                                                    disabledBorder: InputBorder.none,
                                                    errorBorder: errorBorder,
                                                    border: defaultBorder,
                                                    focusedErrorBorder: warningBorder,
                                                    focusedBorder: focusedBorder,
                                                  ),
                                                  name: 'media',
                                                  validator: FormBuilderValidators.compose(
                                                    [
                                                      FormBuilderValidators.required(errorText: translate('FORM.VALIDATIONS.REQUIRED'))
                                                    ]
                                                  ),
                                                  previewImages: true,
                                                  typeSelectors: [
                                                    TypeSelector(
                                                      type: FileType.image,
                                                      selector: Row(
                                                        children: [
                                                          Icon(Icons.attach_file_rounded),
                                                          Text(translate('UTILS.SELECT_FILE'))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: _isSubmitting 
                                                        ? null 
                                                        : () async {
                                                      try {
                                                        setState(() => _isSubmitting = true);
                                                        
                                                        if (_formKey.currentState?.saveAndValidate() == false) {
                                                          setState(() => _isSubmitting = false);
                                                          return;
                                                        }
                                                      
                                                        debugPrint(_formKey.currentState?.value.toString());

                                                        _formKey.currentState?.validate();

                                                        final ReportType type = _formKey.currentState!.fields['type']?.transformedValue;
                                                        final String description = _formKey.currentState!.fields['description']?.transformedValue;
                                                        final PlatformFile media = _formKey.currentState!.fields['media']?.transformedValue[0];

                                                        final UploadReportBody body = UploadReportBody(
                                                          type: type, 
                                                          to: user.id, 
                                                          description: description, 
                                                          mediaPath: media.path!
                                                        );

                                                        await ReportsService().createReport(body);

                                                        if(context.mounted) {
                                                          Navigator.of(context).pop();
                                                          showSuccesfulAlert(context, translate('REPORTS.CREATED'));
                                                        }
                                                      } catch (e) {
                                                        if(context.mounted) {
                                                          if(e is DioException){
                                                            if(e.response != null) {
                                                              Navigator.of(context).pop();
                                                              showErrorServerAlert(context, e.response?.data);
                                                            }
                                                            else {
                                                              Navigator.of(context).pop();
                                                              showErrorServerAlert(context, {'message': 'NETWORK_ERROR'});
                                                            }
                                                          } 
                                                        }
                                                      } finally {
                                                        if (mounted) {
                                                          setState(() => _isSubmitting = false);
                                                        }
                                                      }
                                                    },
                                                    child: _isSubmitting
                                                        ? const SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        : Text(translate("REPORTS.SUBMIT")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    shape: const StadiumBorder(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flag, color: Colors.red),
                        SizedBox(width: 8),
                        Text(translate('REPORTS.REPORT_USER')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(translate('ERRORS.LOCAL.LOADING_USER')));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


class AtomUserPFP extends StatelessWidget {

  final String userThumb;
  const AtomUserPFP({super.key, required this.userThumb});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            userThumb,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[900]!, width: 2),
          ),
          child: Icon(Icons.circle, size: 12, color: Colors.white),
        ),
      ],
    );
  }
}

class MoleculeProfileHeader extends StatelessWidget {

  final SimpleUser user;
  const MoleculeProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AtomUserPFP(userThumb: user.thumb,),
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('@${user.username}', style: TextStyle(color: Colors.grey))
            ],
          )
        ],
      ),);
  }
}