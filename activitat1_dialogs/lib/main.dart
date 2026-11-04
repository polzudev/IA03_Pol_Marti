import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activitat 1 – Diàlegs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // 1. SnackBar
  void _showSnackBar(BuildContext context) {
    final text = myController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Has escrit: $text'),
        backgroundColor: Colors.indigo,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Tancar',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  // 2. ModalBottomSheet
  void _showModalBottomSheet(BuildContext context) {
    final text = myController.text;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Has escrit: $text',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Tancar BottomSheet'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 3. AlertDialog
  void _showAlertDialog(BuildContext context) {
    final text = myController.text;
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Valor entrat'),
          content: Text('Has escrit: $text'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Acceptar'),
            ),
          ],
        );
      },
    );
  }

  // 4. SimpleDialog
  void _showSimpleDialog(BuildContext context) {
    final text = myController.text;
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SimpleDialog(
          title: const Text('Valor entrat'),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'Has escrit: $text',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'Tancar',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activitat 1 – Diàlegs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                labelText: 'Escriu un missatge',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Escull el tipus de diàleg:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _showSnackBar(context),
              icon: const Icon(Icons.notifications),
              label: const Text('1. SnackBar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _showModalBottomSheet(context),
              icon: const Icon(Icons.arrow_upward),
              label: const Text('2. ModalBottomSheet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _showAlertDialog(context),
              icon: const Icon(Icons.info_outline),
              label: const Text('3. AlertDialog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _showSimpleDialog(context),
              icon: const Icon(Icons.list),
              label: const Text('4. SimpleDialog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
