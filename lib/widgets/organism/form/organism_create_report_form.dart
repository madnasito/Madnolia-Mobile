import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madnolia/services/reports_service.dart';
import 'package:toast/toast.dart';

import '../../../i18n/strings.g.dart';
import '../../../models/reports/dto/create_bug_report_dto.dart';
import '../../../models/reports/enum/bug_report_type.dart';
import '../../molecules/buttons/molecule_form_button.dart';
import '../../molecules/form/molecule_dropdown_form_field.dart';
import '../../molecules/form/molecule_text_form_field.dart';

class OrganismCreateReportForm extends StatefulWidget {
  const OrganismCreateReportForm({super.key});

  @override
  State<OrganismCreateReportForm> createState() =>
      _OrganismCreateReportFormState();
}

class _OrganismCreateReportFormState extends State<OrganismCreateReportForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _reportsService = ReportsService();
  XFile? _imageFile;
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (_imageFile == null) {
        Toast.show(
          t.FORM.VALIDATIONS.REQUIRED_FIELD,
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
        );
        return;
      }

      setState(() {
        _isSubmitting = true;
      });

      try {
        final values = _formKey.currentState!.value;
        final dto = CreateBugReportDto(
          type: values['type'] as BugReportType,
          description: values['description'] as String,
          media: await MultipartFile.fromFile(
            _imageFile!.path,
            filename: _imageFile!.name,
          ),
        );

        await _reportsService.createBugReport(dto);

        if (mounted) {
          Toast.show(
            t.REPORTS.CREATED,
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          Toast.show(
            t.CREATE_MATCH.ERROR,
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          MoleculeDropdownFormField(
            name: 'type',
            label: t.REPORTS.SELECT_TYPE,
            initialValue: BugReportType.appBug,
            icon: Icons.bug_report,
            items: [
              DropdownMenuItem(
                value: BugReportType.appBug,
                child: Text(
                  t.REPORTS.APP_BUG,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: BugReportType.other,
                child: Text(
                  t.REPORTS.OTHER,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MoleculeTextField(
            name: 'description',
            label: t.UTILS.DESCRIPTION,
            icon: Icons.description,
            keyboardType: TextInputType.multiline,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: t.FORM.VALIDATIONS.REQUIRED,
              ),
              FormBuilderValidators.minLength(
                10,
                errorText: t.FORM.VALIDATIONS.MIN_LENGTH(count: 10),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: _imageFile == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image, size: 50, color: Colors.blue),
                        const SizedBox(height: 10),
                        Text(
                          t.UTILS.SELECT_FILE,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 30),
          MoleculeFormButton(
            text: t.REPORTS.SUBMIT,
            onPressed: _submitReport,
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );
  }
}
