// lib/screens/list_screen.dart
import 'package:flutter/material.dart';
import '../models/lista.dart';
import '../services/db_helper.dart';
import 'add_lista_screen.dart'; // Importar a tela de adicionar lista
import 'list_details_screen.dart';  // Importar a tela de detalhes da lista

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final DBHelper dbHelper = DBHelper();
  late Future<List<Lista>> listas;

  @override
  void initState() {
    super.initState();
    listas = dbHelper.getListas();  // Carregar as listas
  }

  // Excluir lista
  Future<void> _deleteLista(int id) async {
    await dbHelper.deleteLista(id);  // Excluir lista do banco
    setState(() {
      listas = dbHelper.getListas();  // Atualizar a lista
    });
  }

  // Navegar para a tela de criação de lista
  void _navigateToAddListaScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddListaScreen()),  // Navegar para a tela de adicionar lista
    ).then((_) {
      setState(() {
        listas = dbHelper.getListas();  // Recarregar a lista de listas após adicionar
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas Criadas'),  // Título da tela
        actions: [
          IconButton(
            icon: Icon(Icons.add),  // Ícone de adicionar
            onPressed: _navigateToAddListaScreen,  // Chama a navegação para criar uma nova lista
          ),
        ],
      ),
      body: FutureBuilder<List<Lista>>(
        future: listas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar as listas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma lista criada.'));
          }

          final listasData = snapshot.data!;
          return ListView.builder(
            itemCount: listasData.length,
            itemBuilder: (context, index) {
              final lista = listasData[index];
              return ListTile(
                title: Text(lista.nome),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteLista(lista.id!),
                ),
                onTap: () {
                 Navigator.push(
                     context,
                      MaterialPageRoute(
                        builder: (context) => ListaDetailsScreen(lista: lista),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
