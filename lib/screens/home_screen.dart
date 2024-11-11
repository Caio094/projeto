import 'package:flutter/material.dart';
import 'list_screen.dart';  // Tela para exibir as listas criadas

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),  // Definição do título
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Ver Listas',  // Texto do botão
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListScreen()),  // Navegação para as listas
            );
          },
        ),
      ),
    );
  }
}
