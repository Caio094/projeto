// lib/screens/lista_details_screen.dart
import 'package:flutter/material.dart';
import '../models/lista.dart';
import '../models/item.dart';
import '../services/db_helper.dart';
import 'add_item_screen.dart'; // Para adicionar/editar item

class ListaDetailsScreen extends StatefulWidget {
  final Lista lista;

  ListaDetailsScreen({required this.lista});

  @override
  _ListaDetailsScreenState createState() => _ListaDetailsScreenState();
}

class _ListaDetailsScreenState extends State<ListaDetailsScreen> {
  final DBHelper dbHelper = DBHelper();

  // Carregar os itens da lista
  Future<List<Item>> _getItens() async {
    return await dbHelper.getItens(widget.lista.id!);  // Buscando itens da lista
  }

  // Excluir item
  Future<void> _deleteItem(Item item) async {
    await dbHelper.deleteItem(item.id!);  // Excluir item do banco
    setState(() {});  // Atualizar a tela
  }

  // Navegar para a tela de adicionar ou editar item
  void _navigateToAddItemScreen(Item? item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemScreen(
          lista: widget.lista,
          item: item,
        ),
      ),
    ).then((_) {
      setState(() {}); // Recarregar a lista de itens após adicionar/editar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Lista de Compras'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddItemScreen(null),  // Navegar para adicionar novo item
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: _getItens(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os itens'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum item na lista.'));
          }

          // Exibir os itens
          final itens = snapshot.data!;
          return ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final item = itens[index];
              return ListTile(
                title: Text(item.nome),
                subtitle: Text('Preço: \$${item.preco}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _navigateToAddItemScreen(item),  // Editar item
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteItem(item),  // Excluir item
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
