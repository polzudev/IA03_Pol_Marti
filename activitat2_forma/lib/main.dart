// Activitat 2 – Anàlisi i comentari del FormA
// Pol Martí – DAM 2n curs

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// El punt d'entrada de l'aplicació
void main() {
  runApp(const MyApp());
}

// Widget arrel sense estat; només configura el MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M0489 - Apps - Form (A)',
      theme: ThemeData(
        // Paleta de colors generada a partir del blau
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

// Pàgina principal: StatelessWidget perquè el formulari
// gestiona el seu propi estat via GlobalKey
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String title = 'Pol Martí 25/26';

  // Clau global que ens dona accés a l'estat del FormBuilder
  // (guardar, validar, llegir valors...)
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      // SingleChildScrollView evita overflow quan el teclat apareix
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Capçalera visual del formulari
            const FormTitle(),

            // FormBuilder és el contenidor principal del formulari.
            // La 'key' ens permet accedir a l'estat des del FAB.
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---- Pregunta 1: RadioGroup ----
                    // FormLabelGroup és un widget propi que mostra
                    // títol i subtítol per a cada camp
                    FormLabelGroup(
                      title: 'Quina és la velocitat del vehicle?',
                      subtitle: 'Selecciona una de les opcions',
                    ),
                    // RadioGroup: selecció única entre diverses opcions.
                    // 'name' identifica el camp dins del formulari.
                    // 'orientation' en vertical millora la llegibilitat.
                    FormBuilderRadioGroup(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      name: 'speed',
                      orientation: OptionsOrientation.vertical,
                      options: const [
                        FormBuilderFieldOption(value: 'Per sobre 40km/h'),
                        FormBuilderFieldOption(value: 'Per sota 40km/h'),
                        FormBuilderFieldOption(value: '0km/h'),
                      ],
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),

                    // ---- Pregunta 2: TextField ----
                    FormLabelGroup(title: 'Introdueix observacions'),
                    // FormBuilderTextField és equivalent a TextField però
                    // integrat al FormBuilder (es guarda automàticament)
                    FormBuilderTextField(
                      name: 'remark',
                      decoration: InputDecoration(
                        hintText: 'Escriu les teves observacions',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                      ),
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),

                    // ---- Pregunta 3: Dropdown ----
                    FormLabelGroup(
                      title: 'Velocitat màxima assolida?',
                      subtitle: 'Selecciona una opció del desplegable',
                    ),
                    // FormBuilderDropdown: llista desplegable d'opcions
                    FormBuilderDropdown(
                      name: 'highspeed',
                      decoration: InputDecoration(
                        hintText: 'Selecciona una opció',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('Alta')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Mitjana')),
                        DropdownMenuItem(value: 'low', child: Text('Baixa')),
                      ],
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),

                    // ---- Pregunta 4: CheckboxGroup ----
                    FormLabelGroup(
                      title: 'Velocitats de la darrera hora?',
                      subtitle: 'Pots seleccionar més d\'una opció',
                    ),
                    // CheckboxGroup: selecció múltiple (retorna List<String>)
                    FormBuilderCheckboxGroup(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      name: 'selectSpeed',
                      orientation: OptionsOrientation.vertical,
                      options: const [
                        FormBuilderFieldOption(value: '20km/h'),
                        FormBuilderFieldOption(value: '30km/h'),
                        FormBuilderFieldOption(value: '40km/h'),
                        FormBuilderFieldOption(value: '50km/h'),
                      ],
                      onChanged: (List<String>? value) {
                        debugPrint(value.toString());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // FAB: en prémer, guarda i valida el formulari i mostra el resultat
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () {
          // saveAndValidate() guarda els valors i comprova les regles
          _formKey.currentState?.saveAndValidate();
          // .value retorna un Map<String, dynamic> amb tots els camps
          String? formString = _formKey.currentState?.value.toString();
          alertDialog(context, formString!);
        },
      ),
    );
  }
}

// Widget reutilitzable per a les etiquetes de cada camp del formulari.
// Accepta títol obligatori i subtítol opcional.
// ignore: must_be_immutable
class FormLabelGroup extends StatelessWidget {
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  // Mostra el subtítol en gris si existeix, o un Container buit si no
  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(
        subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
              fontSizeFactor: 1.25,
              // ignore: deprecated_member_use
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withValues(alpha: 0.5),
            ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.apply(fontSizeFactor: 1.25),
          ),
          conditionalSubtitle(context),
        ],
      ),
    );
  }
}

// Capçalera del formulari: títol i descripció centrats
class FormTitle extends StatelessWidget {
  const FormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'FormA – Vehicle',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Formulari de control de velocitat',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

// Funció auxiliar que mostra un AlertDialog amb el resum del formulari
void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Enviament completat'),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Tancar'),
          child: const Text('Tancar'),
        ),
      ],
    ),
  );
}
