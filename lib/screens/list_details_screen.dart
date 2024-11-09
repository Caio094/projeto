import 'package:flutter/material.dart';
import '../models/lista.dart';

class ListDetailsScreen extends StatelessWidget {
  final Lista lista;

  ListDetailsScreen({required this.lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Lista')),
      body: Center(
        child: Text('Conteúdo da lista: ${lista.nome}'),
      ),
    );
  }
}
