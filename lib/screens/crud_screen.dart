import 'package:flutter/material.dart';
import '../models/lista.dart';
import '../services/db_helper.dart';

class CrudScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Lista')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Nome da Lista'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  Lista novaLista = Lista(nome: controller.text);
                  await dbHelper.insertLista(novaLista);
                  Navigator.pop(context);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
