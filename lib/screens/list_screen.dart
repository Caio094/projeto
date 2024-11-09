import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import '../models/lista.dart';
import 'crud_screen.dart';
import 'list_details_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final DBHelper dbHelper = DBHelper();
  late Future<List<Lista>> listas;

  @override
  void initState() {
    super.initState();
    listas = dbHelper.getListas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todas as Listas')),
      body: FutureBuilder<List<Lista>>(
        future: listas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma lista disponível.'));
          }
          var listas = snapshot.data!;
          return ListView.builder(
            itemCount: listas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listas[index].nome),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListDetailsScreen(lista: listas[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrudScreen()),
          ).then((_) {
            setState(() {
              listas = dbHelper.getListas();
            });
          });
        },
      ),
    );
  }
}
