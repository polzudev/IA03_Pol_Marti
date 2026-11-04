import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormD extends StatelessWidget {
  const FormD({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form D – Dades acadèmiques'),
        backgroundColor: Colors.deepOrange.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Avaluació d\'assignatura',
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
                    name: 'alumne',
                    decoration: const InputDecoration(
                      labelText: 'Nom de l\'alumne',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: 'Camp obligatori'),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderDropdown(
                    name: 'assignatura',
                    decoration: InputDecoration(
                      labelText: 'Assignatura',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'dam',
                          child: Text('Desenvolupament d\'Aplicacions Multiplataforma')),
                      DropdownMenuItem(
                          value: 'bbdd', child: Text('Bases de Dades')),
                      DropdownMenuItem(
                          value: 'prog', child: Text('Programació')),
                      DropdownMenuItem(
                          value: 'sis', child: Text('Sistemes Informàtics')),
                      DropdownMenuItem(
                          value: 'lmi',
                          child: Text('Llenguatges de Marques')),
                    ],
                    validator: FormBuilderValidators.required(
                        errorText: 'Selecciona una assignatura'),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderDropdown(
                    name: 'curs',
                    decoration: InputDecoration(
                      labelText: 'Curs',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: '1r', child: Text('1r curs')),
                      DropdownMenuItem(value: '2n', child: Text('2n curs')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Trimestre avaluat:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderRadioGroup(
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    name: 'trimestre',
                    orientation: OptionsOrientation.horizontal,
                    options: const [
                      FormBuilderFieldOption(value: '1r'),
                      FormBuilderFieldOption(value: '2n'),
                      FormBuilderFieldOption(value: '3r'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Nota final (0–10):',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderSlider(
                    name: 'nota',
                    min: 0,
                    max: 10,
                    initialValue: 5,
                    divisions: 20,
                    decoration: const InputDecoration(border: InputBorder.none),
                    displayValues: DisplayValues.current,
                  ),
                  const SizedBox(height: 16),
                  const Text('Aspectes avaluats (selecciona els que pertoquen):',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  FormBuilderCheckboxGroup(
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    name: 'aspectes',
                    orientation: OptionsOrientation.vertical,
                    options: const [
                      FormBuilderFieldOption(value: 'Examen escrit'),
                      FormBuilderFieldOption(value: 'Pràctiques'),
                      FormBuilderFieldOption(value: 'Treball en grup'),
                      FormBuilderFieldOption(value: 'Actitud i participació'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'comentaris',
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Comentaris del professor',
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
                label: const Text('Enviar avaluació'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final data = formKey.currentState!.value.toString();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Avaluació guardada'),
                        icon: const Icon(Icons.check_circle,
                            color: Colors.deepOrange),
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
