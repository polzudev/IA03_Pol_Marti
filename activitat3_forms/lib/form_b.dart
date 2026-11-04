import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormB extends StatelessWidget {
  const FormB({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form B – Dades personals'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Registre d\'usuari',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilderTextField(
                    name: 'nom',
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: 'El nom és obligatori'),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'cognoms',
                    decoration: const InputDecoration(
                      labelText: 'Cognoms',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: 'Els cognoms són obligatoris'),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Correu electrònic',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'El correu és obligatori'),
                      FormBuilderValidators.email(
                          errorText: 'Format de correu incorrecte'),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'telefon',
                    decoration: const InputDecoration(
                      labelText: 'Telèfon',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  FormBuilderDateTimePicker(
                    name: 'data_naixement',
                    inputType: InputType.date,
                    decoration: const InputDecoration(
                      labelText: 'Data de naixement',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Gènere:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderRadioGroup(
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    name: 'genere',
                    orientation: OptionsOrientation.horizontal,
                    options: const [
                      FormBuilderFieldOption(value: 'Home'),
                      FormBuilderFieldOption(value: 'Dona'),
                      FormBuilderFieldOption(value: 'Altre'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FormBuilderDropdown(
                    name: 'pais',
                    decoration: InputDecoration(
                      labelText: 'País',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'es', child: Text('Espanya')),
                      DropdownMenuItem(value: 'fr', child: Text('França')),
                      DropdownMenuItem(value: 'de', child: Text('Alemanya')),
                      DropdownMenuItem(value: 'it', child: Text('Itàlia')),
                      DropdownMenuItem(value: 'other', child: Text('Altre')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final data = formKey.currentState!.value.toString();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Formulari enviat'),
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        content: Text(data),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tancar'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
