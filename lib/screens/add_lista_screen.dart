// lib/screens/add_lista_screen.dart
import 'package:flutter/material.dart';
import '../models/lista.dart';
import '../services/db_helper.dart';

class AddListaScreen extends StatefulWidget {
  @override
  _AddListaScreenState createState() => _AddListaScreenState();
}

class _AddListaScreenState extends State<AddListaScreen> {
  final DBHelper dbHelper = DBHelper();
  final _nomeController = TextEditingController();

  // Adicionar uma nova lista
  void _addLista() async {
    final nome = _nomeController.text;
    if (nome.isEmpty) {
      return;
    }

    final lista = Lista(nome: nome);
    await dbHelper.insertLista(lista);  // Inserir lista no banco de dados
    Navigator.pop(context);  // Voltar para a tela de listas após adicionar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Nova Lista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Lista'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLista,
              child: Text('Criar Lista'),
            ),
          ],
        ),
      ),
    );
  }
}
