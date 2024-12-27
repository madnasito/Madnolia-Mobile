import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OrganismFormBuilder extends StatelessWidget {
  const OrganismFormBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final emailKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
    key: formKey,
    child: Column(
      children: [
        FormBuilderTextField(
          key: emailKey,
          name: 'email',
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
          
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Age'),
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.always,
          validator: FormBuilderValidators.compose([
              /// Makes this field required
              FormBuilderValidators.required(),

              /// Ensures the value entered is numeric - with a custom error message
              FormBuilderValidators.numeric(errorText: 'La edad debe ser numérica.'),

              /// Sets a maximum value of 70
              FormBuilderValidators.max(70),
              FormBuilderValidators.min(1),

              /// Include your own custom `FormFieldValidator` function, if you want
              /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
              (val) {
                  final number = int.tryParse(val!);
                  if (number == null) return null;
                  if (number < 0) return 'We cannot have a negative age';
                  return null;
              },
          ]),
      ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: 'password',
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          
        ),
         MaterialButton(
           color: Theme.of(context).colorScheme.secondary,
           onPressed: () {
             // Validate and save the form values
             formKey.currentState?.saveAndValidate();
             debugPrint(formKey.currentState?.value.toString());
             // On another side, can access all field values without saving form with instantValues
             formKey.currentState?.validate();
             debugPrint(formKey.currentState?.instantValue.toString()
             );
             
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}