import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormC extends StatelessWidget {
  const FormC({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form C – Dades de salut'),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Qüestionari mèdic',
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
                  const Text('Grup sanguini:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderDropdown(
                    name: 'grup_sanguini',
                    decoration: InputDecoration(
                      hintText: 'Selecciona el teu grup',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'A+', child: Text('A+')),
                      DropdownMenuItem(value: 'A-', child: Text('A-')),
                      DropdownMenuItem(value: 'B+', child: Text('B+')),
                      DropdownMenuItem(value: 'B-', child: Text('B-')),
                      DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                      DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                      DropdownMenuItem(value: 'O+', child: Text('O+')),
                      DropdownMenuItem(value: 'O-', child: Text('O-')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Al·lèrgies conegudes:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderCheckboxGroup(
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    name: 'alergies',
                    orientation: OptionsOrientation.vertical,
                    options: const [
                      FormBuilderFieldOption(value: 'Pol·len'),
                      FormBuilderFieldOption(value: 'Fruits secs'),
                      FormBuilderFieldOption(value: 'Marisc'),
                      FormBuilderFieldOption(value: 'Làctics'),
                      FormBuilderFieldOption(value: 'Gluten'),
                      FormBuilderFieldOption(value: 'Cap al·lèrgia'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Prens medicació habitual?',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderRadioGroup(
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    name: 'medicacio',
                    orientation: OptionsOrientation.horizontal,
                    options: const [
                      FormBuilderFieldOption(value: 'Sí'),
                      FormBuilderFieldOption(value: 'No'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'medicaments',
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Llista de medicaments (si escau)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Nivell d\'activitat física:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderSlider(
                    name: 'activitat_fisica',
                    min: 0,
                    max: 10,
                    initialValue: 5,
                    divisions: 10,
                    decoration: const InputDecoration(border: InputBorder.none),
                    displayValues: DisplayValues.current,
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'observacions',
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Observacions addicionals',
                      border: OutlineInputBorder(),
                    ),
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
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  formKey.currentState?.saveAndValidate();
                  final data = formKey.currentState?.value.toString() ?? '';
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
