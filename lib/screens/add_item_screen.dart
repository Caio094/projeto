import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/db_helper.dart';
import '../models/lista.dart';

class AddItemScreen extends StatefulWidget {
  final Lista lista;
  final Item? item;

  AddItemScreen({required this.lista, this.item});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nomeController.text = widget.item!.nome;
      precoController.text = widget.item!.preco.toString();
    }
  }

  // Adicionar ou editar item
  Future<void> _saveItem() async {
    final nome = nomeController.text;
    final preco = double.tryParse(precoController.text);

    if (nome.isNotEmpty && preco != null) {
      if (widget.item == null) {
        // Adicionar novo item
        Item novoItem = Item(nome: nome, preco: preco, listaId: widget.lista.id!); // Passar listaId
        await dbHelper.insertItem(widget.lista.id!, novoItem);
      } else {
        // Editar item existente
        Item itemEditado = Item(id: widget.item!.id, nome: nome, preco: preco, listaId: widget.lista.id!); // Passar listaId
        await dbHelper.updateItem(itemEditado);
      }
      Navigator.pop(context);  // Voltar para a tela anterior
    } else {
      // Se o preço não for válido, exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um preço válido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Adicionar Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Item'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(labelText: 'Preço do Item'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text(widget.item == null ? 'Adicionar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
